Pub2TEI
=======

Set of XSL stylesheets for converting heterogeneous publisher XML formats in to TEI

RL => J'ai noté ici les tâches que j'ai effectuées pour info

Nouvelle feuille pour IOP   => branche nouveau_iop
-------------------------
L'essentiel est dans IOP.xsl :
  - FAIT traitement du header et de ses métadonnées,
  - TODO les sections du body
  - FAIT bibliography

Ajout d'exemples     => déjà mergé
-----------------
J'ajoute 4 dossiers d'exemples avec 10 docs XML de chaque éditeur
    Samples/TestPubInput/IOP/
    Samples/TestPubInput/Nature/
    Samples/TestPubInput/OUP/
    Samples/TestPubInput/RSC/

Ces documents ont été très légèrement prétraités :
  - conversion en UTF-8
  - changement de déclaration encoding en conséquence
  - conversion des entités HTML5 en leur équivalent UTF-8
  - remplacement des entités restantes par un token '___ENT___'
  - modification des appels DTD pour qu'ils pointent relativement sur ../../DTDs/dossierQuiVaBien

Ces prétraitements ont pour but de ne pas laisser les questions d'encodage interférer avec le travail sur la structure. Les originaux sont quand même fournis dans les sous-dossiers 'originaux' de chaque lot.
