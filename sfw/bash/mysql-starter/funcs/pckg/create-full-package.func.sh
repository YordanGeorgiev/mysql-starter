#!/bin/bash 

#v0.2.1
#------------------------------------------------------------------------------
# creates the full package as component of larger product platform
#------------------------------------------------------------------------------
doCreateFullPackage(){

	doLog "INFO === START === create-full-package" ;
	flag_completed=0

	#define default vars
	test -z $include_file         && \
		include_file="$product_version_dir/meta/.$env_type.$wrap_name"

	# relative file path is passed turn it to absolute one 
	[[ $include_file == /* ]] || include_file=$product_version_dir/$include_file

	test -f $include_file || \
		doExit 3 "did not found any deployment file paths containing deploy file @ $include_file"

	cd $org_base_dir

	timestamp=`date +%Y%m%d_%H%M%S`
	# the last token of the include_file with . token separator - thus no points in names
	zip_file_name=$(echo $include_file | rev | cut -d. -f 1 | rev)
	zip_file_name="$zip_file_name.$product_version.$env_type.$timestamp.$host_name.zip"
	zip_file="$product_dir/$zip_file_name"
	echo $zip_file>$tmp_dir/zip_file

	# zip MM ops
	# -MM  --must-match
	# All  input  patterns must match at least one file and all input files found must be readable.
	set -x ; ret=1
	cat $include_file | perl -ne 's|\n|\000|g;print'| \
	xargs -0 -I "{}" zip -MM $zip_file "$org_name/$wrap_name/$environment_name/{}"
	set +x
	ret=$? 
	[ $ret == 0 ] || rm -fv $zip_file
	[ $ret == 0 ] || doLog "FATAL !!! deleted $zip_file , because of packaging errors !!!"
	[ $ret == 0 ] || exit 1

	doLog "INFO created the following full development package:"
	doLog "INFO `stat -c \"%y %n\" $zip_file`"

	flag_completed=1
	
	test -d $network_backup_dir && doRunCmdAndLog "cp -v $zip_file $network_backup_dir/"

	doLog "INFO === STOP  === create-full-package" ;
}
#eof func doCreateFullPackage

