default: teisimple
TEXTS=/Volumes/Repo/Simple/ota
XSL=../Stylesheets
ANT_OPTS="-Xss2m -Xmx752m" 
docx:
	teitodocx --profile=tei teisimple.xml teisimple.docx

teisimple:
	xlsxtotei TEISimplespreadsheet.xlsx TEISimplespreadsheet.xml
	saxon TEISimplespreadsheet.xml generate.xsl> teisimple.odd 
	teitorelaxng teisimple.odd teisimple.rng
	teitodtd teisimple.odd teisimple.dtd
	teitoxsd teisimple.odd teisimple.xsd
	teitoodd teisimple.odd teisimple.odd.compiled
	trang teisimple.rng teisimple.rnc
	saxon teisimple.odd.compiled ${XSL}/odds/extract-isosch.xsl > teisimple.isosch
	saxon teisimple.isosch isoschematron/iso_schematron_skeleton_for_saxon.xsl > teisimple.isosch.xsl

test:
	jing teisimple.rng tests/testsimple.xml
	jing teisimple.xsd tests/testsimple.xml
	xmllint --noout --dtdvalid teisimple.dtd tests/testsimple.xml


validate:
	cat anthead.xml> v.xml 
	find $(TEXTS) -name "*.xml"  | perl -p -e 's:(.*)/([^\.]+).xml:<dojob file="\2.xml" name="\1/\2.xml"/>:' >> v.xml
	cat anttail.xml >> v.xml
	ANT_OPTS=${ANT_OPTS} ant -lib lib/saxon9he.jar:lib/jing.jar -Dbasedir=`pwd` -f v.xml       
	rm v.xml

#ANT_OPTS="-Xss2m -Xmx752m" ant -lib lib/saxon9he.jar:lib/jing.jar -Dbasedir=`pwd` -f v.xml

