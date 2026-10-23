; extends
;
; Plantillas Go dentro de HTML (html/template, *.tmpl, *.gohtml, *.html.tmpl).
;
; El parser "html" no entiende {{ ... }}: para él todo el bloque es un nodo de
; texto, así que las expresiones Go no se colorean. Aquí se inyecta el parser
; "gotmpl" (tree-sitter-go-template) en los nodos de texto y en los valores de
; atributo que contienen una directiva, de modo que el HTML conserva su propio
; resaltado y las expresiones Go se resaltan aparte.
;
; El modeline "; extends" es obligatorio: sin él Neovim usa esta query como
; base y descarta la de nvim-treesitter (o al revés) en vez de combinarlas.
;
; Requiere el parser "gotmpl" (:TSInstall gotmpl).
;
;   <div class="{{ .C }}">{{ .Name }}</div>
;   ^^^^^^^^^^^^^^^^ html    ^^^^^^^^^ gotmpl

((text) @injection.content
  (#match? @injection.content "\\V{{")
  (#set! injection.language "gotmpl"))

((attribute_value) @injection.content
  (#match? @injection.content "\\V{{")
  (#set! injection.language "gotmpl"))
