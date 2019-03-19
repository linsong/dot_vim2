XPTemplate priority=lang keyword=:%#

" containers
let s:f = g:XPTfuncs()

" inclusion
XPTinclude
			\ _common/common

" ========================= Function and Variables =============================

" Repeat an item inside its edges.
" Behave like ExpandIfNotEmpty() but within edges
fun! s:f.RepeatInsideEdges(sep) "{{{
	let [edgeLeft, edgeRight] = self.ItemEdges()
	let v = self.V()
	let n = self.N()
	if v == '' || v == self.ItemFullname()
		return ''
	endif


	let v = self.ItemStrippedValue()
	let [ markLeft, markRight ] = XPTmark()

	let newName = 'n' . n
	let res	= edgeLeft . v
	let res .= markLeft . a:sep .	markLeft . newName . markRight
	let res .= 'ExpandIfNotEmpty("' . a:sep . '", "' . newName . '")' . markRight . markRight
	let res .=	edgeRight


	return res
endfunction "}}}

" ================================= Snippets ===================================

XPT if " if {}
if `condition^ {
	`cursor^
}

XPT ifs " if v := v {}
if `var^ := `value^; `condition^ {
	`cursor^
}

XPT ife " if {} else {}
XSET statement=//statement
if `condition^ {
	`statement^
} else {
	`cursor^
}

XPT ifes " if v := v; {} else {}
XSET statement=//statement
if `var^ := `value^; `condition^ {
	`statement^
} else {
	`cursor^
}

XPT ifc " if {} else if {}.. else .. end
XSET statement=//statement
if `condition^` {
	`statement^
``elsif...`
{{^} else if `ncondition^ {
	`statement^
``elsif...`
^`}}^``else...`
{{^} else {
	`cursor^
`}}^}

XPT ifcs " if v := v; {} else if {}.. else .. end
XSET statement=//statement
if `var^ := `value^; `condition^` {
	`statement^
``elsif...`
{{^} else if `ncondition^ {
	`statement^
``elsif...`
^`}}^``else...`
{{^} else {
	`cursor^
`}}^}

XPT for " for v := v; c; inc
for `var^ := `value^; `condition^; `increment^ {
	`cursor^
}

XPT fori " for i:=0;i<stuff;i++{}
XSET var|pre=i
XSET value|pre=0
XSET inc|pre=++
for `var^ := `value^; `var^ < `upperbnd^; `var^`inc^ {
	`cursor^
}

XPT f " for i:=0;i<stuff;i++{}
for `init...{{^`var^ := `val^`}}^;`cond...{{^ `condition^`}}^;`inc...{{^ inc`}}^ {
	`cursor^
}

XPT forr " for i, v := range
XSET i|pre=_
for `i^, `v^ := range `rangevar^ {
	`cursor^
}

XPT fun " function
XSET params*|post=RepeatInsideEdges(', ')
func `receiver...{{^(`recv^) `}}^`name^(`params*^)` `returns?^ {
	`cursor^
}

XPT d " a,b,c := d,e,f
XSET vars*|post=RepeatInsideEdges(', ')
XSET vals*|post=RepeatInsideEdges(', ')
`vars*^ := `vals*^`cursor^

XPT e " v,err := func
XSET params*|post=RepeatInsideEdges(', ')
`v^, `err^ := `func^(`params*^)`cursor^

XPT sli "v := make ([]type, size, cap)
`v^ := make([]`type^`, `size^`, `cap?^)`cursor^

XPT map "v := make (map[type1]type2, cap)
`v^ := make(map[`type1^]`type2^`, `cap?^)`cursor^

XPT st " type Struct struct { types... }
type `name^ struct {
``...`
{{^	`name^ `type^
``...`
^`}}^}`cursor^

XPT in " type Struct interface { types... }
XSET params*|post=RepeatInsideEdges(', ')
type `name^ interface {
``...`
{{^	`fnname^(`params*^)` `returns?^
``...`
^`}}^}`cursor^
