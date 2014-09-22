default: teisimple

docx:
	teitodocx --profile=tei teisimple.xml teisimple.docx

teisimple:
	teitorelaxng teisimple.odd teisimple.rng
	trang teisimple.rng teisimple.rnc
