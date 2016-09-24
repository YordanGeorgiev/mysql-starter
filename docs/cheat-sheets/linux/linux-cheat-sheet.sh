# file:linux-cheat-sheet.sh v.1.9.5 docs at the end 


# list all the tmux sessions
tmux ls
tmux list-sessions


# create a new tmux session
tmux new -s "sess-run-app"
# when in the session detach with Ctrl + B , D
tmux new -s "sess-port-forward"

Ctrl + B, c -- create new window
Ctrl + B, , -- rename window
Ctrl + B, n -- next window

# copy paste from anywhere in tmux
Ctl + B , [ -- enter copy mode 
# use scroll keys to navigate to the text to copy
Space 	    -- to start selection
Enter	    -- to put the selected text into the buffer
Ctrl + B , ]-- to paste the text


#find in files with colors
export to_srch=perl
find . -type f -exec grep -nHi --color=always -R $to_srch {} \; | less -R
find . -name '*.pm' | xargs -P 5 grep -nHP --color=always -P $to_srch | less -R

# how-to search for cygwin packages having the "perl" string in their names, requires wget and perl
wget -qO- "https://cygwin.com/cgi-bin2/package-grep.cgi?grep=$to_srch&arch=x86_64" | \
perl -l -ne 'm!(.*?)<\/a>\s+\-(.*?)\:(.*?)<\/li>!;print $2'

# install multiple packages at once, note the
setup-x86_64.exe -q -s http://cygwin.mirror.constant.com -P "inetutils,wget,open-ssh,curl,grep,egrep,git,vim,zip,unzip,mutt"

# and test 
for bin in `echo ftp telnet wget ssh sftp curl grep egrep`; do echo "$bin path:"; which $bin ;done ; 

# while loop
find `pwd` | { while read -r file ; do echo "$file" ; done ; }

# fork processes with while
c=0
cat "$list_file" | { while read -r jira_issue ; do c=$((c+1)) ; test $c -eq 5 && sleep $c && export c=0 ; \
( sh /maintenance/ip/sfw/sh/jira --action progressIssue --issue $jira_issue --step 41 )& done }

#-- start - search and replace recursively in both files and file paths
to_srch='what_to_srch'
to_repl='what_to_replace'

#-- srch and repl %var_id% with var_id_val in dirs in $component_name_dir_tmp
find "$dir" -type d |\
perl -nle '$o=$_;s#'"$to_srch"'#'"$to_repl"'#g;$n=$_;`mkdir -p $n` ;'
find "$dir" -type f |\
perl -nle '$o=$_;s#'"$to_srch"'#'"$to_repl"'#g;$n=$_;rename($o,$n) unless -e $n ;'

#-- stop  - search and replace recursively in both files and file paths

#-- start - srch and repl %var_id% with var_id_val in files in $component_name_dir_tmp
find "$dir" -type f -exec perl -pi -e "s#$to_srch#$to_repl#g" {} \;
find "$dir/" -type f -name '*.bak' | xargs rm -f
#-- stop  - srch and repl %var_id% with var_id_val in files in $component_name_dir_tmp


# get a nice prompt 
3
export PS1="\h [\d \t] [\w] $ \n\n  "

# nice listing
find . -type f -exec stat -c '%n %y' {} \; | sort -n | less
# check permissions effectively 
find . -type f -exec stat -c "%U:%G %a %n" {} \; | less


# aliases
# show dirs with nice time newest modified on top 
alias ll='ls -alrt --time-style=long-iso'
alias tarx='tar -zxvf'
alias tarc='tar -zcvf'


# find the only the uniq file names of specific file type 
find `pwd` -name '*.xml' | perl -pe 's/(.*)(\\|\/)(.*)/$3/;' | sort  | uniq -u

# how-to find in files - e.g. search by a perl regex in files and redirect the output to vim 
find `pwd` -name '*.pm' -exec grep -inHP -A 1 'sub [a-zA-Z0-9]*\s+\{' {} \; | vim -

# how-to search for a regex and build the ready open vim to found line cmds
find $dir -name '*.ext' -exec grep -nHP 'regex' {} \; | perl -ne 'm/^(.*):(\d{1,10})(.*)/g;print "vim ". "+$2 " . "$1 \n"'


# go the previous dir you where 
cd -
pushd .; popd

#how-to check opened ports with nmap
nmap -sT -O localhost

# get selinux security context
ls -al --lcontext $dir

# change the selinux security context 
chcon -vR -u system_u -r object_r -t httpd_sys_content_t $dir

# use rsync to preserve permissions
rsync -v -X -r -E -o -g --perms --acls $src_dir $tgt_dir
rsync -v -r --partial --progress --human-readable --stats $src_dir $tgt_dir
rsync -v -r --partial --progress --human-readable --stats $src_dir/$f $tgt_dir/$f

while read line_with_spaces ; do sh /path/to/script.sh "$line_with_spaces" ; done < $file_with_lines_with_spaces



export file_name_to_filter=infa-reporter
stat -c "%n %y" *.zip | perl -ne 'm/^(.*?) (.*)/g; printf "%-70s %-50s \n" , "$1" , "$2"' | sort -r -k 2 | grep -i $file_name_to_filter
stat -c "%y %n" *.zip | sort -nr | less


# The ultimate "find in files"
find /etc/httpd/ -type f -print0 | xargs --null grep -nHP 'StartServers\s+\d' | less
# for loop
for file in `find / -type f \( -name "*.pl" -or -name "*.pm" \) -exec file {} \; | grep text | perl -nle 'split /:/;print $_[0]' `; do grep -i --color -nH 'string_to_search'  $file ; done ;

#  or even faster , be aware of funny file names xargs -0
find / -name '*bak' -print0 | xargs --null grep -nPH 'curl'
 
# find and replace recursively
find . -name '*.html' -print0 | xargs -0 perl -pi -e 's/foo/bar/g'

# how-to check disk space
find $dir -maxdepth 2 -type d -exec du -B M --max-depth=1 {} \; | sort -nr | less

# find all the files greather than 100 MB , sort them by the size and print their sizes 
find $dir -type f -size +2M -exec du -B M {} \; | sort -nr | less 
 
du -B M --max-depth 3 $dir | perl -nle 's#\s+# #g;print' | perl -ne 'm/^(.*?) (.*)/g; printf "%10s %-50s \n" , "$1" , "$2"' | sort -nr -k1 | less

# how-to search bunch of tar.gz files 
cmd="zgrep $StringToFind '{}' >> $FileToOutput"
find ${DirFindRoot} -type f  -name ${nameFilter} -print0 | xargs -0 -I '{}' sh -c "$cmd"

# disk usage of users under the /home directory in MB
export dir=/data/reseller/tmp/;
clear;du -all --block-size=1M $dir --max-depth=2 | sort -n | perl -ne '@a=split /\s+/g;$a[0]=~s/(?<=\d)(?=(?:\d\d\d)+\b)/ /g;printf "%15s %10s",$a[0],"$a[1]  \n" '

# show in megs and sort each folder
find $dir -type d -exec du --summarize -B M {} \; | sort -nr | perl -ne '@a=split /\s+/g;$a[0]=~s/(?<=\d)(?=(?:\d\d\d)+\b)/ /g;printf "%15d %10s",$a[0],"$a[1]  \n" '| less

tcpdump dst 10.168.28.22 and tcp port 22
tcpdump dst 1.2.81.2.8.212 
 
# record the current session via script
mkdir ~/scriptlogs
script -a ~/data/log/script/`date +%Y%m%d%H%M%S`_script.log
  
#/usr/bin is for normal user executables, /usr/sbin is for superuser executables, /usr/sfw is for external software (like gnu one), but provided with bundle of OS, /usr/ccs is for development utilities, usually not need for daily tasks like make, lex, yacc, sccs
 
# take the last 5 commands for faster execution to the temp execution script
tail -n 5 /root/.bash_history >> /var/run.sh
 
# I saw the command cd /to/some/suching/dir/which/was/very/long/to/type
echo so I redid it and saved my fingers
!345
  
#how-to check my history without the line numbers  
history | cut -c 8- | grep env
 
 
# how to deal with command outputs
command | filtercommand > command_output.txt 2>errors_from_command.txt
  
 
#  find the files having os somewhere in their names and only those having linux
find . -name '*os*' | grep linux | less
 
# find all xml type of files and display only the rows having wordToFindInRow
find . -name '*.xml' -exec cat {} \;| grep wordToFindInRow | less
 
 
# START === bash shortcuts 
# Go to the beginning of the line you are currently typing on
Ctrl + A 
# Go to the end of the line you are currently typing on
Ctrl + E
# move a word forward 
Alt + F
# move a word backwards
Alt + B
# STOP === bash shortcuts 
 
# how-to mount an usb stick
# remember to change the path other wise you will get the device is busy errror
mkdir /mnt/usbflash
mount /dev/sdb1 -t vfat /mnt/usbflash

mount /vagrant -t /mnt/hgfs/vagrant
mount -t vmhgfs .host:/mnt/hgfs/vagrant /vagrant 

umount /mnt/usbflash

#display the first 20 lines of the file
head -n 20 too-long-file 
 
#start e-mail 
# how to restart a service initiated at startup
/etc/rc.d/init.d/sendmail start | stop | status | restart

# how-to send via e-mails the files of a dir with mailx
export dir=`pwd`
export attachments=$(find $dir -type f| perl -ne 'print "-a $_"'| xargs)
echo $attachments | mailx $attachments -s "$dir files" $MyEmail

mailx $(find $dir -type f| perl -ne 'print "-a $_"'| xargs) -s "$fir files" $MyEmail < `echo $(find $dir -type f| perl -ne 'print "-a $_"'| xargs)`


#stop e-mail
 
# see all the rules associated with the firewall
iptables -L -n -v --line-numbers
 
gunzip *file.zip

# To start remote session click on the putty screen , configure putty
# settings to pull full screen with alt + Enter
 
# right click on the title bar , settings , change the font , copy
# paste from and to the terminal window text
 
# how to ensure the sshd daemon is running
ps -ef | grep sshd

 
# how to kill process interactively
killall -v -i sshd
 
 
# the most efficent way to search your history is to hit Ctrl R and
#type the start of the command. It will autocomplete as soon as theres
#a match to a history entry, then you just hit enter. If you want to
#complete the command (add to it ) use the right arrow to
#escape from the quick search box ...
 
 
#How to see better which file were opened , which directories were visited
 
#type always the fullpath after the vi - use the $PWD env variable to
#open files in the current directory , thus after opening the file
#after:
 
#vi /$PWD , press tab to complete the name of the current directory ,
#type the name of the file. THUS AFTER RUNNING
history | grep vim
 
#of course the same could be seen from the /home/username/.viinfo file /files
 
#where to set the colors for the terminal (if you are lucky to have one
# with colors ; )
 
/etc/DIR_COLORS
 
open a file containing "sh" in its name bellow the "/usr/lib" directory
 
:r !find /usr/lib -name *sh*
 
go over the file and gf
 
#which version of Linux I am using
uname -a
 
#How to copy paste text in the putty window from client to server -

#click the right button of your pointing device
 
#How to copy paste text from the putty window from server to client -
#right-click the window title and select copy all to Clipboard.
 
#To restart a service
service sshd restart
#  
service --status-all --- show the status of all services
 
 
# change the owneership of the directory recursively
chown -vR user$group $dir


# perform action recursively on a set of files
 
find . -name '*.pl' -exec perl -wc {} \;
 

for file in `find . -type f`;do echo cp $file ./backups/; done;
for file in `ls *.docx -1`;do echo cp $file ./backups/$file.`date +%Y%m%d%H%M%S`.docx;done;

 
# make Bash append rather than overwrite the history on disk:
shopt -s histappend
 
# henever displaying the prompt, write the previous line to disk:
PROMPT_COMMAND='history -a'
 
 
# than run the script
#how-to replace single char in file
tr '\t' ',' < FileWithTabs > fileWithCommas
 
# Allow access to the box from only one ip address
 

# create a backup file based on the timestamp on bash
cp -v fileName.ext fileName.ext.`date +%Y%m%d_%H%M%S`.bak

#check disk space left
df -a -h | tail -n +2   | perl -nle 'm/(.*)\s+(\d{1,2}%\s+(.*))/g;printf "%-20s %-30s %-90s \n","$2",$3,$1' | sort -nr | less
df -a -B M | column -t | sort -nr -k 5
df  -h ***
   
# how-to get running processes 
ps -ef --forest 

# how-to kill misbehaving process ... you will need to adjust the -f 2 part 
# depending on the output of the ps -ef command above 
for pid in $(ps -ef | grep procToFind | perl -ne 's/\s+/ /g;print $_ . "\n";' | cut -d ' ' -f 2) ; do echo kill -9 $pid ; done ;
for pid in $(ps -ef | grep chrome | perl -ne 's/\s+/ /g;print $_ . "\n";' | cut -d ' ' -f 2) ; do echo kill -9 $pid ; done ;


#how-to create relative file paths tar package recursively fromm a dir
cd $RootDirToStartRelativePathsFrom
tar -cvzpf $pckg_to_create.tar .
# exctract tar file into cd  
tar -xvf $pck_to_exctract_to_cwd.tar

#how-to create tar archieve
tar cvf $archive_name.tar $dir/

#how-to unpack tar file
tar xvf $file

#how-to unpack gz archive
gzip -cd $file | tar -xvf -


# print line number 52
sed -n '52p' # method 1
sed '52!d' # method 2
sed '52q;d' # method 3, efficient on large files



# START === create symlink
export link_path=/opt/csitea/sfw/bash/file-saver.sh
export target_path=/opt/csitea/file-saver/file-saver.1.0.0.prd.ysg/sfw/bash/file-saver/file-saver.sh
mkdir -p `dirname $link_path`
unlink $link_path
ln -s "$target_path" "$link_path"
ls -la $link_path;
# STOP === create symlink



export link_path=/var/www/html/core_dw
export target_path=/var/aktia/core-dw/core-dw.0.8.6.dev.aktia/docs/site
mkdir -p `dirname $link_path`
unlink $link_path
ln -s "$target_path" "$link_path"
ls -la $link_path;



# START === user management
#how-to add a linux group
export group=grpmysql-starter
export gid=2001
groupadd -g "$gid" "$group"
cat /etc/group | grep --color "$group"

export user=usrmysql-starter
export uid=2001
export home_dir=/home/$user
export desc="the user of the mysql-starter app"
#how-to add an user
useradd --uid "$uid" --home-dir "$home_dir" --gid "$group" \
--create-home --shell /bin/bash "$user" \
--comment "$desc"
cat /etc/passwd | grep --color "$user"


# modify a user
usermod -a -G $group $user

# change the password for the specified user (own password)
passwd $user 
#how-to forces to change password when logging in for the first time
passwd -f login 
#change user pass to expire never 
chage -I -1 -m 0 -M 99999 -E -1 $user
# and check results 
chage -l $user


#Ei should not return anything !!!
passwd -s -a | grep NP (=No Password)

#delete an user
userdel $user
#administer the /etc/group file
gpasswd: 
# START === user management


#how-to extracts rpm packages contents
export ins=foo-bar.rpm
rpm2cpio $ins | cpio -id
#how-to extract *.tar.gz 
gzip -dc *.tar.gz | tar xvf -
cd foo-bar-dir

#--- show all installed packages
rpm -dev
# search for package name
rpm -qa | grep --color $package


#how-to build binaries as a non-root 
./configure --prefix=$HOME && make && make install

#exctract a single file:
gzip -dc fileName.tar.gz | tar -xvf - $file

find . -name '*.log' -print | zip cipdq`date +%Y%m%d%H%M%S` -@
# find several types of files 
find . -type f \( -name "*.pl" -or -name "*.pm" \)

find / -type f | xargs grep -nH 'curl'

# print the word to find + the next 3 lines
grep -A 3 -i "theWordToFind" demo_text


find . -type f -name '*.sh' -print -exec grep -n gpg {} \;
# create a list of files
find . -print0 | xargs -r0 echo "$@"

#how-to encrypt a file
gpg -c $file
#how-to decrypt a file
gpg $file

# where am I
uname -a ; 
# who am I 
id ; 
# when this is happening 
date "+%Y.%m.%d %H:%M:%S" ; 

# reboot ... !!! BOOM BOOM BOOM !!!
shutdown -r now 

# shutdown the whole system 
shutdown -f -s 00
 
#how-to kill a process 
ps -aux | grep $proc_to_find
pidof $prod_to_find
kill -9 $proc_to_find

# which processes are listening on my system
netstat --tcp --listening --programs
netstat --tcp
netstat --route


# STOP === system monitoging commands
# get system info
cat /proc/cpuinfo | less
cat /proc/meminfo | sort -nr -k 2 \
| perl -ne 'split /\s+/;printf ("%-15s %20d MB \n" , "$_[0]" , ($_[1]/1024))'
fdisk -l


# check memory usage
egrep --color 'Mem|Cache|Swap' /proc/meminfo

# show the top processes
top
# now press Shift + o, and choose the field to sort by 

# running processes status 
ps -auxw | less 
ps -ef | less 
#List all currently loaded kernel modules
lsmod | less 
#Displays the system's current runlevel.
/sbin/runlevel
# get the Processes attached to open files or open network ports:
lsoff | less 
# monitor the virtual memory 
vmstat 
# show the free memory
free -m


#Display/examine memory map and libraries (so). Usage: pmap pid
ps -aux | grep $proc_name_to_pmap
pmap   $prod_id_to_pmap
# STOP === system monitoging commands

#how-to sort output by a delimited by single delimiter column 
# in this example the - char is used for delimiter , the output is 
# by their sending sequence , use proper file naming convention files 
# ls -1 gives us:
# fileBeginningTillFirstDelimiter-TheColumnToSortBy-TheRestFromTheFileNameDelimiter
ls -1 | awk -F1 'BEGIN {FS="-"};{print $2 "¤" $1 "-" $2 "-" $3 }' | sort -nr | cut -d ¤ -f 2,5 
# the same approach with perl
ls -1 | perl -p -i -e 's/^([^\-]*)(\-)([^\-]*)(\-)([^\-]*)/$3¤$1.2.8$4$5/g' | sort -nr | cut -d ¤ -f 2,5  

# how-to use sftp with remoteUserName having publicIdentity of PublicIdentityUserName
sftp -v -o "IdentityFile /var/www/.ssh-id/PublicIdentityUserName" \
-o "UserKnownHostsFile /var/www/.ssh-id/known_hosts" remoteUserName@ServerHostNameOrIpd


ssh -v -o ServerAliveInterval 300 -o ServerAliveCountMax 1 

# ==================================================================
# START Jobs control 
# start some very long lasting command 
find / -name '*.crt' | less 
# now press Ctrl + Z 
# the terminal says "Jobs stopped"
# now check the open jobs 
jobs
# you should see something like 
# [1]+  Stopped                 find / -name '*.crt' | less
# now put the job in the background and start working on something else by Ctrl + Z 
bg 1
# run the next command 
# how-to copy file via scp by using specificy identity
scp -v -o "IdentityFile /home/userName/.ssh/id_rsa" /data/path/dir/* \
userName@ServerHostName.Domain.com:/Server/Target/Dir/

# now again stop the job first by Ctrl + Z 
# check again the running jobs 
jobs 
# use should see the both of the jobs started 
# now put the first on in the forground 
fg 1
# Repeat that several times untill you get it ; ) !!!

# start command in the background
command1 &

# how-to redirect STDERR STDOUT to log file 
sh $script.sh | tee 2>&1 $log_file

# how-to start a separate shell 
( command &) &

# get the STDERR and STDOUTPUT 
output=$(command 2>&1)

# how-to detach an already started job from the terminal
jobs 
disown -h %1

# how-to start 
nohup log_script.sh &

# run a proc every 2 seconds
watch -n 2 "$cmd_to_run"

# END Jobs control 
# ==================================================================

nicedate=`date +%Z-%Y%m%d%H%M%S`

# kill a process by name 
ProcNameToKill=listener-nat_filter_caller.sh
# ps -ef | grep wget | perl -ne 'split /\s+/;print "kill $_[7] with PID $_[1] \n";`kill -9 $_[1];`'
ps -ef | grep $ProcNameToKill | grep -v "grep $ProcNameToKill" | \
perl -ne 'split /\s+/;print "kill $_[7] with PID $_[1] \n";`kill -9 $_[1];`'

# how-to display human readable file sizes on systems with stupid du
# of course you would have to have perl next_line_is_templatized
find $dir -type f -exec du -k {} \; | \
perl -ne 'split /\s+/;my $SizesInMegs=$_[0]/1024; \
printf ( "%10d %10s \n" , "$SizesInMegs" , "MB $_[1]")' | sort -nr 


export dir=/
echo sizes in MB
find $dir -type f -exec du -k {} \; | \
perl -ne 'split /\s+/;my $SizesInMegs=$_[0]/1024; \
printf ( "%10d %-100s \n" , "$SizesInMegs" , "$_[1]")' | sort -nr | more


#who has been accessing via ssh 
for file in `find /var/log/secure* | sort -rn` ; do grep -nHP 'user' $file ; done; | less


#print files recursively 
dir=/opt/
clear;find $dir -type f -exec ls -alt --time-style=long-iso --color=tty {} \; | \
perl -ne 'split(/\s+/);printf ( "%10s %2s %-20s \n" , "$_[5]", "$_[6]", "$_[7]") ; ' | sort -nr

#how-to print relative file paths to /some/DirName with perl one liner 
find /some/DirName -type f | perl -ne 'split/DirName\//;print "$_[1]"  '

# see nice dir recursively listing newest first
dir=/tmp
find $dir -name '*.tmp' -exec ls -alt --time-style=long-iso --color=tty {} \; | \
perl -ne 'split/\s+/;print "$_[5] $_[6] $_[7] \n" ;' | sort -nr | less

# how-to sort files based on a number sequence in their file names
# list dir files , grap a number from their names , print with NumberFileName, sort , \
# print finally the names without the Number but sorted 
ls -1 | perl -ne 'm/(\d{8})/; print $1 . $_ ;' | sort -nr | perl -ne 's/(\d{8})//;print $_'
   
# START === how-to implement public private key ( pkk ) authentication 
# create pub priv keys on server
# START copy 
ssh-keygen -t rsa
# Hit enter twice 
# copy the rsa pub key to the ssh server
scp ~/.ssh/id_rsa.pub $ssh_user@$ssh_server:/home/$ssh_user/
# STOP copy
# now go on the server
ssh $ssh_user@$ssh_server

# START copy 
cat id_rsa.pub >> ~/.ssh/authorized_keys
cat ~/.ssh/authorized_keys
chmod -v 0700 ~/.ssh
chmod -v 0600 ~/.ssh/authorized_keys
chmod -v 0600 ~/.ssh/id_rsa
chmod -v 0644 ~/.ssh/id_rsa.pub
find ~/.ssh -exec stat -c "%U:%G %a %n" {} \;
rm -fv ~/id_rsa.pub
exit
# and verify that you can go on the server without having to type a pass
ssh $ssh_user@$ssh_server
# STOP COPY

# START copy 
ssh-keygen -t dsa
# STOP copy  
# Hit enter twice 
# START copy 
cat id_dsa.pub >> ~/.ssh/authorized_keys
cat ~/.ssh/authorized_keys
chmod -v 0700 ~/.ssh
chmod -v 0600 ~/.ssh/authorized_keys
chmod -v 0600 ~/.ssh/id_dsa
chmod -v 0644 ~/.ssh/id_dsa.pub
find ~/.ssh -exec stat -c "%U:%G %a %n" {} \;
rm -fv ~/id_dsa.pub
# STOP COPY
# STOP === how-to implement public private key authentication


# show me a nice calendar 
cal -m -3

# START === how-to enable port forwarding or tunnelling
export local_port=22
export remote_port=13306
export ssh_user=type_here_ssh_user
export ssh_server=type_here_the_hostname
export db_server=type_here_the_db_hostname
#[-L [bind_address:]port:host:hostport] 
ssh -L localhost:$local_port:$db_server:$remote_port $ssh_user@$ssh_server
# STOP === how-to enable port forwarding or tunnelling

# START === cron scheduling 
#edit the crontab
crontab -e
# view the crontab
crontab -l 
0 1 * * *
# * * * * * command to be executed
# - - - - -
# | | | | |
# | | | | +- - - - day of week (0 - 6) (Sunday=0)
# | | | +- - - - - month (1 - 12)
# | | +- - - - - - day of month (1 - 31)
# | +- - - - - - - hour (0 - 23)
# +--------------- minute
# STOP === cron scheduling 


#how-to limit the resources of the current session 
help ulimit 

nameTerminal $USER@`hostname`_ON_`pwd`__at__`date +%Y-%m-%d_%H:%M:%S`


# change user password expiry information
for usr in "$userlist"; do sudo passwd $usr; sudo chage -E -1 -M -1 $usr; sudo chage -d0 $usr; done


#how-to check the file encoding
file_encoding=$(file -bi $file | sed -e 's/.*[ ]charset=//')


# Purpose: 
# to provide a simple cheat sheet for most of the Linux related commands

# usefull web sources: http://www.cyberciti.biz
# how-to add new repository to yum
yum-config-manager --add-repo http://www.example.com/example.re

#how-to view installed packages with yum on RH


yum list installed | less
yum clean all 
yum -y install perl
# update all but the linux kernel packages
yum -y --exclude=kernel\* update

/nz/kit/sbin/sendMail -dst first.last@company.com -msg "subject line" -bodyTextFile $outfile -removeFile

# start putty with preloaded session on windowz
cmd /c start /max putty -load username@hostname


# how-to enable pw auth on apache
pw_file=/var/www/html/maint/.htpasswd
user=mmt
htpasswd -c $pw_file $user

#how-to change the access and mofication timestamp
ts='201401181205.09'
touch -a -m -t "$ts" "$file"

# how-to install packages on ubuntu
apt-get -y install $package_name
# howto install packages on red-hat
yum install $package_name

#v1.9.5 how-to use text editor for longer command typing
set EDITOR=vim
#Ctrl+X,E

#v1.9.5 - how-to get variations by curly expansions
echo {A,B,C}{0,1,3}

#how-to convert file encoding 
iconv -f 'iso-8859-1' -t 'utf-8' "$file"



# how-to load document with wget by using cookies.txt
export url=www.google.com
export out_file=$proj_dir/docs/site/data/issues/
wget $url --user-agent=agent --load-cookies=~/.cookie.txt --output-document=$out_file

#how-to perform a command frequintly 
while $(sleep 0.2); do date "+%Y:%m:%d %H:%M:%S"; done

# how-to save the state of a gues machine from the command line
VBoxManage controlvm ysg_host_name  savestate

# start a headless mode
VBoxManage startvm "ysg_host_name" --type headless
# start a guest in normal mode with UI
VBoxManage startvm "ysg_host_name" 




#
# useful sources - hint: google site:<site>
# http://www.cyberciti.biz
# http://www.yolinux.com/TUTORIALS/LinuxTutorialSysAdmin.html#MONITOR
# http://www.commandlinefu.com/commands/browse/sort-by-votes
# http://wiki.bash-hackers.org/
#
# ==========================================================
#  VersionHistory
# ==========================================================
# 1.9.7 --- 2015-12-16 10-16-32 --- ysg --- new aliases, re-factor
# 1.9.6 --- 2015-04-09 09:13:27 --- ysg --- re-factor
# 1.9.5 --- 2014-23-04 22:37:07 --- ysg --- Ctrl+X,E trick
# 1.9.4 --- 2014-08-03 10:28:55 --- ysg --- refactor
# 1.9.3 --- 2014-02-24 20:54:04 --- ysg --- clean-up
# 1.9.2 --- 2013-12-18 11:14:03 --- ysg --- added build re-factor
# 1.9.1 --- 2013-08-27 15:35:51 --- ysg --- re-factor, 
# 1.9.0 --- 2013-05-21 09:40:52 --- ysg --- added memory info
# 1.8.9 --- 2013-05-09 22:52:10 --- ysg --- tar.gz extract compacting 
# 1.8.8 --- 2013-05-02 16:19:46 --- ysg --- du with nice formatting 
# 1.8.7 --- 2013-04-22 15:25:36 --- ysg --- nmap check opened ports
# 1.8.6 --- 2013-04-18 12:43:43 --- ysg --- add user passwd expiry information
# 1.8.5 --- 2013-04-15 13:02:19 --- ysg --- added send dir files with mailx
# 1.8.4 --- 2012-12-26 17:56:21 --- ysg --- refined find in files 
# 1.8.3 --- 2012-12-26 14:23:56 --- ysg --- renamed to linux-cheat-sheet - clean up 
# 1.8.2 --- 2012-10-08 10:00:46 --- ysg --- added crontab cheat 
# 1.8.1 --- 2012-07-19 23:15:48 --- ysg --- tar examples , refactor
# 1.8.0 --- 2012-06-30 21:31:23 --- ysg --- tunnel one liner 
# 1.0.0 --- ysg ---  Initial creation  
#
# eof file:linux-cheat-sheet