<?xml version="1.0" encoding="UTF-8"?>
<?xml-model href="http://www.schematron.com/iso/iso-schematron.rnc" type="application/relax-ng-compact-syntax"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
    <title>Schematron extension of the DTA ›Base Format‹ (DTABf)</title>
    <!-- This document contains the Schematron extension of the DTA ›Base Format‹ (DTABf).
    First published on November 5th, 2014.
    Author: Susanne Haaf.
    Publisher: Deutsches Textarchiv (Matthias Boenig, Alexander Geyken, Susanne Haaf, Bryan Jurish, 
        Christian Thomas, Frank Wiegand), Berlin-Brandenburg Academy of Sciences and Humanities (BBAW), 
        Jägerstr. 22/23, 10117 Berlin. 
    Licence: Distributed under the Creative Commons Attribution-NonCommercial 3.0 Unported License 
        (CC by-NC; http://creativecommons.org/licenses/by-nc/3.0/de/). -->
    
    <ns prefix="tei" uri="http://www.tei-c.org/ns/1.0"/>
    <ns prefix="xs" uri="http://www.w3.org/2001/XMLSchema"/>

    <pattern id="abbrElement">
        <rule context="tei:abbr">
            <report test="@type" role="ERROR">
                [E0002] Attribute "type" not allowed within element "abbr".
            </report>
        </rule>
    </pattern>

    <pattern id="allElements">
        <rule context="tei:*">
            <report test="@rendition and @rend" role="WARNING">
                [W0001] The usage of @rend or @rendition should be exclusionary.
            </report>
        </rule>
    </pattern>

    <pattern id="allTextNodes">
        <rule context="text()[contains(., '@')]">
            <report test="ancestor::tei:text" role="WARNING">
                [W0002] The uncommon character '@' has been used within the text area.
            </report>
        </rule>
    </pattern>

    <pattern id="biblElement">
        <rule context="tei:bibl">
            <report test="ancestor::tei:quote" role="ERROR">
                [E0003] Element "<name/>" not allowed within element "quote".
            </report>
            <assert test="child::* or child::text()[normalize-space(.)]" role="ERROR">
                [E0004] Element "<name/>" may not be empty.
            </assert>
        </rule>
    </pattern>

    <pattern id="capitalLetterI">
        <let name="x" value="(//tei:*[contains(@rendition,'#aq')] or //tei:*[contains(@rendition, '#fr')]) and //tei:text//text()[not(ancestor::tei:*[contains(@rendition,'#aq')])][contains(., 'I')]"/>
        <rule context="//tei:TEI">
            <report test="$x" role="WARNING">
                [W0004] The document contains capital letter I within Fraktur text. Should be capital letter J? 
                Search for XPath //text//text()[not(ancestor::*[contains(@rendition,'#aq')])][contains(., 'I')] 
                to find all text nodes with incorrect instances of capital 'I' within the document. 
            </report>
        </rule>
    </pattern>

    <pattern id="choiceElement">
        <rule context="tei:choice">
            <assert test="count(*) > 1" role="ERROR">
                [E0005] Element "<name/>" must have at least two child elements.
            </assert>
        </rule>
    </pattern>

    <pattern id="choiceSubelements">
        <rule context="tei:corr | tei:expan | tei:reg | tei:sic">
            <assert test="parent::tei:choice" role="ERROR">
                [E0013] Element "<name/>" must have a parent element "choice".
            </assert>
        </rule>
    </pattern>

    <pattern id="corrElement">
        <rule context="tei:corr">
            <assert test="count(preceding-sibling::tei:sic | following-sibling::tei:sic) = 1" role="ERROR">
                [E0006] Element "<name/>" must have exactly one corresponding "sic" element.
            </assert>
        </rule>
    </pattern>

    <pattern id="correspAttribute">
        <rule context="tei:*[@corresp]">
            <assert test="matches(@corresp, '^#|^https?://')" role="ERROR">
                [E0028] The value of attribute @corresp must be a URL or same document reference 
                starting with 'http://' or 'https://' or '#'.
            </assert>
            <assert test="if (starts-with(@corresp, '#')) then //@xml:id = substring-after(@corresp, '#') else 1" role="error">
                [E0026] The value of attribute @corresp must have a corresponding @xml:id-value within the same document.
            </assert>
        </rule>
    </pattern>
    
    <pattern id="divTypeAdvertisement">
        <rule context="tei:div[@type='advertisement']">
            <report test="preceding::tei:div[@type[matches(., '^j[A-Z]')]] | following::tei:div[@type[matches(., 'j[A-Z]')]] | 
                ancestor::tei:div[@type[matches(., 'j[A-Z]')]] | descendant::tei:div[@type[matches(., 'j[A-Z]')]]" role="ERROR">
                [E0027] Value @type="advertisement" in element "div" not allowed within newspapers or journals; 
                expected values are "jAnnouncements" or "jAn".
            </report>
        </rule>
    </pattern>
    
    <pattern id="expanElement">
        <rule context="tei:expan">
            <assert test="count(preceding-sibling::tei:abbr | following-sibling::tei:abbr) = 1" role="ERROR">
                [E0007] Element "<name/>" must have exactly one corresponding "abbr" element.
            </assert>
        </rule>
    </pattern>

    <pattern id="facsInsideFirstPagebreak">
        <rule context="tei:pb[1][not(preceding::tei:pb)]">
            <assert test="@facs[matches(., '^#f0001$')]" role="ERROR">
                [E0015] Value of @facs within first "pb" incorrect; expected value: #f0001. 
            </assert>
        </rule>
    </pattern>

    <pattern id="facsInsidePagebreaks">
        <rule context="tei:pb[@facs]">
            <assert test="if (matches(@facs, '^#f\d\d\d\d') and matches(preceding::tei:pb[1]/@facs, '^#f\d\d\d\d') and (preceding::tei:pb)) then xs:integer(substring(@facs, 3)) = preceding::tei:pb[1]/xs:integer(substring(@facs, 3)) +1 else 1" role="ERROR">
                [E0014] Value of @facs within "pb" incorrect; @facs-values of "pb"-elements have 
                to increase by 1 continually starting with #f0001.
            </assert>
        </rule>
    </pattern>

    <pattern id="facsOutsidePagebreaks">
        <rule context="tei:*[@facs][not(self::tei:pb)]">
            <assert test="matches(@facs, '^#|^https?://')" role="ERROR">
                [E0016] The value of attribute @facs must be a URL or same document reference 
                starting with 'http://' or 'https://' or '#'.
            </assert>
        </rule>
    </pattern>

    <pattern id="kValueInRenditionAttribute">
        <rule context="tei:*[@rendition='#k']">
            <report test="contains(self::tei:*, 'ſ')" role="ERROR">
                [E0018] Long s not allowed within small capitals area.
            </report>
        </rule>
    </pattern>

    <pattern id="nextAttribute">
        <rule context="tei:*[@next]">
            <assert test="starts-with(@next, '#')" role="ERROR">
                [E0017] The value of attribute @next must be a same document reference starting with '#'.
            </assert>
            <assert test="if (starts-with(@next, '#')) then //@xml:id = substring-after(@next, '#') else 1" role="error">
                [E0019] The value of attribute @next must have a corresponding @xml:id-value within the same document.
            </assert>
        </rule>
    </pattern>

    <pattern id="pbElement">
        <rule context="tei:pb">
            <assert test="@facs[matches(., '#f[0-9]{4}')] and @facs[matches(., '^#f0*([1-9][0-9]*)$')]" role="ERROR">
                [E0008] Wrong format of @facs-value in element "<name/>"; should be "#f" followed by 4 digits (0-9) starting with 
                #f0001 and increasing by 1 continually. 
            </assert>
        </rule>
    </pattern>

    <pattern id="prevAttribute">
        <rule context="tei:*[@prev]">
            <assert test="starts-with(@prev, '#')" role="ERROR">
                [E0025] The value of attribute @prev must be a same document reference starting with '#'.
            </assert>
            <assert test="if (starts-with(@prev, '#')) then //@xml:id = substring-after(@prev, '#') else 1" role="error">
                [E0021] The value of attribute @prev must have a corresponding @xml:id-value within the same document.
            </assert>
        </rule>
    </pattern>
    
    <pattern id="regElement">
        <rule context="tei:reg">
            <assert test="count(preceding-sibling::tei:orig | following-sibling::tei:orig) = 1" role="ERROR">
                [E0009] Element "<name/>" must have exactly one corresponding "orig" element.
            </assert>
        </rule>
    </pattern>

    <pattern id="respElement">
        <rule context="tei:resp">
            <assert test="child::tei:*" role="ERROR">
                [E0010] Element "<name/>" must have at least one child element.
            </assert>
            <report test="child::text()[normalize-space(.)]" role="ERROR">
                [E0011] Text not allowed here; expected child element or closing tag.
            </report>
        </rule>
    </pattern>

    <pattern id="salute">
        <rule context="tei:salute">
            <assert test="ancestor::tei:opener|ancestor::tei:closer">
                [E0030] The element "salute" may only occur within the elements "opener" or "closer".
            </assert>
        </rule>
    </pattern>
    
    <pattern id="sameAsAttribute">
        <rule context="tei:*[@sameAs]">
            <assert test="starts-with(@sameAs, '#')" role="ERROR">
                [E0022] The value of attribute @sameAs must be a same document reference starting with '#'.
            </assert>
            <assert test="if (starts-with(@sameAs, '#')) then //@xml:id = substring-after(@sameAs, '#') else 1" role="error">
                [E0023] The value of attribute @sameAs must have a corresponding @xml:id-value within the same document.
            </assert>
        </rule>
    </pattern>

    <pattern id="sicElement">
        <rule context="tei:sic">
            <assert test="count(preceding-sibling::tei:corr | following-sibling::tei:corr) = 1" role="ERROR">
                [E0012] Element "<name/>" must have exactly one corresponding "corr" element.
            </assert>
        </rule>
    </pattern>

    <pattern id="signed">
        <rule context="tei:signed">
            <assert test="ancestor::tei:closer">
                [E0029] The element "signed" may only occur within the element "closer".
            </assert>
        </rule>
    </pattern>

    <pattern id="targetAttribute">
        <rule context="tei:*[@target]">
            <assert test="matches(@target, '^#|^https?://')" role="ERROR">
                [E0024] The value of attribute @target must be a URL or same document 
                reference starting with 'http://' or 'https://' or '#' or '#f'.
            </assert>
            <assert test="if (starts-with(@target, '#') and not(starts-with(@target, '#f'))) then //@xml:id = substring-after(@target, '#') else 1" role="error">
                [E0032] Value of attribute @target must have a corresponding @xml:id-value within the same document.
            </assert>
            <assert test="if (starts-with(@target, '#f')) then //tei:pb/@facs = //./@target else 1" role="error">
                [E0020] Value of attribute @target must have a corresponding @facs-value 
                within a &lt;pb&gt; element in the same document.
            </assert>
            <assert test="if (. = tei:licence) then starts-with(@target, 'https?://') else 1" role="error">
                [E0031] Value of attribute @target must have a corresponding @facs-value 
                within a pb-element in the same document.
            </assert>
        </rule>
    </pattern>

    <pattern id="teiHeaderElements">
        <rule context="tei:addName | tei:address | tei:addrLine | tei:email | tei:biblFull | tei:country | 
            tei:forename | tei:genName | tei:measure | tei:msDesc | tei:nameLink | tei:publicationStmt | 
            tei:resp | tei:respStmt | tei:roleName | tei:surname | tei:titleStmt | tei:title">
            <report test="ancestor::tei:text" role="ERROR">
                [E0001] Element "<name/>" not allowed anywhere within element "text".
            </report>
        </rule>
    </pattern>
    
    <pattern id="tironianSignEtInText">
        <rule context="text()[contains(., '&#x204A;')]">
            <report test="ancestor::tei:text" role="WARNING">
                [W0003] The Unicode character 'U+204A' (Tironian sign et) has been used; check, if the source character is 'U+A75B' (Latin small letter r rotunda) instead.
            </report>
        </rule>
    </pattern>

    <pattern id="underbar">
        <rule context="text()[contains(.,'_ _')]">
            <report test="ancestor::tei:text" role="WARNING">
                [W0005] The string "_ _" has been used; check, if this is an adequate transcription of the source.
            </report>
        </rule>
    </pattern>

</schema>

