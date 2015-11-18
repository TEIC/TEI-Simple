default: teisimple  pm
TEXTS=/Users/rahtz/GDrive/Simple/
XSL=../TEI/Stylesheets
ANT_OPTS="-Xss2m -Xmx752m" 

teisimple:
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
	cp oxygen/tei_simple.framework oxygen/build-oxygen.xml odd/teisimple.odd odd/elementsummary.xml odd/headeronly.xml odd/simpleelements.xml teisimple.rng teisimple.isosch teisimple.nvdl processingModel/*xsl tests/simple.css tests/simple.js frameworks/teisimple
	zip -r simpleoxygen frameworks


