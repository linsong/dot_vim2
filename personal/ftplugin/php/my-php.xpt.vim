XPTemplate priority=personal+

" inclusion
XPTinclude
      \ _common/common

XPTemplateDef

XPT log
error_log(`cursor^);

XPT L wrap=text
L('`text^');`cursor^

XPT header " php file header
<?php 
// vim: ts=2 sw=2
`cursor^
?>

XPT l18n wrap=text
<?php echo L('`text^') ?>`cursor^
