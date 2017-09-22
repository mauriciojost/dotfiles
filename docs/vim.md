#########################
### Basic VIM commands 
#########################

### IDEAVIM

For users of Intellij: 
https://github.com/JetBrains/ideavim

Ctrl_Alt_q 			toggle vim on/off

## General

Ctrl-a + 
	Ctrl-d			show Documentation
	Ctrl-D			show full Documentation
	Ctrl-u			show Usages
	Ctrl-h			show Hierarchy of the type
	Ctrl-H			show Hierarchy of the method
	Ctrl-Alt-h		show Hierarchy of the call
	Ctrl-c 			search Classes by name 
	Ctrl-f 			Find in all documents
	Ctrl-p 			show parameters of a method
	Ctrl-r 			rename a attribute name, or class name, etc.
	Ctrl-R 			replace in all documents

## About Git

Ctrl-g +
	Ctrl-h			show History
	Ctrl-H			show History for selection
	Ctrl-c			compare with...
	Ctrl-s			stash changes
	Ctrl-r			rebase
	Ctrl-b			branches
	Ctrl-l			logs

## About extracting

Ctrl-e +
	Ctrl-m			a method

#### REAL VIM 

### Basic navigation 

w				next word
b				previous word
:b				go to the file
:b part_of_filename		go to the file
:e filename			open a file
:bd				buffer delete (closes a buffer, a “window”)
:q				exit
:100				goes to the given line
/word_to_find			find the given word in the current buffer 
*				go to the next occurence of the word under the cursor

### Basic file management

:x				save and exit 
:ls				list opened files

### Advanced navigation 

ctrl + 6			come back to the last viewed file
ctrl + o			come backwards to text sections you’ve been in 
ctrl + i			go ahead to text sections you've come from
` .				come back to last modified point 
gd 				will take you to the local declaration.
gD 				will take you to the global declaration.
Ctrl-o				go to where you were before

### Basic editing

ctrl + n			autocomplete
v				enter visual mode
i				insert mode
U u				undo
ctrl + R			redo
y				yank, copy (in visual mode) (puts the thing in register "" and "0)
dw				delete a word
diw				delete inner word (where the cursor is)
dd				delete a line (and copies content to register "")
ciw				change inner word (delete the word and go to insert mode) 
p				paste after
P				paste before
o				create a new line, go to it, and enter insert mode

### Windows management

Ctrl-W t			makes the first (topleft) window current
Ctrl-W K			moves the current window to full-width at the very top
Ctrl-W H			moves the current window to full-height at far left
ctrl-W n			creates new vim window (so two files can be seen simultaneously)
ctrl-w ctrl-w 			switches between windows
:q				removes a window

%s/<target>/<new>/<modif>
:s/foo/bar/g              Change each 'foo' to 'bar' in the current line.
:%s/foo/bar/g           Change each 'foo' to 'bar' in all lines.
:%s/foo/bar/gc         Change each 'foo' to 'bar' in all lines (with confirmation)
:5,12s/foo/bar/g       Change each 'foo' to 'bar' for all lines from line 5 to line 12 inclusive.

:syntax on              highlights the text depending on the kind of file 

:reg     - show named registers and what's in them
"5p      - paste what's in register "5



