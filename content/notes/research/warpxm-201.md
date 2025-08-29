---
title: "WARPXM 201 - Unstructured Geometry"
bookToc: true
---

{{< katex display >}}

{{< /katex >}}

Let's try to make sense of the unstructured geometry library that WARPX uses to work with unstructured meshes

# Mesh Loading

## `WmDomain().setup()`

We construct the WmDomain for the sim.

{{< mermaid >}}
%%{init: {
  'themeVariables': {
    'fontFamily': 'monospace'
  }
}}%%
classDiagram
    class WmDomain {
	    -WmSolverBase* _parentSolver : Owning WmSolver
	    -int* _primitive_id : Element primitive type, e.g. tets, hexahedrons, triangles
	    -map _patches
	    -map _localPatches
	    -vector _clusterDeviceIndex
	    -vector _clusterDeviceNodeRank
	    -vector _clusterDeviceWeights
    }

{{< /mermaid >}}

First Determine the total number of compute devices in the MPI cluster. Set up `_clusterDeviceIndex`, `_clusterDeviceWeights` for the mesh distribution algorithm.

Then, we get into the mesh setup and leave `Wm` world for a bit. We'll spend a bunch of time in `UC` land, but we'll come back.

## `wxm::mesh::mesh.setup()`

Read mesh from the input file, and do `wxm::mesh::mesh.setup()`. This is where we subclass mesh to arbitrary mesh and split from block mesh impl.

- Makes a new `UCDomain` and does `UCDomain->importFile`. `UCDomain` has a `UCElementGroup _domain` that does `UCElementGroup->importFile` to load the mesh file. There are reader functions for ABAQUSFile, HDF5, and GAMBITFile, which should all basically be doing the same thing. Let's go through the ABAQUS parser.


{{< mermaid >}}
%%{init: {
  'themeVariables': {
    'fontFamily': 'monospace'
  }
}}%%
classDiagram
    class UCElementGroup {
      -std::string _name : Element group name
      -int _index
      -int _partitionIndex
      -bool _virtual
      -int _primitiveID : Primitive type of all elements
      -UCElementGroup* _parent
      -vector~UCElementGroup*~ _children
      -vector~UCElementGroup*~ _virtualChildren
      -vector~UCNodeGroup*~ _nodeGroups : Associated node groups
      -int _numLayers : Number of layers this group is set up for
      -vector~int~ _numElements : # of elements per layer
      -vector~int~ _numNodes : # of nodes per layer
      -vector~UCElement*~ _elements
      -vector~UCNode*~ _nodes
      -UCElement* _nullElement : Non-existent element that represents the exterior of the domain
      -int _meshID
    }
    class UCDomain {
	    -UCElementGroup* _domain : The real domain
    }
{{< /mermaid >}}


- Look for NODES block. For each line in the block, the line is `<ID>, <xpos>, <ypos>, <zpos>`. We create a new `UCNode` with the node ID, the position in each dimension, and we add a `nodeGlobalIndex` that goes from 0 to total_nodes. Add the node to the UCElementGroup's `std::vector<UCNode*> _nodes`.
- Look for ELEMENT block. Each element block will be a subdomain containing one or more elements of the same type. For each subdomain, set `primitiveID` based on the node type (hexahedra "C3D8R" have `primitiveID = 4`, tets "C3D4" have `primitiveID = 3`, quadrilaterals "S4R" have `primitiveID = 2`, "STRI3" triangles have `primitiveID = 1`, and lines "B21" have `primitiveID = 0`). We create a new subdomain `UCElementGroup` and add it to the `_children` list of the parent UCElementGroup. Then we read in each element from the element block. Element definitions are `<element ID>, <node1 ID>, <node2 ID>...` for however many nodes are in each element.
  - For each element we build up a `vector<UCNode*> connectivity` list of pointers to the `UCNode`s in `_nodes` that define the nodes in the element. Then we create a `UCElement` with the element ID (mesh's ID for the element), the connectivity list of nodes, the primitiveID (element type), and a globally incrementing `elementGlobalIndex`. The element contains all of those fields, and we also initialize an empty `_neighborhood` vector of neighboring elements, and `_orientations` vector of face normals. We add this element to the `_elements` vector for this UCElementGroup.


{{< mermaid >}}
%%{init: {
  'themeVariables': {
    'fontFamily': 'monospace'
  }
}}%%
classDiagram
    class UCElement {
      -int _elementID : Element ID as defined in input file
      -int _globalIndex : Global element index
      -int _primitiveID : Type of element
      -vector~UCElement*~ _neighborhood : List of refs to neighboring UCElements
      -vector~UCNode*~ _connectivity : Sorted list of nodes in the element
      -vector~int~ _orientations : For each face, defines the "orientation" of the face w.r.t. its neighboring element
    }
    class UCNode {
      -int _globalIndex : Global index of node in full mesh
      -int _effectiveIndex : Effective global index used for sorting nodes
      -int _id : Node id from input file
      -real _position[3] : Geometric coordinates
      -vector~UCNode*~ _overlapNodes : Periodic boundary mirror node(s)
      -vector~UCNodeGroup*~ _nodeGroups : Node groups this node is assigned to
    }
    class UCLayeredObject {
      -map~UCElementGroup*, int~ _layers: Map of layers
      -map~UCElementGroup*, int~ _indexes: Map of indexes
      -map~UCElementGroup*, bool~ _addedToGroup : Map if object has been added to given group
    }
    UCElement <|-- UCLayeredObject
    UCNode <|-- UCLayeredObject
{{< /mermaid >}}


- Then we look for node set groupings defined in a `NSET` block. Each ABAQUS node set has a string name and a list of node IDs. In our code, we represent the node set as a `UCNodeGroup`, which is just a list of `UCNode` pointers along with the group's name.

{{< mermaid >}}
%%{init: {
  'themeVariables': {
    'fontFamily': 'monospace'
  }
}}%%
classDiagram
    class UCFace {
      -UCElement* _element
      -int _faceIndex : Indicates which face of the element we are. Ordering is standard and defined by the input file
      -vector~int~ _sortedNodes : Effective node indexes making up the face
    }
{{< /mermaid >}}


- Finally we call `UCElementGroup.interlinkElements()`
  - Here, we check if periodic boundary conditions were defined. These would be defined as a list of matched name-name pairs describing which `UCNodeGroup`s should be matched as the same periodic boundary. If so, we go through all of the pairs of matched `UCNodeGroup`s, sort all of the nodes by position, and add an overlap node to the `_overlapNodes` list for each appropriate node.
  - We make a list of `UCFace`s for each face of each element. To construct a `UCFace`, we fill `_sortedNodes` with the connectivity list for the element, using a pre-defined ordering of nodes as appropriate for the element. For example, for a tetrahedral element, the indices of nodes for each face are "faceIndex = [[0,2,1],[0,1,3],[1,2,3],[0,3,2]]". Then we sort the face list so that matching faces are lined up with one another. We iterate through each face in the list. For each one, if the next face in the list has the same set of nodes, then they are overlapping faces and correspond with neighboring elements. We register each element in its neighbor's `_neighborhood` list for the appropriate face. If there isn't a neighbor, we leave the nullElement in the element's neighborhood for that face index. We also compute the "orientation" of each face by setting an int value in the corresponding spot in the element's `_orientations`. I'm in agreement with the comments through `UCFace.cc`, I'm not exactly sure what the orientation values mean, but for 2D elements the orientation is 0 or 1 for each "face", depending if the lines are parallel or anti-parallel when read from the faces' connectivity list. There is a similar, but more complicated calculation for 3D elements that gives 0, 1, or 2 for tetrahedra. It seems to be a way of aligning the nodes for neighboring faces, but the only place I can find that uses the orientation information is `WmUnstructuredGeometry::getFaceDistanceBetweenNeighborCentroids()`, so we'll probably have to come back to this.
  - Now that all of the elements in the UCElementGroup have had their periodic boundary conditions, neighborhood, and orientation set, we are done with the face list, never to be seen again.
- Then, we get a chance to apply "layers" to the domain. According to Sean's dissertation, this is how we group elements that are the same number of steps away from the patch boundary. Elements with layer 0 are on the boundary, and elements with layer -1 are not on the boundary but are neighboring a layer 0 element. This is supposed to define the layout of the element data arrays such that "interior", "periphery", and "external" element sets can be stored contiguously and separately to minimize MPI overhead. `applyLayers` is a monster, so let's step through carefully.
  - We start with a UCElementGroup that has one child domain, so we `applyLayers` recursively to the children first
  - For each element in the group, we run `applyLayering()` on the element. This iterates over all of the nodes in `_connectivity` and sets the layer of all nodes to MIN_LAYER, and associates the UCElementGroup with the node. Then, if the element is on the boundary of that group's domain (we test by checking if all the element's neighbors are in the same group), we set its layer to 0 and recursively re-calculate layers for each of its neighbors.
  - Once that's done, each element in the group should have group layering information associated. We sort the group's element list by layer, then we assign a monotonically increasing group index to the element's `_indexes[&group]` and count the number of elements in each layer, storing the result in the group's `_numElements`. We also do the same thing for the `_nodes` list, sorting by layer, assigning a group index, and counting by layer into `_numNodes[_numLayers + 1 + layer]`.
  - Once all subdomains have been layered, we call `consolidate()` on the parent domain. This re-assigns a group index for all of the internal elements to try and create contiguous chunks of elements.


After all that, we've got a fully initialized UCDomain that contains the entire mesh. Next thing we do is partitioning into patches!

- Start by defining the total number of partitions, based on input parameters and MPI ranks
- For each subdomain, construct adjacency vector by and constructing `xadj` and `adjncy` from the list of elements, in the format described in 5.5 of the METIS manual. We don't set any vertex weights or edge weights. Pass that all in to METIS PartGraphRecursive and we get `part` which is a list of size numElements that tells us which partition each element index should belong to. The patches are each stored as child UCElementGroup subdomains, and we assign each element to one of those groups.
- After partitioning is done, we go back through the `applyLayers()` process all over again for each subdomain to assign layers to the re-distributed elements. Yowch.


Back in mesh set-up, we convert our `UCElementGroup`s to `WmUnstructuredPatch`es, and add them to the `WmDomain`.

{{< mermaid >}}
%%{init: {
  'themeVariables': {
    'fontFamily': 'monospace'
  }
}}%%
classDiagram
    class WmUnstructuredPatch {
      -string _name
      -int _patchIndex
      -string _subdomainName
      -int _primitiveID
      -WmDomain* _domain : Parent domain
      -bool _local
      -int _procID
      -int _numLayers
      -int* _numElementsPerLayer
      -int __numTotalElements
      -int _meshID
      -int _pMeshID
      -int* _meshTranslation : Mapping of patch element indexes to "global" mesh indexes
      -int* _numNodesPerLayer : Total nodes in each layer
      -int _numTotalNodes
      -WmUnstructuredGeometry* _pUG
      -map~int, WmUnstructuredPatchLink*~ _linkedPatches : Linked patches, indexed by 'from' group index
      -WxRange _patchRange : Range of patch within subdomain
      -WxRange _subdomainRange : Range of subdomain
    }
{{< /mermaid >}}


- For each `WmUnstructuredPatch`, we start by constructing a `UCElementGroupLinkSet` of links from its neighboring `UCElementGroup`s to itself. The resulting set of links describe the interfaces between element group for this patch and the `UCElementGroup`s that are its neighbors. Continuing the conversion process, we convert those links to `WmUnstructuredPatchLink`s and add them to the `_linkedPatches` in our patch.

{{< mermaid >}}
%%{init: {
  'themeVariables': {
    'fontFamily': 'monospace'
  }
}}%%
classDiagram
    class UCElementGroupLink {
      -UCElementGroup& _fromGroup : Group in which element is 'internal'
      -UCElementGroup& _toGroup : Group in which element is 'external'
      -vector~UCElement*~ _elements : Elements constituting the link
      -int _numIndexes
      -vector~int~ _fromIndexes : Indexes of elements in fromGroup
      -vector~int~ _toIndexes : Indexes of elements in toGroup
      -vector~int~ _numElementsPerLayer : Number of elements in each layer of link
  }
{{< /mermaid >}}


{{< mermaid >}}
%%{init: {
  'themeVariables': {
    'fontFamily': 'monospace'
  }
}}%%
classDiagram
    class WmUnstructuredPatchLink {
      -WmUnstructuredPatch& _to_patch
      -WmUnstructuredPatch* _from_patch
      -bool _sharedBoundary : Whether the link is between two neighboring patches in the same domain
      -string _from_patch_name
      -int _from_patch_index : Index of the 'from' patch
      -vector~int~ _numElementsPerLayer : Number of elements in each element layer
      -int _numElements : Number of elements in the link
      -vector~int~ _from_indexes : Element indexes in the 'from' patch to pull from
      -vector~int~ _to_indexes : Element indexes in the 'to' patch to push to
  }
{{< /mermaid >}}

- We then set the patch range by creating two one-dimensional `WxRange`s. The first is the `_patchRange` which contains the range of absolute element indexes in the patch's parent domain (e.g. [0..12345] for one patch, then [12346..54321] for another). The `_subdomainRange` contains the entire parent domain's range (e.g. [0..54321]).

{{< mermaid >}}
%%{init: {
  'themeVariables': {
    'fontFamily': 'monospace'
  }
}}%%
classDiagram
    class WxRange {
    }
    class WxBox~int~ {
      -int _ndims : Number of dimensions this box spans
      -int[8] _lower : Lower index in each dimension
      -int[8] _upper : Upper index in each dimension
      -int[8] _length : [upper - lower]
    }
    WxBox~int~ <|-- WxRange
{{< /mermaid >}}

- Next we add index information to the `WmUnstructuredPatchLink`s by copying the index arrays from the corresponding `UCElementGroupLink`s. These are the element index mappings between the two patch/groups.

{{< mermaid >}}
%%{init: {
  'themeVariables': {
    'fontFamily': 'monospace'
  }
}}%%
classDiagram
    class WmUnstructuredGeometry {
      -WmUnstructuredPatch& _patch
      -string _primitive
      -int _primitiveID
      -int _numElements
      -int _numNodes
      -int* _connectivity : [_numElementx X _numNodesPerElement]
      -int* _neighborhood : [_numElements X _numFacesPerElement]
      -int* _orientations : [_numElements X _numFacesPerElement]
      -real* _coordinates : Node/vertex positions
      -real* _transformCoordinates
      -real* _centroids : Position of element centroids
      -real* _norms : Face normal vectors
      -real* _volumes : Element volumes
      -real* _areas : Face areas
      -map~string, vector[int]~ _nodeGroups : Named groups of nodes defined for boundary conditions
      -int _num_boundary_faces : # of faces with neighbor = -1
      -int _numDimsPerNode : # Dimensions used to store nodes/vertices
      -int _numDimsPerPrimitive
      -int _numTransformCoordinates
      -int _numNodesPerElement : # Physical nodes unrelated to DG order
      -int _numFacesPerElement
      -int _numNodesPerFace
    }
{{< /mermaid >}}

- Now we get to the fun stuff: Generating a full `WmUnstructuredGeometry` for each local patch. By 'local' we mean patches that are assigned to the local compute device.
  - We can get `_coordinates`, `_connectivity`, `_neighborhood`, and `_orientations` just by iterating over the structures in `UCElementGroup` and constructing some new contiguous arrays with the right values. For neighborhood, instead of pointers to elements or `_nullElement` we just fill with the element's group index or -1 for null neighbors.
  - To get the rest, we rely on the various `generateEG` (generate element geometry) and `generateCentroid` functions defined for each element type in wmunstructuredgeometry.cc. For each element:
    - `nodePositions` is the list of `[x1, y1, z1, x2, y2, z2, ...]` node locations for each element, with nodes in order of the connectivity array for the element.
    - transformed coordinates `tC` are the coefficients \\( \Gamma \\) of the affine transformation from the isoparametric space (e.g. where the tetrahedron is defined by the coordinates [0, 0], [0, 1], [1, 0], [1, 1]) to the coordinate space such that \\( x = \Gamma_0 + \Gamma_1 \xi_0 + \Gamma_2 \xi_1 + \Gamma_3 \xi_2  \\). These are the elements of the coveted coordinate transform Jacobian matrix.
    - We compute the centroid coordinates and add them at `_centroids[3 * elementIndex]`
    - We do some math to fill in the parts of `_norms`, `_volumes`, and `_areas` associated with the element.
    - To finish up, we iterate over the `_neighborhood` to check for boundary faces (-1's), and tally them up in `_num_boundary_faces`
- If there are multiple patches in a subdomain, we may need the global element indexes to apply initial conditions that may have been generated for the mesh before partitioning. So we search up through the parent domain, compute an index offset based on the number of elements in each sibling patch, and add that offset to our element indexes to get a `_meshTranslation` that gives the "global" index for each element.
- For boundary condition definition, we need to group together all of the nodes that are defined on a node set in the mesh (see NSET above). We just plop the sorted node indexes from each `UCNodeGroup` right into the `_nodeGroups` map for our patch's WmUnstructuredGeometry.

At this point, the mesh geometry structure is fully initialized. On rank 0, we write out the top-level `UCDomain` to disk in hdf5 format using `UCElementGroup::write`.

{{< mermaid >}}
%%{init: {
  'themeVariables': {
    'fontFamily': 'monospace'
  }
}}%%
classDiagram
    class WmBasisArraySet {
      -int _two_num_flux_arrays_flag
      -int _numFacesPerElement
      -int _numFacesPerElementSquares
      -int _numFaceNodes
      -int _numFaceNodesSquares
      -int _numTotalFaceNodes
      -int _numTotalFaceNodesDeduplicated
      -int _numInternalNodes
      -int _numTotalNodes
      -int _numGaussQuadNodes
      -int _numDims : Actual dimensionality of elements
      -int _numDimsUnstruct : Number of unstructured dimensions
      -int _numOrientations
      -int _spatialOrder
      -int _numInteriorPositivityPreservingQuadNodes
      -real _vol_multiplier
      -int _numSubElements
      -int _numNodesPerSubElement
      -vector~int~ _subElementConnectivity
      -int _basisArray_NumericalFlux_Size
      -int _basisArray_NumericalFlux_altFace_Size
      -int _basisArray_InternalFlux_Size
      -int _basisArray_LinearAverage_Size
      -int _basisArray_LinearCenter_Size
      -int _basisArray_MonomialConversion_Size
      -int _basisArray_Derivative_Approximation_Size
      -real _cfl
      -int _num_face_types : Used for e.g. phase space mixed elements
      -vector~int~ _num_faces_per_face_type
      -vector~int~ _num_face_nodes_per_face_type
      -vector~int~ _num_face_nodes_per_face
      -vector~int~ _faceNodesDeduplicated
      -vector~real~ _nodePositionsGaussQuad
      -vector~real~ _basisArray_GaussQuad
      -vector~real~ _basisArray_LagrangeOnGQnodes
      -vector~real~ _nodePositions
      -vector~real~ _basisArray_NumericalFlux
      -vector~real~ _basisArray_NumericalFlux_altFace : Alternate num. flux for velocity space
      -vector~real~ _basisArray_InternalFlux
      -vector~real~ _basisArray_LinearAverage
      -vector~real~ _basisArray_LinearCenter
      -vector~real~ _basisArray_MonomialConversion
      -vector~real~ _basisArray_OrthogonalToCollocation
      -vector~real~ _basisArray_CollocationToOrthogonal
      -vector~function[real(const array[real], 3]&)~ _monomial_functions
      -vector~real~ _basisArray_Derivative_Approximation
      -vector~real~ _basisArray_faceQuadratureWeights
      -vector~real~ _basisArray_evaluateAtInteriorPositivityPreservingQuadNodes
      -vector~vector[int]~ _orientations
      -vector~vector[int]~ _faceNodes
      -bool _has_csr
      -vector~int~ _ups2csr_val_lengths
      -vector~vector[real]~ _ups2csr_val
      -vector~vector[int]~ _ups2csr_col
      -vector~vector[int]~ _ups2csr_rowptr
      -vector~int~ _Drcsr_val_lengths
      -vector~vector[real]~ _Drcsr_val
      -vector~vector[int]~ _Drcsr_col
      -vector~vector[int]~ _Drcsr_rowptr
      -vector~int~ _ups1csr_val_lengths
      -vector~vector[real]~ _ups1csr_val
      -vector~vector[int]~ _ups1csr_col
      -vector~vector[int]~ _ups1csr_rowptr

    }
{{< /mermaid >}}


If the input file specifies that it wants a nodal mesh to be written out as well, then we compute the basis arrays for
the dimension and nodal order specified in the input file.

- Lucky for us, at this point we're just reading out the pre-computed values stored in the appropriate `src/basis/nodal_basis/*.txt` file.
- In `UCElementGroup::exportBasisDecomposition()` constructs the sub-elements and sub-coordinates of the basis nodes on each element for export. The fields we end up with in the hdf5 output are `patchIndexes`, `subElementConnectivity`, `patchNames`, `startingElementIndexes`, `startingSubElementIndexes`, `coordinates`, `connectivity`, and `element_connectivity`.
- Write out the `plotMesh` hdf5 file containing all of the basis node locations and connectivity arrays, to make post-processing easier.

Finally we write out a restart mesh in hdf5 format using `UCElementGroup::exportWithoutBasisDecomposition`. This works similarly to the basis export, but it only contains `coordinates` and `connectivity`. This generates the `restartMesh*.h5` files in the meshes/ directory.

# Distributed Variables

Now we've got a working `WmDomain`, we iterate through the `variable_t`s from the input file and call `setup()` to initialize it.

{{< mermaid >}}
%%{init: {
  'themeVariables': {
    'fontFamily': 'monospace'
  }
}}%%
classDiagram
    class wxm::variable::variable_t {
      -vector~string~ _component_names : List of component names in order
      -WmSolverBase* _p_parent
      -bool _is_setup
    }
    class wxm::variable::distributed_variable_t {
      -vector~string~ _subdomain_names
      -vector~string~ _virtual_subdomains
    }
    class wxm::dfem::variable::UniqueDistributedVariable {
      -vector~string~ _subdomain_names
      -vector~string~ _virtual_subdomains
      -vector~UniqueDistributedComponent*~ _component_arrays : Where the data is stored
      -WxRange _element_range : Range of each element
    }
{{< /mermaid >}}
