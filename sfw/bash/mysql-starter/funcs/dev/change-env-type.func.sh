# v1.0.7
#------------------------------------------------------------------------------
# zip all the files specified in the include file relatively 
# and uunzip them into ../mysql-starter.<<version>>.<<new_environment>>.<<owner>>
#------------------------------------------------------------------------------
doChangeEnvType(){

	tgt_env="$1"
	tgt_environment_name=$(echo $environment_name | perl -ne "s/$env_type/$tgt_env/g;print")
	tgt_product_version_dir=$product_dir/$tgt_environment_name
	mkdir -p $tgt_product_version_dir	
	test $? -ne 0 && doExit 2 "Failed to create $tgt_product_version_dir !"

	test "$tgt_env" == "$env_type" && return
	# remove everything from the tgt product version dir - no extra files allowed !!!
	rm -fvr $tgt_product_version_dir/*
	test $? -eq 0  || doExit 2 "cannot write to $tgt_product_version_dir !"
	
	doCreateRelativePackage
	unzip -o $zip_file -d $tgt_product_version_dir
	cp -v $zip_file $tgt_product_version_dir

	# ensure that all the files in the target product version dir are indentical to the current ones
	for file in `cat $include_file`; do (
		cmd="diff $product_version_dir/$file $product_version_dir/$file"
		doRunCmdOrExit "$cmd"
	);
	done

}
#eof func doChangeEnvType
