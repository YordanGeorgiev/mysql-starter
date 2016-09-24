<" file: vim-cheat-sheet.vim v.1.1.0 docs at the end
"  

" how-to autocomplete
" when in insert mode , press Ctrl + N and c
" how-to start vim in the shell by opening list of files 
vim -o `echo /a/dir/with/conf/and/sh/files/*.{sh,conf}`
" if something goes owry do always press the Esc key several times before proceeding !!!
" how-to exit without saving (the hyphen meaning is the same for all commands )
:q! 
" open all the perl files in the current directory 
vim *.pl  
" how-to open a new buffer with the ouptput from a shell command
find `pwd` -name '*.pm' -exec grep -inHP 'sub [a-zA-Z0-9]*\s+\{' {} \; | vim -
 
" press Esc press w to save the file ,q to quit , ! for not saving anything
:wq!
" how-to open a directory 
:e /etc/
" how-to go one dir level up when dir is open
-
 
"how-to save the changes  were editing. For saving the file under a different name, specify the file name.
:w 
" how-to list the opened files ( called in vim buffers ) 
:ls
" how-to close a buffer  
:bd <<buffer_number>>
" how-to close the current buffer 
:bd 
"Write the file and exit.
:wq 
" how-to reload the current buffer if the file has been edited by another tool
:edit
" how-to get help 
:help 
 
" hit N to jump to the previous match 
 
" === START NAVIGATION in the contents of the files === 
" enter normal mode first , note this navigation keys work only in normal and visual modes
Esc
" how-to go one line below
j
" how-to go one line up 
k 
" how-to go one character left in normal mode  
l
" how-to go one character right in normal mode
h
" how-to backward a word in normal mode 
B
" how-to foward a word in normal mode 
e
" how-to go the begining of the document in normal mode ( Ctr+Home on Win )
gg
" how-to go the end of the document ( Ctrl + End on Win )  
G
" how-to jump to line number xxx ( for example line number 34 ) 
34G 
" how-to jump back from where you were in the previous time
' -(Press ' twice ) jump back to line (where you came from) 
" go to the beginning of the line 
^
" jump to the end of a line.
$ 
" jump to the beginning of a word.
b 
" go backwards a word 
B
" jump to a stringToSearchFor
:/stringToSearchFor
" how-to jump to the next occcurence of the stringToSearchFor  
n
" hit n to jump to the next match 
N
 
" jump to the matching brackets [](){} .
" go on top of the bracket and press 
%
" === STOP NAVIGATION in the contents of the files === 
 
" === START EDITING ===
" to be able to write you have to enter the insert mode
Esc,i
" now you could start typing, the arrow keys work as well ;) ! 
" how-to delete text
" how-to delete the current line 
dd 
" or 
:d 
" how-to delte 3 lines in normal mode
3d
" === STOP EDITING ===
 
 
" === START COPY PASTE ===
" how-to select text and copy paste
" first enter into visual mode 
Esc,v 
" navigate within the text with the navigation keys ( see above ) 
j,k,l,h
" than yank the selected into the register ( Ctrl + C in Windows - copy to clipboard ) 
y 
" or to cut it after the selection into the register ( Ctrl + X in Windows - cut it into the clipboard ) 
d 
" in visual mode Yank the current line. You do not need to highlight it first.
yy or :y or Y 
" Esc to run into the normal mode,navigate to the place where to paste the text and paste it: 
p 
" Undo the last actionUndo the last action
u 
" Redo the undone action 
Ctrl + r
" === STOP COPY PASTE === 
 
 
" START working with buffers 
" list the currently opened buffers ( or files for writing ) 
:ls
" open a file as another bugger
:e /path/to/file3
" switch again to the first bugger 
:b 1
" switch to the next buffer without saving the current one 
:bn!
" switch to the previous file buffer ( your will be prompted to save it if you have not done it yet)
:bp  
" go to the next buffer
:cnext 
" open the file under the cursor in Normal mode
gf 
" opens a new file in a new window
:split /usr/share/some.file  
 
" STOP working with buffers 
 
" START SEARCH AND REPLACE 
" how-to search and replace text with confirmation before each replace 
:%s/search_for_this/replace_with_this/c
 
" how-to Find and replace 
:%s/foo/bar/g Replace every occurrence of the word foo with bar in the whole file.
 
" how-to remove all the lines containing the string "clear"
:%s/^.*clear$\n//gi  
 
" For all lines in a file, find "string_to_find" and replace with "string_to_replace" for each instance on a line. Ask for confirmation 
:%s/string_to_find/string_to_replace/gc 
 
"  - For all lines between line marked "a" (ma) and line marked "b" (mb), find string "fff" and replace with string "rrrrr" for each instance on a line. Case insensitive. 
:'a,'bs/fff/rrrrr/gi
" For all lines in a file, delete blank spaces at end of line. 
:%s/*$/ 
" For all lines in a file, move last field delimited by ":" to the first field. Swap fields if only two.
:%s/\(.*\):\(.*\)/\2:\1/g 
 
" how-to get help on search and replace commands  
:help substitute 
:help pattern 
 
" STOP SEARCH AND REPLACE 
 
 
" where vim sets the settings of the "sessions" 
vim ~/.viminfo
 
" How to edit the colors of the current color scheme: 
" 1. Check the name of your current color scheme located at: /root/.vimrc or /home/usrname/.vimrc (attention come kind of aliasing ... )
:colorscheme elflord
 
" 2. Edit the current colorsheme 
locate elflord.vim 
" search for the section containinng the colors would like to edit
/comments
 
" 3. Pick a HEX number for the color of the comments you would prefer to have .. "40FF00 (google color table )
" Enters the file under the cursor into the editor in you commend line (normal mode).
Ctrl-R Ctrl-F 
 
Ctrl-R Ctrl-A Enters the text from the editor in you commend line (normal mode).
" As most other *nix applications, you can also pause Vim with Ctrl-z, which will drop you back to the shell. When you are re finished, you can resume Vim with fg. (This is a feature of the shell, not a Vim feature.)
 
 
" how-to show the current directory
:!pwd"  
 
" START folding 
" jump to the beginning char of the folding - for example the brackets of the function 
e
" change to visual mode
Esc , v
" select till the end of the desired folding region 
%
" to fold the region type the following command
:fold
" to open the just closed folded region 
zo 
" to close it back again 
zc 
" STOP folding
 
 
   " START indending 
   " enter normal mode
   Esc
   " enter visual mode
   v
   " select the text you would like to intent / shift wit the navigation keys
   " shift with 
   >>
   " or 
   <<
   " STOP indending 
 
 
" START SETTINGS 
" all of those could be set in the ~/.vimrc file 
 
" adjust the amount of space on pressing tab
:set tabstop=3
" set cursor showing matching brackets 
:set showmatch 
" set the appearance on the left side for the line numbers
:set number
" unset the numbers 
set nonu
" set syntax highlighting 
:set 
" set a specific type of syntax 
:set syntax=html
" set the heigt of the window 
:set winheight=90 
" set the default shift width 
:set sw=3
" set the columnn width to 120 characters 
:set co=120 
" set mysql-startering 
:set wrap 
 
" STOP SETTINGS 
 
 
" how-to create your own syntax highting 
" create your customizable syntax highlighting dir
mkdir -p ~/.vim/syntax/
" find the syntax file for the language 
locate perl.vim
" copy the already existing syntax file to this folder
cp -c /usr/share/vim/vim73/syntax/perl.vim ~/.vim/syntax/
" edit the "overriding " syntax file 
: e ~/.vim/syntax/perl.vim
 
 
" START COMMANDS 
" Any UNIX command can be executed from the vi command line by typing an "!" before the UNIX command. 
" how-to insert the current date 
:r! date +"\%Y-\%m-\%d \%H:\%M:\%S"
" how-to insert the full paths from the current directory 
:r! find `pwd`
" navigate onto a file path and press 
gf
" to openn it into another buffer
" STOP COMMANDS 
 
 
 
"START Mappings 
"show all the mappings 
:map
" the keyboard shortcuts performing user defined commands which could be saved in the .vimrc file
" Ctrl + Tab for switching to the next buffer
map <C-Tab> :bn!<CR> 
 
map <f4> :bn! <CR> :bd "<CR>  Ctrl + F4 - for closing the current buffer
" STOP Mappings 
 
" 
 
" enable jump-to definition feature 
" in the shell cd /my/src/root/dir/
" generate the tags file for this root src
" ctags -R -n --fields=+i+K+S+l+m+a 
" in vim
":ta <<name_of_func_to_search_for>>
":ts ? shows the list.
":tn ? goes to the next tag in that list.
":tp - goes to the previous tag in that list.
":tf ? goes to the function which is in the first of the list.
":tl ? goes to the function which is in the last of the list.
 
" set left indent to 3
:le 3
 
" find in files recursively 
:vimgrep /'DocPage'/ **/*.pm
:vimgrep /doBuild/ `find . -type f -name '*.pm' -o -name '*.pl'`
" type than to open the found in files window
:cw
 
" toggle letters to capitalize , select , gU 
" Purpose: 
" to provide a tutorial-like vim-cheat-sheet 
" 
" sources 
http://www.yolinux.com/TUTORIALS/LinuxTutorialAdvanced_vi.html
http://en.wikibooks.org/wiki/Learning_the_vi_Editor/Vim
" 
" VersionHistory
" 1.1.0 --- 2013-04-24 13:43:27 --- Yordan Georgiev --- added jump to with ctags
" 1.0.1 --- 2012-12-26 11:58:40 --- Yordan Georgiev --- enhancements 
" 1.0.0 --- 2012-12-25 10:30:16 --- Yordan Georgiev --- Initial creation 
"
" eof file: vim-cheat-sheet.vim
