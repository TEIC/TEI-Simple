default: teisimple  pm
TEXTS=/Users/rahtz/GDrive/Simple/
XSL=../Stylesheets
ANT_OPTS="-Xss2m -Xmx752m" 

teisimple:
	xmllint --xinclude teisimple.odd > xsimple.odd
	ANT_OPTS=${ANT_OPTS} ant -lib lib/saxon9he.jar:lib/jing.jar -DXSL=$(XSL) 

chain:
	ANT_OPTS=${ANT_OPTS} ant -lib lib/saxon9he.jar:lib/jing.jar -DXSL=$(XSL) chain

pm:
	ANT_OPTS=${ANT_OPTS} ant -lib lib/saxon9he.jar:lib/jing.jar -DXSL=$(XSL) pm

validate:
	cat anthead.xml> v.xml 
	find "$(TEXTS)" -name "*.xml"  | perl -p -e 's:(.*)/([A-z0-9_\-\.]+).xml:<dojob file="\2.xml" name="\1/\2.xml"/>:' >> v.xml
	echo "</target></project>" >> v.xml
	ANT_OPTS=${ANT_OPTS} ant -lib lib/saxon9he.jar:lib/jing.jar -Dxsl=${XSL} -Dbasedir=`pwd` -f v.xml       

oxygen:
	mkdir -p frameworks/teisimple
	cp tei_simple.framework build-oxygen.xml teisimple.odd elementsummary.xml headeronly.xml simpleelements.xml teisimple.rng teisimple.isosch teisimple.nvdl polygon/*xsl tests/simple.css tests/simple.js frameworks/teisimple
	zip -r simpleoxygen frameworks


