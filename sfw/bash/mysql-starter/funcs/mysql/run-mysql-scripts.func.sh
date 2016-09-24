#
#------------------------------------------------------------------------------
# run all the mysql scripts by connecting to 
#------------------------------------------------------------------------------
doRunMySqlScripts(){
	
	doLog "DEBUG START :: doRunMySqlScripts"

	export tmp_log_file=$tmp_dir/.$$.log
	doLog " START == running sql scripts "	
	#sleep 1 ; 
	#flush the screen
	printf "\033[2J";printf "\033[0;0H"
	
	echo $mysql_user 
	#set -e
	#run the create database script by passing the name of the db from the ini file
	test -z "$sql_dir" && mysql -u"$mysql_user" -p"$mysql_user_pw" \
	-e "set @mysql_db='$mysql_db';source \
	$product_version_dir/sfw/sql/mysql/mysql-starter/00.create-mysql-starter-db.mysql ;" > "$tmp_log_file" 2>&1
	
	test -z "$sql_dir" \
			&& export sql_dir="$product_version_dir/sfw/sql/mysql/mysql-starter"

	# if a relative path is passed add to the product version dir
	[[ $sql_dir == /* ]] || export sql_dir="$product_version_dir""$sql_dir"
	#sleep 10

	# show the developer what happened
	cat "$tmp_log_file" 

	# and save the tmp log file into the log file
	cat "$tmp_log_file" >> $log_file

	#flush the screen
	printf "\033[2J";printf "\033[0;0H"
	
	echo -e "should run the following sql files : \n" 
	find "$sql_dir" -type f -name "*.sql"|sort -n
	sleep 2

	# run the sql scripts in alphabetical order
	while read -r sql_script ; do (

		#just to have it clearer
		relative_sql_script=$(echo $sql_script|perl -ne "s#$product_version_dir##g;print")

		# give the poor dev a time to see what is happening

		# and clear the screen
		printf "\033[2J";printf "\033[0;0H"

		doLog " INFO START ::: running $relative_sql_script"
		echo -e '\n\n'
		# set the params ... Note the quotes - needed for non-numeric values 
		# run the sql save the result into a tmp log file
		mysql -t -u"$mysql_user" -p"$mysql_user_pw" -D"$mysql_db" < "$sql_script" > "$tmp_log_file" 2>&1

		# show the user what is happenning 
		cat "$tmp_log_file"
		# and save the tmp log file into the script log file
		cat "$tmp_log_file" >> $log_file
		echo -e '\n\n'
		doLog " INFO STOP  ::: running $relative_sql_script"
		#debug sleep 1 

	);
	done < <(find "$sql_dir" -type f -name "*.sql"|sort -n)
	
	doLog " STOP  == running sql scripts "	
	# and clear the screen
	printf "\033[2J";printf "\033[0;0H"
	doLog "DEBUG STOP doRunMySqlScripts"
	set +e
}
#eof func doRunProjectMySqlScripts
