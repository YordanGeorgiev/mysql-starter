#!/bin/bash


#v0.2.3
#------------------------------------------------------------------------------
# creates a package from the relative file paths specified in the .dev file
#------------------------------------------------------------------------------
doTestCreateRelativePackage(){
	doLog " START : create-relative-package.test"

	# doSpecCreateRelativePackage
	bash sfw/bash/mysql-starter/mysql-starter.sh -a create-relative-package
	
	doLog " STOP  : create-relative-package.test"
}
#eof doCreateRelativePackage
