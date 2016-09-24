#!/bin/bash 

#v1.0.7
#------------------------------------------------------------------------------
# creates the full package as component of larger product platform
#------------------------------------------------------------------------------
doTestCreateFullPackage(){
	doLog " INFO START : create-full-package.test"

	doSpecCreateFullPackage
	sleep 1	
	bash sfw/bash/mysql-starter/mysql-starter.sh -a create-full-package
	
	doLog " INFO STOP  : create-full-package.test"
}
#eof test doCreateFullPackage

