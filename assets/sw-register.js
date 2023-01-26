{{- $swJS := resources.Get "sw.js" | resources.ExecuteAsTemplate "sw.js" . -}}
// Default service worker registration script from hugo-book only works properly if site is rendered from /, which is not the case on github pages, so instead I provide my own script.
if (navigator.serviceWorker) {
  navigator.serviceWorker.register(
    "{{ $swJS.RelPermalink }}", 
    { scope: "{{ "" | relURL }}" }
  );
}
