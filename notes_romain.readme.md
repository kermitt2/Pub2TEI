Pub2TEI
=======

Set of XSL stylesheets for converting heterogeneous publisher XML formats in to TEI

=> Je note ici chronologiquement les tâches que j'ai effectuées pour info

Création du dépôt sur rloth/Pub2TEI
-------------------------------------
Ce dépôt est un fork de celui de Patrice, que j'ajoute en remote upstream.

    > git remote -v
    origin	https://github.com/rloth/Pub2TEI.git (fetch)
    origin	https://github.com/rloth/Pub2TEI.git (push)
    upstream	https://github.com/kermitt2/Pub2TEI.git (fetch)
    upstream	https://github.com/kermitt2/Pub2TEI.git (push)


Ajout d'exemples
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

Ces prétraitements ont pour but de ne pas laisser les questions d'encodage interférer avec le travail sur la structure. Les originaux sont quand même fournis dans les sous-dossiers 'originaux' de chaque lot.
