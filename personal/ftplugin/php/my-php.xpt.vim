XPTemplate priority=personal+

" inclusion
XPTinclude
      \ _common/common

XPTemplateDef

XPT log
error_log(`cursor^);

XPT L wrap=text
L('`text^');`cursor^

