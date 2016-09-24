#file: git-cheat-sheet.sh v1.0.0 docs at the end

# who has done what in the current branch
git log --format='%h %ai %an %m%m %s'

# to check a specific commit 
git show $git_obj
# how-to show which files have been commited 
git diff-tree --no-commit-id --name-only -r $git_obj


# how-to check all the branches 
git branch -a

# how-to delete a branch
git branch -d <<branch_to_delete>>

# chekout as specific branch
git fetch --all
git checkout feature/RT3519-extendedEmployeeReport

git checkout develop -- `git ls-tree --name-only -r develop | egrep '*.zip'`

# how-to compare 2 brancches 
git diff branch1 branch2

git log
git status


# list all the remote branches
git branch --all 
git branch --remotes
# ll

#how-to install git on Ubuntu, RH and cygwin
apt-get install -y git
yum install -y git
setup-x86_64.exe -q -s http://cygwin.mirror.constant.com -P "inetutils,wget,open-ssh,curl,grep,egrep,git"

# pretend starting from different directory 
git -C ..
alias git="git -C $dir"


# to to the tmp dir 
cd /tmp 

# set a pw run-time store in the cache 
git config --global credential.helper cache
git config --global core.editor "vim"
git config credential.helper 'cache --timeout=3600'
# configure the user name and e-mail for git 
git config --global user.name "YordanGeorgiev"
git config --global user.email "yordan.georgiev@company.com"
# configure push behaviour
git config --global push.default simple
# add the remote 
git remote add origin https://github.com/YordanGeorgiev/mysql-starter.git
# initialize a new git repo
git init
# clone the existing repo from the Internet
git clone https://github.com/YordanGeorgiev/mysql-starter.git
# move the .git dir to the 

# ups something went rong should redo 
git rm --cached -r .

# add the product version dir 
git add -v --all mysql-starter/mysql-starter.0.1.0.dev.ysg
# force remote repo rebuild 
git push --force -u origin master
git push -u origin master



# initialize
git init
# add remote origin
git remote add origin https://github.com/YordanGeorgiev/mysql-starter.git
https://github.com/YordanGeorgiev/nzbackup-runner.git
# verify
git remote -v
git config --global user.name "YordanGeorgiev"
git config --global user.email "yordan.georgiev@gmail.com"

# make git remember your pass 
git config --global credential.helper cache
git config credential.helper 'cache --timeout=3600'
# stop make git remember your pass 

# get help 
# git --help

# simly add all the files from the current directory
git add --all 
git rm --cached -r .

# dry run adding verbose a dir 
git add -v -n --all mysql-starter.0.8.9.dev.ysg


#create the master branch 
git push --force -u origin master
git push -u origin master

git commit -m "Adding $component_name $component_version files recursively " 

git push



# to remove all the files
git rm *

# to force master branch re-creation
man git-branch

wget --no-check-certificate https://github.com/$MyGitUserName/nzbackup-runner/archive/master.zip
# how-to clone 
git_repo_url=https://yordan.georgiev@git.aktia.biz/scm/~yordan.georgiev/core-5971.git
git clone "$git_repo_url"

# add the reamde file for the new project 
touch README.md
git add README.md

git pull origin master

# how-to add all the files ( except those matching the $issue/.gitignore ) 
git -C $issue add --all
git -C $issue commit -m "vw_INTIME_GL-create-view.sql v1.0.3 - re-write start with GL accounts"
git -C $issue push origin master

# how-to remove all the files from staging
git -C $issue reset HEAD -- .

# well this is more of an jira git integration , but anyway 
# how-to link Stash commits to jira issues 
git commit -m "$issue_id 0.4.1 foo bar"

git log --pretty=format:"%cr %cn %s" --author="Georgiev Yordan" -3

# create a srong key for encryption with github
ssh-keygen -t ecdsa -b 521

# check the following resources:
# https://git-scm.com/book/en/v2/Git-Branching-Basic-Branching-and-Merging
# Purpose
#==============================================================================

#
# VersionHistory
#==============================================================================
# 1.0.0 --- 2013-09-20 22:25:56 --- Initial version

#eof file: git-cheat-sheet.sh
