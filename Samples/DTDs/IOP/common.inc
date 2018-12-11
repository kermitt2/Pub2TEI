<!-- ###########################################################################
#
#   File name: common.inc
#   Project: Journals
#   Description: Definitions of common items for inclusion in Journals DTDs
#
#
#   External documents:
#
#
#   Author: Peter Haworth
#   Date created: 29/09/1999
#
#   $Id$
#
#   Copyright IOP Publishing Ltd 1999-2011
#
############################################################################ -->


<!-- Define the set of possible languages -->
<!ENTITY % languages "(en|fr|de|es|ru)">
<!-- These are ISO 639 codes:
  de: German
  en: English
  es: Spanish
  fr: French
  ru: Russian
-->

<!-- Full text filenames -->
<!ENTITY % fulltext_atts "
  pdf CDATA #IMPLIED
  pdf_high_resolution CDATA #IMPLIED
  ps CDATA #IMPLIED
  html CDATA #IMPLIED
  mhtml CDATA #IMPLIED
  html_body CDATA #IMPLIED

  epdf CDATA #IMPLIED
  figures CDATA #IMPLIED
  tables CDATA #IMPLIED
  figs CDATA #IMPLIED
">
<!--
  epdf: Extended PDF
  figures: HTML figures page, using images from fulltext HTML
  tables: HTML tables page, using images from fulltext HTML
  figs: Holdover from PEL. We can't remove this, because of existing data
-->

<!-- Article types -->
<!ENTITY % type_atts "
  art_type (comm|paper|prod|error|edit|lett|misc|note|rev|news|conf)
    #REQUIRED
  text_type (abs|summary|full|header|none) #REQUIRED
  status (accepted|published) &#34;published&#34;
">
<!-- The art_type attribute has the following meaning, EJ2 dtypes in parens:
  comm:  (C) Commentary. This is reserved for NJP, but there aren't any yet
  paper: (a) Normal paper
  prod:  (b) Product review. This different to "review"!
  error: (c) Corrigendum/Erratum/Addendum. Should really be "correction"
  edit:  (e) Editorial
  lett:  (l) Letter/Rapid communication/Preliminary communication
  misc:  (m) Miscellaneous. No point having a spec if we can't break out!
  note:  (n) Note/Technical note
  rev:   (r) Review/Topical review. This is not for product reviews!
  news:      News item
  conf:      Conference listing
-->

<!-- Reference link counts -->
<!ENTITY % link_atts "
  refs NMTOKEN #IMPLIED
  cites NMTOKEN #IMPLIED
  err_cites NMTOKEN #IMPLIED
"> <!--
  refs: number of non-correction references
  cites: number of non-correction citations
  err_cites: number of correction citations
-->

<!-- Special material attributes -->
<!ENTITY % special_atts "
  filename NMTOKEN #IMPLIED
  icon NMTOKEN #IMPLIED
">


<!-- Modification history -->
<!ELEMENT date_modified (#PCDATA)>      <!-- Last modification date -->
<!ATTLIST date_modified
  checkedby CDATA #IMPLIED
>
<!ELEMENT date_modified_history (#PCDATA)> <!-- One element for every change -->
<!ATTLIST date_modified_history
  date CDATA #REQUIRED
  user CDATA #REQUIRED
>


<!-- Names -->
<!ELEMENT given %html_line;>
<!ATTLIST given non_latin CDATA #IMPLIED>
<!ELEMENT surname %html_line;>
<!ATTLIST surname non_latin CDATA #IMPLIED>
<!ELEMENT name_suffix %html_line;>
<!ATTLIST name_suffix non_latin CDATA #IMPLIED>

<!ENTITY % name-content "(group?,given?,surname?,name_suffix?)">
<!ENTITY % name-attrs "
  ecsid CDATA #IMPLIED
  orcid NMTOKEN #IMPLIED
  affil CDATA #IMPLIED
  order (given-surname|surname-given|group) #REQUIRED
  include_space (yes|no) &#x22;yes&#x22;
  order_non_latin (given-surname|surname-given|group) #IMPLIED
  include_space_non_latin (yes|no) #IMPLIED
  post CDATA #IMPLIED
">




