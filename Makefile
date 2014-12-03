default: teisimple
TEXTS=/Volumes/Repo/Simple
XSL=../Stylesheets
ANT_OPTS="-Xss2m -Xmx752m" 
docx:
	teitodocx --profile=tei teisimple.xml teisimple.docx

teisimple:
	ANT_OPTS=${ANT_OPTS} ant -lib lib/saxon9he.jar:lib/jing.jar 	

validate:
	cat anthead.xml> v.xml 
	find $(TEXTS) -name "*.xml"  | perl -p -e 's:(.*)/([A-z0-9_\-\.]+).xml:<dojob file="\2.xml" name="\1/\2.xml"/>:' >> v.xml
	cat anttail.xml >> v.xml
	ANT_OPTS=${ANT_OPTS} ant -lib lib/saxon9he.jar:lib/jing.jar -Dbasedir=`pwd` -f v.xml       


#ANT_OPTS="-Xss2m -Xmx752m" ant -lib lib/saxon9he.jar:lib/jing.jar -Dbasedir=`pwd` -f v.xml

