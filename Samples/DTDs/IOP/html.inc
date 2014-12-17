<!-- ###########################################################################
#
#   File name: html.inc
#   Project: Journals
#   Description: HTML definitions for inclusion in Journals DTDs
#
#
#   External documents:
#
#
#   Author: Peter Haworth
#   Date created: 13/08/1999
#
#   $Id$
#
#   Copyright Institute of Physics Publishing 1999-2009
#   Portions Copyright International Organization for Standardization 1986
#
############################################################################ -->


<!-- %html_line; allows HTML style font changing, but not much else -->
<!ENTITY % html_straight "#PCDATA|B|I|SUP|SUB|U|IMG|BR|A|iopmath|FONT|SPAN|TT">
<!ENTITY % html_basic "%html_straight;|footnote">
<!ENTITY % html_line "(%html_basic;)*">

<!-- %html_text; is supposed to allow anything which is valid HTML -->
<!ENTITY % html_fancy "P|DL|OL|UL|H1|H2|H3|H4|H5|H6|HR|TABLE|MAP|CENTER|NOBR|DIV">
<!ENTITY % html_text "(%html_basic;|%html_fancy;)*">

<!-- These are the elements allowed in %html_line -->
<!ELEMENT B (%html_straight;)*>
<!ELEMENT I (%html_straight;)*>
<!ELEMENT SUP (%html_straight;)*>
<!ELEMENT SUB (%html_straight;)*>
<!ELEMENT U (%html_straight;)*>
<!ELEMENT TT (%html_straight;)*>
<!ELEMENT IMG EMPTY>
<!ATTLIST IMG
  SRC CDATA #REQUIRED
  ALT CDATA ""
  WIDTH CDATA #IMPLIED
  HEIGHT CDATA #IMPLIED
  BORDER CDATA #IMPLIED
  USEMAP CDATA #IMPLIED
  ALIGN (MIDDLE|BOTTOM|TOP|LEFT|RIGHT|ABSMIDDLE|TEXTTOP|BASELINE|ABSBOTTOM) #IMPLIED
  entity CDATA #IMPLIED
> <!-- entity is the entity which was converted to the image -->
<!ELEMENT BR EMPTY>

<!-- These elements are allowed in %html_text -->
<!ELEMENT A (%html_straight;)*>
<!ATTLIST A
  HREF CDATA #IMPLIED
  NAME CDATA #IMPLIED
  TARGET CDATA #IMPLIED
  article CDATA #IMPLIED
  issue CDATA #IMPLIED
  volume CDATA #IMPLIED
> <!-- article will be converted to HREF by the interface.
	Contents should be of the form: $issn/$volume/$issue/$artnum
        Similarly for issue: $issn/$volume/$issue, volume: $issn/$volume -->

<!ELEMENT P (%html_basic;
  |UL|OL|DL|H1|H2|H3|H4|H5|H6|HR|MAP|TABLE|CENTER|NOBR
)*>

<!ELEMENT DL ((DT,DD?)*)>
<!ATTLIST DL
  COMPACT (COMPACT) #IMPLIED
>
<!ELEMENT DT %html_line;>
<!ELEMENT DD %html_text;>

<!ELEMENT OL (LI*)>
<!ELEMENT UL (LI*)>
<!ELEMENT LI %html_text;>

<!ELEMENT H1 %html_line;>
<!ELEMENT H2 %html_line;>
<!ELEMENT H3 %html_line;>
<!ELEMENT H4 %html_line;>
<!ELEMENT H5 %html_line;>
<!ELEMENT H6 %html_line;>

<!ELEMENT HR EMPTY>

<!ENTITY % table_atts "
  WIDTH CDATA #IMPLIED
  HEIGHT CDATA #IMPLIED
  BGCOLOR CDATA #IMPLIED
  ALIGN (LEFT|RIGHT|CENTER) #IMPLIED
  VALIGN (TOP|BOTTOM|CENTER) #IMPLIED
">

<!ELEMENT MAP (AREA*)>
<!ATTLIST MAP
  NAME CDATA #REQUIRED
>

<!ELEMENT AREA EMPTY>
<!ATTLIST AREA
  ALT CDATA #IMPLIED
  COORDS CDATA #REQUIRED
  HREF CDATA #REQUIRED
> 

<!ELEMENT TABLE (TR*)>
<!ATTLIST TABLE %table_atts;
  BORDER NMTOKEN #IMPLIED
>
<!ELEMENT TR (TH*|TD*)>
<!ATTLIST TR %table_atts;>
<!ELEMENT TH %html_text;>
<!ATTLIST TH %table_atts;
  COLSPAN NMTOKEN #IMPLIED
  ROWSPAN NMTOKEN #IMPLIED
>
<!ELEMENT TD %html_text;>
<!ATTLIST TD %table_atts;
  COLSPAN NMTOKEN #IMPLIED
  ROWSPAN NMTOKEN #IMPLIED
>

<!ELEMENT NOBR %html_line;>
<!ELEMENT CENTER %html_text;>

<!-- This is used to represent maths so we can update the HTML in the future
     The latex attribute holds the original latex code
     The container holds an HTML representation of that
  -->
<!ELEMENT iopmath %html_line;>
<!ATTLIST iopmath
  latex CDATA #REQUIRED
>

<!-- footnotes can be empty if they refer to an already defined footnote.
     In those cases, pos will be ignored
  -->
<!ELEMENT footnote (%html_straight;)*>
<!ATTLIST footnote
  id CDATA #REQUIRED
  pos (affil|aaffil|info_top|info_bottom) #REQUIRED
>

<!ELEMENT FONT %html_line;>
<!ATTLIST FONT
  FACE CDATA #IMPLIED
  SIZE CDATA #IMPLIED
  COLOR CDATA #IMPLIED
>

<!ELEMENT SPAN %html_line;>
<!ATTLIST SPAN
  STYLE CDATA #IMPLIED
  CLASS CDATA #IMPLIED
>

<!ELEMENT DIV %html_text;>
<!ATTLIST DIV
  STYLE CDATA #IMPLIED
  CLASS CDATA #IMPLIED
>

