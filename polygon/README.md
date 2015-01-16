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

How does it work?
  * 1. Processing modes define a format-independent way of expressing required output for different use scenarios (eg. print, web, table of contents, text extraction).
  * 2. Function library that can handle typical tasks (like creating a note or paragraph) is an essential part of TEI Simple environment.
  * 3. *The output can be mapped to a presentation format, using HTML and CSS concepts where possible.*????

New ODD element called **model** available for **elementSpec** will define a way of processing this element.

For a given **elementSpec**, there can be as many **model** statements as required to define expected behaviour in various contexts or output formats, each of which can have multiple **rendition** children. A set of multiple **model** statements is regarded as an alternation, i.e. only one of them will be applied; this is comparable to a ‘case statement’ in some programming languages. If the intention is for several **model** statements to be active at the same time, they must be enclosed inside a **modelSequence**.
For the sake of readability and conciseness **model**s can be also grouped with **modelGrp** and will then share **modelGrp**'s attributes such as @output, but will still be treated as alternates and only the first that matches the current context (as defined by **@predicate**) will be applied.

###Proposed **model** syntax ###

Attributes of **model** element:
  * __predicate__ XPath expression defining a context in which this processing instruction is applicable
  * __behaviour__ name of the function from TEI Simple function library to be applied; input for the function supplied as function parameters
  * __output__ output mode for which this processing instruction is applicable
  * __useSourceRendition__ states if the formatting from @rendition attribute of the source document should be preserved

Defaults:
  * if no **model** for any given output, emit textual content
  * if no **@predicate**, means any use of this element
  * **model** rules are alternates and only first one that matches will be applied
  * @style defaults to element name (equates to HTML @class or Word style)
  * when @output is not present it means valid for all outputs
  * appearance prescribed by **<rendition>**
  
####Examples####

    <elementSpec ident="app">
    <modelSequence output="web">
        <model predicate="not(ancestor::app) and (lem)"  behaviour="note(.)"/>
        <model behaviour="inline(lem)"/>
    </modelSequence>
    <model behaviour="inline(lem)" output="textextract"/>
    </elementSpec>

    <elementSpec ident="fw">
        <model behaviour="omit()"/>
        <model behaviour="note(., 'margin')" output="diplomatic"/>
    </elementSpec>

    <elementSpec ident="titlePage">
        <model behaviour="block(.)" output="web"/>
        <model behaviour="omit()" output="textextract"/>
    </elementSpec>

    <elementSpec ident="lb">
        <model behaviour="break('line')" output="diplomatic"/>
        <!-- no specific process instruction for default output means to output textual content (in this case: no output)-->
    </elementSpec>
 
 
####Function library###

##Prototype implementation [January 2015]##

The premise of processing model implementation is to generate XSLT stylesheet based solely on TEI Simple ODD file that contains <model>s and <rendition>s that define intended processing for TEI Simple elements. Base TEI Simple ODD can be found at https://github.com/TEIC/TEI-Simple/blob/master/teisimple.odd

_Please note that this is an incomplete prototype implementation that is not endorsed as the only or even suggested way of using TEI Simple processing model._

Processing model implementation files can be found in polygon subdirectory https://github.com/TEIC/TEI-Simple/tree/master/polygon and this is assumed to be working directory in all examples below.

To generate the XSLT stylesheet one can run following command:

    saxon -xi  -s:../teisimple.odd -o:simple.xsl -xsl:simpleoddtoxsl.xsl

That will generate simple.xsl file which can be used in turn to transform the TEI Simple documents, eg:

    saxon -s:../tests/5730.xml -o:../tests/treasureisland.html -xsl:simple.xsl

will produce html output for Treasure Island sample file.

To change the behaviour of this final transformation one needs to tweak appropriate sections of teisimple.odd and re-run both commands above to 1. regenerate simple.xsl stylesheet and 2. apply it to source document again.


##Proof-of-concept use cases [0ctober 2014]##

_proof-of-concept tests used previous element, attribute and function names_
_process is equivalent of model, name->behaviour, context->predicate etc_

###Odd by example###

Oddbyexample tool available from https://github.com/TEIC/Stylesheets/blob/master/tools/oddbyexample.xsl can generate an ODD file based on the actual usage from the corpus of TEI files.

Typical use:
saxon -it:main -o:myodd ../../../Stylesheets/tools/oddbyexample.xsl  corpus=`pwd`

It was used to generate ODDs for the examples below, which were further enriched with process instructions and transformed to xslt with prototype SPM processor. 
Transformation makes use of the prototype version of Simple Function Library (functions.xsl)

####Treasure Island####

*All files to be found in __TreasureIsland__ subdirectory of this repository*

Original OTA xml source file to be found here: http://ota.ahds.ac.uk/desc/5730

ti.odd file was generated with oddbyexample and process instructions were manually added. Then ti.odd was transformed into ti.xsl by means of simpleoddtoxsl.xsl

In total 10 **process** instructions was enough to recreate the processing scenario employed by OTA to publish HTML version of the file. 
Only 4 functions from Simple Function Library were used: makeBlock, makeParagraph, makeHeader and makeNewline.


####Romeo and Juliet####

*All files to be found in __RomeoJuliet__ subdirectory of this repository*

Original OTA xml source file to be found here: http://ota.ahds.ac.uk/desc/5721

Romeo and Juliet underwent the same process as Treasure Island. 
###...###
      
