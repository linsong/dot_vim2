XPTemplate priority=personal

let s:f = g:XPTfuncs()

" use snippet 'varConst' to generate contant variables
" use snippet 'varFormat' to generate formatting variables
" use snippet 'varSpaces' to generate spacing variables

XPTinclude
    \ _common/common

XPT adoc " tips about what this snippet does
= `TITLE^
`EasyIO^ <`support@easyio.com^>
1.0, `strftime("%Y-%m-%d")^
:toc:
:toclevels: `4^
:icons: font
:imagesdir: assets
:hide-uri-scheme:
:source-highlighter: pygments
:linkattr:
:experimental:

`cursor^

XPT note "create a Admonitions
XSET level=Choose(['NOTE', 'TIP', 'IMPORTANT', 'CAUTION', 'WARNING'])
[`level^]
====
`cursor^
====

XPT image "create a image block 
image::`path^[`cursor^]

XPT * wrap=string wraponly " bold string
*`string^*`cursor^

XPT `* wrap=string wraponly " bold italic string
\`*`string^*``cursor^

XPT table "create a table 
|===
| `Name^ `col...^ | `^ `col...^

`row...^| `^ `col2...^ | `^ `col2...^
`row...^
|===
`cursor^

XPT source " source code snippet
[source,`javascript^]
----
`cursor^
----


