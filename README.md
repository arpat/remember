# remember

 Way too simple cmdline note taker and searcher
 Blame: Arun Patel arunsmtp@gmail.com
 Generates single line entries appended to a
 ascii text file with the format
 [# <wizzy cmdline> ## free text comment]
 If called as recollect searches instead
 use <ln -s remember.sh recollect> to softlink.
 Searching sends commands to grep.

 ./remember.sh !!
 --will remember last cmd
 ./remember.sh '!!'
 --will remember a literal !! rather than the last
 cmd used using bash

 ./remember.sh alias ltr="ls -ltr"
 --will remember the alias cmd and prompt
 for a description.

 ./remember.sh ls -R | grep *.tmp
 --will fail as the shell will act on the pipe
 symbol. Use weak "" or strong '' quoting to give
 the desired result:
 ./remember.sh "ls -R | grep *.tmp"

 ./remember
 --without args will prompt accordingly.

 The format of the saved info is a simple text file
 with a leading hash (to save accidental execution)
 and the comment on the same line followed by a
 double hash.

 Symlink in eg ~/bin so searches if called as recollect
 ln -s remember.sh remember
 ln -s remember.sh recollect

