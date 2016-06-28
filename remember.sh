#!/bin/bash
# remember.sh
# Way too simple cmdline note taker and searcher
# Blame: Arun Patel arunsmtp@gmail.com
# Generates single line entries appended to a 
# ascii text file with the format 
# [# <wizzy cmdline> ## free text comment]
# If called as recollect searches instead
# use <ln -s remember.sh recollect> to softlink.
# Searching sends commands to grep.
#
# ./remember.sh !!  
# --will remember last cmd
# ./remember.sh '!!' 
# --will remember a literal !! rather than the last
# cmd used using bash
#
# ./remember.sh alias ltr="ls -ltr" 
# --will remember the alias cmd and prompt 
# for a description.
#
# ./remember.sh ls -R | grep *.tmp 
# --will fail as the shell will act on the pipe 
# symbol. Use weak "" or strong '' quoting to give 
# the desired result:
# ./remember.sh "ls -R | grep *.tmp"
# 
# ./remember
# --without args will prompt accordingly.
# 
# The format of the saved info is a simple text file
# with a leading hash (to save accidental execution)
# and the comment on the same line followed by a
# double hash.
#
# Symlink in eg ~/bin so searches if called as recollect
# ln -s remember.sh remember
# ln -s remember.sh recollect

# remember data file name and location
rememberDir=~/remember
[[ -d "$rememberDir" ]] || { echo "Setup the directory for remember, usually ~/remember" ; exit 1; }

# For a fixed list
#remeberList="$rememberDir"/remember.list
# For monthly by year timestamped list
remeberList="$rememberDir"/$(date +%b%Y).list

# stash the cmd line args first
numcmdargs=$#
cmdargs="$@"

function checksearch {
# if script called as recollect go into search mode
 calledas=$(basename "$0")
 if [ $calledas == "recollect" ]; then
 echo "Recollecting... Use full grep commands."
 echo "  -    -    -    -    -    -    -    -    -    -    -    -    -"
 echo "  eg.   kubectl          will return any line with kubectl"
 echo "  eg.  -E dpkg.*stat     will return lines with dpkg AND stat"
 echo "  eg.  -e dpkg -e stat   will return lines with  dpkg OR stat"
 echo "  eg.  -v \#\#           will return lines without comments"
 echo "  -    -    -    -    -    -    -    -    -    -    -    -    -"
 if [ $numcmdargs -ne 0 ]; then
   iRecollect=$cmdargs
   echo "Recollecting: $iRecollect"
 else
   echo "What needs to be recollected?"
   read iRecollect
 fi
 
echo '$rememberDir' is $rememberDir
echo "---"
  grep --directories=skip --no-filename -i $iRecollect "$rememberDir"/*
echo "---"
# grep --fixed-strings --no-filename -i $iRecollect "$rememberDir"/*

 exit
 fi
}

function prompt {
# use cmd line args if present else prompt user
 if [ $numcmdargs -ne 0 ]; then
   iRemember=$cmdargs
   echo "Remembering: $iRemember"
 else
   echo "What needs to be remembered?"
   read iRemember
 fi
}

function askcomment {
# ask for comment or description
 echo "What is the comment?"
 read iComment
 echo Saving as:  \# "$iRemember" \#\# "$iComment" 
 echo \# "$iRemember" \#\# "$iComment"  >> $remeberList
}


### Main 

checksearch    # search mode if required exit after else skip

prompt         # prompt incase no cmd line arguments

askcomment     # ask for the all important comment

exit