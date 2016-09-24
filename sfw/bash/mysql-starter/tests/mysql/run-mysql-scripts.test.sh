#
#------------------------------------------------------------------------------
# run all the mysql scripts by connecting to the correct db by lang_code param
# issue-258
#------------------------------------------------------------------------------
doTestRunMySqlScripts(){
	
	doLog "DEBUG START doTestRunMySqlScripts"
	
	# present the specs for this functionality	
	cat docs/txt/mysql-starter/specs/mysql/run-mysql-scripts.txt
	# 
	cat docs/txt/mysql-starter/help/run-mysql-scripts.txt
	sleep 2 	
	# Action !!!
	bash sfw/bash/mysql-starter/mysql-starter.sh -a run-mysql-scripts

	doLog "DEBUG STOP doTestRunMySqlScripts"
}
#eof func doRunProjectMySqlScripts
