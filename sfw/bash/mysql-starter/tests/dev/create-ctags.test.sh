
# v1.0.7
#------------------------------------------------------------------------------
# creates the ctags file for the projet
#------------------------------------------------------------------------------
doTestCreateCtags(){
	doLog " INFO START : create-ctags.test"

	# doSpecCreateCtags
	sleep 1	
	bash sfw/bash/mysql-starter/mysql-starter.sh -a create-ctags
	
	test -f tags && echo "test passed - tags file exists" && echo test ok
	test -f tags || echo "test failed - tags file does ot exist" && test NOK

	doLog " INFO STOP  : create-ctags.test"
}
#eof test doCreateCtags
