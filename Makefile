default: teisimple
TEXTS=/tmp/ota
docx:
	teitodocx --profile=tei teisimple.xml teisimple.docx

teisimple:
	xlsxtotei TEISimplespreadsheet.xlsx TEISimplespreadsheet.xml
	saxon TEISimplespreadsheet.xml generate.xsl> teisimple.odd 
	teitorelaxng teisimple.odd teisimple.rng
	trang teisimple.rng teisimple.rnc

validate:
	cat anthead.xml> v.xml 
	find $(TEXTS) -name "*.xml"  | sed 's/\(.*\)/<dojob name="\1"\/>/' >> v.xml
	cat anttail.xml >> v.xml
	ant -lib lib/saxon9he.jar:lib/jing.jar -Dbasedir=`pwd` -f v.xml       
	rm v.xml

#ANT_OPTS="-Xss2m -Xmx752m" ant -lib lib/saxon9he.jar:lib/jing.jar -Dbasedir=`pwd` -f v.xml

