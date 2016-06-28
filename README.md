# remember
- Way too simple cmdline note taker and searcher
-  Blame: Arun Patel
- Generates single line entries appended to a
- ascii text file with the format [# <wizzy cmdline> ## free text comment]
- If called as recollect searches instead
- use <ln -s remember.sh recollect> to softlink.
- Searching sends commands to grep.



 remember the last cmd
```sh
remember !!
 ```
 remember a literal !! rather than the last cmd used using bash
 ```sh.
 remember '!!'
 ```
 remember the alias cmd and prompt for a description.
```sh
 remember alias ltr="ls -ltr"
 ```
the following will fail as the shell will act on the pipe symbol:
 ```sh
 remember ls -R | grep *.tmp
 ```
 Use weak "" or strong '' quoting to give the desired result:
 ```sh
 remember "ls -R | grep *.tmp"
```
remember without args will prompt accordingly.

 The format of the saved info is a simple text file with a leading hash (to save accidental execution) and the comment on the same line followed by a double hash. Make a directory to store these files, usually ~/remember.
 
 eg this will return all lines from all notes matching 'mdadm'
```sh
recollect mdadm
```

 Symlink in eg ~/bin so searches any existing .list files in ~/remember -if called as recollect
 ```sh
 ln -s remember.sh remember
 ln -s remember.sh recollect
```
