# the app might run under the root user
# but it usually should't thus:
# define first a group for the linux user to run the app under
export group=grpmysql-starter
export gid=2001
groupadd -g "$gid" "$group"
cat /etc/group | grep --color "$group"

#define than the app linux user and add it to the system
export user=usrmysql-starter
export uid=2001
export home_dir=/home/$user
export desc="the user of the mysql-starter app"
#how-to add an user
useradd --uid "$uid" --home-dir "$home_dir" --gid "$group" \
--create-home --shell /bin/bash "$user" \
--comment "$desc"
cat /etc/passwd | grep --color "$user"


# you can later on modify the user with the usermod and groupmod 
# commands 
usermod

