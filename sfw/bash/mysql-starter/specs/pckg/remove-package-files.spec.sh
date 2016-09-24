#!/bin/bash

#
#------------------------------------------------------------------------------
# removes all the files, but leaves the dirs from a deployed mysql-starter instance
#------------------------------------------------------------------------------
doSpecRemovePackageFiles(){

	#define default vars
	test -z $include_file         && \
		include_file="$product_version_dir/meta/.$env_type.$wrap_name"
	
   # for each file in the include file remove it if its file
   # but not the actual meta include file
   for file in `cat "$include_file"`; do (

		file=$product_version_dir/$file

		# remove any file except the include file
		if [ "$file" == "$include_file" ] 
		then
			continue      # Skip rest of this particular loop iteration.
		fi
		test -f $file && cmd="rm -fv $file" && doRunCmdAndLog "$cmd"

   );
   done
 	
	test $action != 'remove-package' && cmd="rm -fv $include_file" && doRunCmdAndLog "$cmd"
	
}
#eof spec doRemovePackageFiles


