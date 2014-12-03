#TEI Simple Processing Model#

**Warning:** *work in progress*

  * 1. Default Simple Processing Model
  * 1. Simple Processing Language
      - ODD extensions
      - proposed syntax
      - function library
  * 1. Proof-of-concept use cases
      
##Default Simple Processing Model##

TEI Simple will offer a default processing model for TEI Simple files to generate a range of output formats that nevertheless behave in a consistent way 
(the formatting means will be equivalent across the output types except for the cases where medium requires different treatment or different behaviour will be deemed more effective, 
eg. notes might be rendered as footnotes in 'reading' formats like pdf and as pop-up boxes in 'interactive' formats like html).

If the user is satisfied with the proposed Default Processing Model, no further customization will be necessary to generate required outputs from TEI Simple files.

##Simple Processing Language##

###ODD extensions###

New ODD element called **process** available for **<elementSpec>** will define a way of processing this element
Multiple processing instructions may occur to define expected behaviour in various contexts or output formats

How does it work?
  * 1. Processing modes define a format-independent way of expressing required output for different use scenarios (eg. print, web, table of contents, text extraction).
  * 2. Function library that can handle typical tasks (like creating a note or paragraph) is an essential part of TEI Simple environment.
  * 3. *The output can be mapped to a presentation format, using HTML and CSS concepts where possible.*????

###Proposed process syntax (preliminary)###

Attributes of process element:
  * __context__ XPath expression defining a context in which this processing instruction is applicable
  * __name__ name of the function from TEI Simple function library to be applied; input for the function supplied as function parameter
  * __mode__ output mode for which this processing instruction is applicable
  * __style/class__ css class or simple:class name of formatting instruction to be applied to the output

Defaults:
  * if no process for any given mode, emit textual content
  * if no @context, means any use of this element
  * process rules are additive, not alternates
  * @style defaults to element name (equates to HTML @class or Word style)
  * @mode defaults to 'render' (????)
  * appearance overridden by @rendition and @style
  * <rendition> override remote CSS

####Examples####

    <elementSpec ident="app">
        <process context="not(ancestor::app) and (lem)"  name="makeMarginalNote(.)" mode="render" class="note"/>
        <process name="makeInline(.)" content="lem" mode="render"/>
        <process name="makeInline(.)" content="lem" mode="textextract"/>
    </elementSpec>

    <elementSpec ident="fw">
        <process name="omit()" mode="render"/>
        <process name="makeMarginalNote(.)" mode="diplomatic"/>
    </elementSpec>

    <elementSpec ident="titlePage">
        <process name="makeBlock(.)" mode="render"/>
        <process name="omit()" mode="textextract"/>
    </elementSpec>

    <elementSpec ident="lb">
        <process name="makeNewline()" mode="diplomatic"/>
        <!-- no specific process instruction for default "render"  mode means to output textual content (in this case: no output)-->
    </elementSpec>
####Function library###


##Proof-of-concept use cases##

###Odd by example###

Oddbyexample tool available from https://github.com/TEIC/Stylesheets/blob/master/tools/oddbyexample.xsl can generate an ODD file based on the actual usage from the corpus of TEI files.

Typical use:
saxon -it:main -o:myodd ../../../Stylesheets/tools/oddbyexample.xsl  corpus=`pwd`

It was used to generate ODDs for the examples below, which were further enriched with process instructions and transformed to xslt with prototype SPM processor. 
Transformation makes use of the prototype version of Simple Function Library (functions.xsl)

###Treasure Island###

*All files to be found in __TreasureIsland__ subdirectory of this repository*

Original OTA xml source file to be found here: http://ota.ahds.ac.uk/desc/5730

ti.odd file was generated with oddbyexample and process instructions were manually added. Then ti.odd was transformed into ti.xsl by means of simpleoddtoxsl.xsl

In total 10 **process** instructions was enough to recreate the processing scenario employed by OTA to publish HTML version of the file. 
Only 4 functions from Simple Function Library were used: makeBlock, makeParagraph, makeHeader and makeNewline.


###Romeo and Juliet###

*All files to be found in __RomeoJuliet__ subdirectory of this repository*

Original OTA xml source file to be found here: http://ota.ahds.ac.uk/desc/5721

###...###
      
