let c_no_curly_error=1
" Vim syntax file
" Language:	C++
" Maintainer:	Ken Shan <ccshan@post.harvard.edu>
" Last Change:	2002 Jul 15

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" Read the C syntax to start with
if version < 600
  so <sfile>:p:h/c.vim
else
  runtime! syntax/c.vim
  unlet b:current_syntax
endif

" C++ extentions
syn keyword cppStatement	new delete this friend using
syn keyword cppAccess		public protected private
syn keyword cppExceptions	throw try catch
syn keyword cppOperator		operator typeid
syn keyword cppOperator		and bitor or xor compl bitand and_eq or_eq xor_eq not not_eq
syn match cppCast		"\<\(const\|static\|dynamic\|reinterpret\)_cast\s*<"me=e-1
syn match cppCast		"\<\(const\|static\|dynamic\|reinterpret\)_cast\s*$"
syn keyword cppStorageClass	mutable
syn keyword cppStructure	class typename namespace
syn keyword cppNumber		NPOS
syn keyword cppBoolean		true false

" The minimum and maximum operators in GNU C++
syn match cppMinMax "[<>]?"

" Default highlighting
if version >= 508 || !exists("did_cpp_syntax_inits")
  if version < 508
    let did_cpp_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif
  HiLink cppAccess		cppStatement
  HiLink cppCast		cppStatement
  HiLink cppExceptions		Exception
  HiLink cppOperator		Operator
  HiLink cppStatement		Statement
  HiLink cppType		Type
  HiLink cppStorageClass	StorageClass
  HiLink cppStructure		Structure
  HiLink cppNumber		Number
  HiLink cppBoolean		Boolean
  delcommand HiLink
endif

let b:current_syntax = "cpp"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" lvv
syn clear	  cppStorageClass
syn keyword	cppStorageClass	static register auto volatile extern const extern external void explicit virtual


""""""""""""""""""""""""""""""""" general keywords
syn keyword	cppStatement	new delete this friend return 
hi def link cStatement		Statement
hi def link cppStatement	Statement
hi def link cReturn		Statement
hi 	Statement	ctermfg=179

" errors
"syn keyword		DoError           
"hi DoError		ctermfg=133
hi cppExceptions	ctermfg=133

syn keyword		cppOut           cerr cout endl hex dec setw flush setfill scientific setprecision fixed boolalpha noboolalpha 
syn match 		cppOut		"<<"
hi cppOut		ctermfg=105


"""""""""""""""""""""""""""""""" Structures
syn clear	cStructure
syn clear	cppStructure	
syn keyword	cStructure	class struct union enum typedef
syn keyword	cppStructure	class struct union enum typedef
hi Structure	ctermfg=44

syn match	cppTemplate	"\<template\s*<\(\i\|\d\|\s\|,\)*>"
syn keyword	cppTemplate	template
hi cppTemplate	ctermfg=100
"""""""""""""""""""""""""""""""  Statement
"syn keyword	cRepeat		goto break continue
"syn clear	cRepeat
"syn keyword	cRepeat		for while goto break continue
hi cRepeat	ctermfg=198

hi cConditional ctermfg=214
hi cppConditional ctermfg=214

""""""""""""""""""""""""""""""" macro
hi Include		ctermfg=67
hi PreProc		ctermfg=67
hi cIncluded		ctermfg=39
hi cppIncluded		ctermfg=39

syn match	MacroFunction          	"\(^\s*#\s*define\s\+\)\@<=\<\i\+\ze\s*("
hi MacroFunction	ctermfg=39

""""""""""""""""""""""""""""""" Types
syn keyword	cType           string vector deque queue vector array list Titerator pair tuple
syn keyword	cType           stringstream ofstream ifstream  ifstream oftstream  ios_base
syn match	cType           "\<\(\i\+\(_t\|_rec\|_iterator\|_tag\)\|Q\i\+\)\>\(\s*(\)\@<!"
syn match	cType           "\<\i\+::type\>"
syn keyword	cppType		bool wchar_t qreal

hi cType	ctermfg=72
hi cType_t	ctermfg=72
hi cppType	ctermfg=72

"syn clear	cppStorageClass
syn clear	  cStorageClass
"syn clear	  cppStorageClass

syn keyword	  cStorageClass	inline virtual export static register auto volatile extern const void explicit using typename
syn match	  cStorageClass	"\<\(std::\|lvv::\)"
syn match	  cStorageClass	"\<__attribute__\s*((\s*\i\+\s*))"

hi StorageClass	ctermfg=65

hi String	ctermfg=69
hi String	ctermbg=233
"hi String	ctermbg=285

hi Number	ctermfg=147
hi cppBoolean	ctermfg=147

"""""""""""""""""""""""""""""""""
syn match	cppBigClass          	contains=cStructure       "\(^\(class\|struct\)\s\+\)\@<=\<\i\+\ze\s*\(:\s*\i\+\|{\|<\)"
"syn match	cppClass              	contains=cStructure   "\(^\s\+\(class\|struct\)\s\+\)\@<=\<\i\+\ze\s*\(:\s*\i\+\|{\)"
syn match	cppClass              	contains=cStructure   "\(^\s\+\(class\|struct\)\s\+\)\@<=\<\i\+\ze\s*\(:\s*\i\+\|{\|<\)"
hi cppBigClass	ctermfg=194
hi cppClass	ctermfg=194

syn match       Brace                   "{\|}"
"hi 		Brace	ctermfg=208
hi 		Brace	ctermfg=196

syn match       Paren                   "(\|)"
"hi 		Paren	ctermfg=186

hi 		Paren	ctermfg=165

"syn match Quote /\"/
"hi Quote	ctermfg=222

"""""""""""""""""""""""""""""""  BIG (something that starts from 1st col)
" GOOD! start with \@<= ,  end with \ze
syn match	cBigFunction     contains=cType "\(^\i\(\i\|[*&<> \t]\)\+\)\@<=\<\i\+\ze\(\s*(\(\i\|[*&,<>[\] \t]\)*)\s*{\)"
hi cBigFunction		ctermfg=258 ctermbg=233
""""""""""""""""""""""""""""""""""""""""""""""""""""""
"syn match		cFunctionbg             contains=ALL  "^\i\+\s*[*&<> \t]*\s*\<\i\+\s*(\(\i\|[*&,<>[\] \t]\)*)\s*{\zs.*"
"hi cFunctionbg		ctermbg=234

syn match	cFunction     contains=cType "\(^\s*\i\(\i\|[*&<> \t]\)\+\)\@<=\<\i\+\ze\(\s*(\(\i\|[*&,<>[\] \t]\)*)\s*\(const\s*\)\?[:{]\)"
hi cFunction	ctermfg=221	ctermbg=16
" ctor
syn match	CTOR		contains=cType                 "\(^\s*\(explicit\s*\)\?\(\i\+\s*::\s*\)\=\)\@<=\~\?\<\i\+\ze\s*(\(\i\|[*&,<>[\] ]\)*)\s*\(:\s*\i\+\|{\)"
hi 		CTOR		ctermfg=230

" does not work with \i\+:: 
syn match	Member		contains=cType   	"\(^\s*\(\i\|[*& \t<>]\)\+\(\i\+\s*::\s*\)\?\)\@<=\<\i\+\ze\s*<\s*\i\+\s*>\s*(\(\i\|[*&,<>[\] \t]\)*)\s*[:{]"
"syn match	Member		contains=cType   	"\(^\s*\(\i\|[*& \t<>]\)\+\(\i\+\s*::\s*\)\?\)\@<=\<\i\+\ze\s*<\s*\i\+\s*>\s*(\(\i\|[*&,<>[\] \t]\)*)\s*\(const\s*\)\?[:{]"

syn match	cppTemplate	contains=cType		"\(^\s*\(\i\|[*& \t<>]\)\+\(\i\+\s*::\s*\)\?\<\i\+\s*\)\@<=<\s*\i\+\s*>\ze\s*(\(\i\|[*&,<>[\] \t]\)*)\s*[:{]"
hi 		Member		ctermfg=254
"

" vim: ts=8