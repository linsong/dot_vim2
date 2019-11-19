XPTemplate priority=personal

let s:f = g:XPTfuncs()

" use snippet 'varConst' to generate contant variables
" use snippet 'varFormat' to generate formatting variables
" use snippet 'varSpaces' to generate spacing variables


XPTinclude
    \ _common/common


XPT script wrap=content "script template
<script type="text/template" id="`content_tpl^">
  <div>
    `content^`cursor^
  </div>
</script>

