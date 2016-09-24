#!/bin/bash 

#v0.2.1
#------------------------------------------------------------------------------
# creates the full package as component of larger product platform
#------------------------------------------------------------------------------
doPrintHelpForTestHelpCreateFullPackage(){
	cat <<EOF

      bash $0 -a create-full-package
      #--------------------------------------------------------
      creates a full zip package
		
		by adding all the specified related file paths in the include file:
		$product_version_dir/meta/$env_type.$wrap_name

		this will create the full package into your production version dir: $product_dir
		if you have configured the network_backup_dir in conf file it will be also copied 
		to it -> $network_backup_dir
		You must specify the files to be be included in the full package from the meta/mysql-starter.dev 
		file
EOF
}
#eof test doCreateFullPackage

