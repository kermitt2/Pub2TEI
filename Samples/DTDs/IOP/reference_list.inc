<!-- ###########################################################################
#
#   File name: reference_list.inc
#   Project: Journals
#   Description: DTD for article references
#
#
#   External documents:
#
#
#   Author: Peter Haworth
#   Date created: 15/04/2002
#
#   $Id$
#
#   Copyright (C) IOP Publishing Ltd 2002-2013
#
############################################################################ -->

<!-- This is the real definition of reference_list.
     However, it is split into two files to avoid multiple inclusions
     of html.inc
 -->

<!ELEMENT reference_list (reference+)>
<!ATTLIST reference_list
  article CDATA #IMPLIED
>

<!ELEMENT reference (ref_id?,ref_label?,ref_citation,ref_doi?,
  ref_item_title?,ref_authors?,
  ref_journal?,ref_issn?,ref_volume?,ref_part?,ref_issue?,ref_artnum*,
  ref_year?,ref_start_page?,ref_end_page?,ref_preprint*,
  ref_series?,ref_edition?,ref_publication?,ref_chapter?,ref_place?,ref_target*)>

<!ATTLIST reference
  type (journal|book|thesis|preprint|conference|misc|heading|report|webpage|communication|patent) #REQUIRED
  correction_type (corrigendum|erratum|addendum|retraction|perspective) #IMPLIED
>


<!ELEMENT ref_id         (#PCDATA)> <!-- id from supplier XML -->
<!ELEMENT ref_label      (#PCDATA)>
<!ELEMENT ref_citation   %html_text;> <!-- The full citation, with formatting -->
<!ELEMENT ref_doi        (#PCDATA)>
<!ELEMENT ref_item_title %html_line;>
<!ELEMENT ref_authors    (%html_basic;|name|collab|others)*>
  <!ELEMENT name (surname*,given*,name_suffix?)>
  <!ELEMENT collab %html_line;>
  <!ELEMENT others %html_line;>
<!ELEMENT ref_journal    %html_line;>
<!ELEMENT ref_book       %html_line;>
<!ELEMENT ref_issn       (#PCDATA)>
<!ELEMENT ref_volume     (#PCDATA)>
<!ELEMENT ref_part       (#PCDATA)>
<!ELEMENT ref_issue      (#PCDATA)>
<!ELEMENT ref_artnum     (#PCDATA)>
<!-- This attribute is really only used by the production system,
     which overloads this element -->
<!ATTLIST ref_artnum
  type NMTOKEN #IMPLIED
>
<!ELEMENT ref_year       (#PCDATA)>
<!ELEMENT ref_start_page (#PCDATA)>
<!ELEMENT ref_end_page   (#PCDATA)>
<!ELEMENT ref_preprint   (#PCDATA)>
<!ATTLIST ref_preprint
  type NMTOKEN #IMPLIED
>
<!ELEMENT ref_series      (%html_basic;|volume)*>
  <!ELEMENT volume        %html_line;>
<!ELEMENT ref_edition     %html_line;>
<!ELEMENT ref_publication (%html_basic;|place|publisher)*>
  <!ELEMENT place %html_line;>
  <!ELEMENT publisher %html_line;>
<!ELEMENT ref_chapter     %html_line;>
<!ELEMENT ref_place       %html_line;>
<!ELEMENT ref_target      (#PCDATA)>
<!ATTLIST ref_target
  type (ads|arXiv|coi|doi|inis|inspec|iop|isbn|mnr|msn|pubmed|spires|spiresep|zbm|url) #REQUIRED
>
