#!/bin/bash


#v0.2.3
#------------------------------------------------------------------------------
# creates a package from the relative file paths specified in the .dev file
#------------------------------------------------------------------------------
doCreateRelativePackage(){

	flag_completed=0
	cd $product_version_dir
	mkdir -p $product_dir/data/zip
		test $? -ne 0 && doExit 2 "Failed to create $product_version_dir/data/zip !"

	#define default vars
	test -z $include_file         && \
		include_file="$product_version_dir/meta/.$env_type.$wrap_name"

	# relative file path is passed turn it to absolute one 
	[[ $include_file == /* ]] || include_file=$product_version_dir/$include_file

	test -f $include_file || \
		doExit 3 "did not found any deployment file paths containing deploy file @ $include_file"


	timestamp=`date +%Y%m%d_%H%M%S`
	# the last token of the include_file with . token separator - thus no points in names
	zip_file_name=$(echo $include_file | rev | cut -d. -f 1 | rev)
	zip_file_name="$zip_file_name.$product_version.$env_type.$timestamp.$host_name.rel.zip"
	zip_file="$product_dir/$zip_file_name"
	

	# zip MM ops -MM = --must-match
	# All  input  patterns must match at least one file and all input files found must be readable.
	ret=1
	cat $include_file | perl -ne 's|\n|\000|g;print'| xargs -0 zip -MM $zip_file
	ret=$? ; set +x ;
	[ $ret == 0 ] || rm -fv $zip_file
	[ $ret == 0 ] || doLog "FATAL !!! deleted $zip_file , because of packaging errors !!!"
	[ $ret == 0 ] || exit 1

	cd $product_dir
	doLog "INFO created the following relative package:"
	doLog "INFO `stat -c \"%y %n\" $zip_file_name`"

	mkdir -p $network_backup_dir && \
	cmd="cp -v $zip_file $product_dir/data/zip/" && doRunCmdOrExit "$cmd" && \
	doLog "INFO with the following local backup  :" && \
	doLog "INFO `stat -c \"%y %n\" $product_dir/data/zip/$zip_file_name`" && \
	doLog "INFO in the network dir @::" && \
	doLog "INFO :: $network_backup_dir" && \
	cmd="cp -v $zip_file $network_backup_dir/$zip_file_name" && doRunCmdOrExit "$cmd" && \
	doLog "INFO with the following network backup  :" && \
	doLog "INFO `stat -c \"%y %n\" \"$network_backup_dir/$zip_file_name\"`"

	flag_completed=1

}
#eof doCreateRelativePackage
