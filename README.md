# remember
- Way too simple cmdline note taker and searcher
- Blame: Arun Patel
- Generates single line entries appended to an ascii text file with the format 
 
 `[# <wizzy cmdline> ## free text comment]`

- If called as recollect searches instead
- use `<ln -s remember.sh recollect>` to softlink.
- Searching sends commands to grep.

###Example

#Install
```
$ cd ~
$ git clone https://github.com/arpat/remember.git
$ cd ~/bin
$ ln -s ~/remember/remember.sh remember
$ ln -s ~/remember/remember.sh recollect
$ cd ~
```

# Save a useful cmdline 

```
$ sudo sysdig -p "%12user.name %6proc.pid %12proc.name %3fd.num %fd.typechar %fd.name" evt.type=open

  ...that was a great command, I want to note that down!

$ remember !!
remember sudo sysdig -p "%12user.name %6proc.pid %12proc.name %3fd.num %fd.typechar %fd.name" evt.type=open 
Remembering: sudo sysdig -p %12user.name %6proc.pid %12proc.name %3fd.num %fd.typechar %fd.name evt.type=open
What is the comment?
snoop file opens as they occur
Saving as: # sudo sysdig -p %12user.name %6proc.pid %12proc.name %3fd.num %fd.typechar %fd.name evt.type=open ## snoop file opens as they occur
```

# Recollecting
```
$ recollect 
Recollecting... Use full grep commands.
  -    -    -    -    -    -    -    -    -    -    -    -    -
  eg.   kubectl          will return any line with kubectl
  eg.  -E dpkg.*stat     will return lines with dpkg AND stat
  eg.  -e dpkg -e stat   will return lines with  dpkg OR stat
  eg.  -v \#\#           will return lines without comments
  -    -    -    -    -    -    -    -    -    -    -    -    -
What needs to be recollected?
-E sysdig.*snoop
$rememberDir is /home/apatel/remember
---
# sysdig -p "%12user.name %6proc.pid %12proc.name %3fd.num %fd.typechar %fd.name" evt.type=open ## Basic opensnoop: snoop file opens as they occur
# sysdig -p "%12user.name %6proc.pid %12proc.name %3fd.num %fd.typechar %fd.name" evt.type=open and evt.failed=true ## snoop failed file opens as they occur
---
&

```



###Usage

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
 Use weak " " or strong ' ' quoting to give the desired result:
 ```sh
 remember "ls -R | grep *.tmp"
```
remember without args will prompt accordingly.

 The format of the saved info is a simple text file with a leading hash (to save accidental execution) and the comment on the same line separated by a double hash. Make a directory to store these files, usually ~/remember.
 
 eg this will return all lines from all notes matching 'mdadm'
```sh
recollect mdadm
```

 Symlink in eg ~/bin so searches any existing .list files in ~/remember -if called as recollect
 ```sh
 ln -s remember.sh remember
 ln -s remember.sh recollect
```

### To Do's

- Would be nice to specify date range of .list files for recollect, month year perhaps?
