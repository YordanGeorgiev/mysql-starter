#v0.2.1
#------------------------------------------------------------------------------
#  gmail the latest created package - requires mutt binary !!!
#------------------------------------------------------------------------------
doPrintHelpForGmailPackage(){
	
	mutt --help >/dev/null 2>&1 ||
	{ doLog "ERROR. mutt is not installed or not in PATH. Aborting." >&2; exit 1; }

	zip_file=$(cat "$tmp_dir/zip_file")
	# take the latest modified zip file if we ran without a create-package call
	test -z "$zip_file" && \
		zip_file=$(stat -c "%y %n" $product_dir/*.zip \
			| sort -nr | head -n 1 | perl -nle '@t=split /\s+/;print $t[3]')
   zip_file_name=`basename $zip_file`


	# create a fake txt file type attachment
	cp -v "$zip_file" "$zip_file"'.txt'

	# and send it
	echo $zip_file>$tmp_dir/.msg
	set -x
	for Email in $Emails; do (
		mutt -s "$mail_msg ::: ""$zip_file_name" -a "$zip_file"'.txt' -- "$Email" < $tmp_dir/.msg
	);
	done
	set +x

	rm -fv "$zip_file"'.txt'	
}

