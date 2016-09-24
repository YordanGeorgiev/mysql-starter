#define the deployment package 
zip_file=mysql-starter.0.0.5.dev.20160703_111158.ysg-host-name.zip

# define the target base dir to deploy to , 
base_dir=/opt

# deploy to this target deployment dir
unzip -o $zip_file -d $base_dir

# define the first organisation name under the which the app runs
org_name=csitea

# change the owner of the app dir structure
chown -Rv usrmysql-starter:grpmysql-starter $base_dir/$org_name

# check the created files and dirs
find $base_dir/$org_name
