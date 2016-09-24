# v1.0.7 
#------------------------------------------------------------------------------
# increase or decrease the version of the product
# bash sfw/bash/lp_nettilaskuri/lp_nettilaskuri.sh -a to-ver=0.0.5
#------------------------------------------------------------------------------
doChangeVersion(){

	tgt_version="$1"
	shift 1;
	prefix='to-ver='
	tgt_version=${tgt_version#$prefix}
	tgt_environment_name=$(echo $environment_name | perl -ne "s/$product_version/$tgt_version/g;print")
	# yest the new version is always dev !!!
	tgt_environment_name=$(echo $tgt_environment_name | perl -ne "s/$env_type/dev/g;print")
	tgt_product_version_dir=$product_dir/$tgt_environment_name
	mkdir -p $tgt_product_version_dir	

	test "$tgt_product_version_dir" == "$product_version_dir" && return
	# remove everything from the tgt product version dir - no extra files allowed !!!
	rm -fvr $tgt_product_version_dir/*
	test $? -eq 0  || doExit 2 "cannot write to $tgt_product_version_dir !"
	
	doCreateRelativePackage
	unzip -o $zip_file -d $tgt_product_version_dir
	cp -v $zip_file $tgt_product_version_dir

	# ensure that all the files in the target product version dir are indentical to the current ones
	while read -r file ; do (
		doLog "DEBUG comparing src file: $file"
		doLog "DEBUG to tgt file: $tgt_product_version_dir/$file"
		#cmd='diff "'"$product_version_dir/$file"'" "'"$tgt_product_version_dir/$file"'"'
		test -f "$product_version_dir/$file" \
			&& diff "$product_version_dir/$file" "$tgt_product_version_dir/$file"
		[[ $? != 0 ]] && exit $?
		#test -f "$product_version_dir/$file" && doRunCmdOrExit $cmd
		
	);
	done < <(cat $include_file)

}
#eof doChangeVersion

