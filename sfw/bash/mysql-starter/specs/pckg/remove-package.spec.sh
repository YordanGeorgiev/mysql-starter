#!/bin/bash


#v0.2.0
#------------------------------------------------------------------------------
# removes all the files from a deployed mysql-starter instance
#------------------------------------------------------------------------------
doSpecRemovePackage(){

	doRemovePackageFiles
	
   #remove the dirs as well
   for dir in `cat "$include_file"`; do (
       dir="$product_version_dir/$dir"
       test -d "$dir" && cmd="rm -fRv $dir" && doRunCmdAndLog "$cmd"
   );
   done

 	cmd="rm -fv $include_file" && \
 	doRunCmdAndLog "$cmd"
	echo "rm -fvr $product_version_dir">>"$product_dir/remove-""$environment_name".sh
	echo "rm -fv $product_dir/remove-""$environment_name".sh>>"$product_dir/remove-""$environment_name".sh
	nohup bash "$product_dir/remove-""$environment_name".sh &
}
#eof spec doRemovePackage
