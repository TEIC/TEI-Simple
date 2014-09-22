default: teisimple

docx:
	teitodocx --profile=tei teisimple.xml teisimple.docx

teisimple:
	xlsxtotei TEISimplespreadsheet.xlsx TEISimplespreadsheet.xml
	saxon TEISimplespreadsheet.xml generate.xsl> teisimple.odd 
	teitorelaxng teisimple.odd teisimple.rng
	trang teisimple.rng teisimple.rnc

