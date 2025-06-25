Gemeentelijk Gegevensmodel in Apache Drill
Deze repository bevat een opzet voor het modelleren van het Gemeentelijk Gegevensmodel (GGM) binnen Apache Drill. Het doel is om op een flexibele en toegankelijke wijze gemeentelijke data te structureren en analyseren, met behoud van de semantiek van het GGM en zonder afhankelijk te zijn van traditionele databaserollen of dataloads.

Wat is Apache Drill?
Apache Drill is een open source, schema-loze SQL-query engine die directe analyse op uiteenlopende gegevensbronnen mogelijk maakt. Drill ondersteunt onder andere bestanden in JSON-, CSV-, Parquet-formaat, en objectopslag zoals Amazon S3, zonder dat deze data eerst in een relationele database hoeft te worden geïmporteerd.

Technische kenmerken van Apache Drill
Ondersteuning voor semigestructureerde data (zoals nested JSON).
SQL-ondersteuning op bestanden, mappen, databases, en REST-bronnen.
Schema-loos: Drill bepaalt het schema dynamisch tijdens query-uitvoering.
Plug-in architectuur voor uiteenlopende opslagbronnen (bijv. lokale bestanden, HDFS, S3, JDBC-bronnen).
Embedded mode en cluster mode beschikbaar.
Deze eigenschappen maken Drill met name geschikt voor gemeentelijke contexten, waar data verspreid, niet-uniform en niet altijd vooraf gestructureerd is.

Doel en aanpak
Binnen dit project is gekozen om het GGM als uitgangspunt te nemen en per domein mappen te structureren met daarin:

SQL-scripts voor het creëren van views op ruwe data.
Query's voor specifieke datavraagstukken of beleidsanalyses.
Informatie over gebruikte databronnen (open data of intern beschikbaar).
Er is geen dataload of vooraf gedefinieerde datastructuur vereist. Apache Drill biedt de mogelijkheid om direct op bronbestanden te werken, wat de drempel verlaagt voor het ontwikkelen en onderhouden van gemeentelijke dataproducten.

Initiatief van gemeente Sittard-Geleen
De gemeente Sittard-Geleen heeft het initiatief genomen om deze werkwijze te verkennen als proof-of-concept. Door het GGM te structureren in Apache Drill, beogen we een flexibel en transparant datamodel op te zetten dat herbruikbaar is binnen en buiten de organisatie.

Uitnodiging aan andere gemeenten
Wij nodigen andere gemeenten van harte uit om bij te dragen aan dit project. Elk domein binnen het GGM kan als afzonderlijk onderdeel worden ontwikkeld en onderhouden. Door samen te werken ontstaat een breed gedragen en toekomstbestendig geheel, waarin:

Gemeenten gebruik kunnen maken van elkaars werk.
Best practices rondom Drill en datamodellering gedeeld kunnen worden.
Openbare en interne datasets snel en verantwoord geanalyseerd kunnen worden.
Samen werken we aan een publieke, open en datagedreven benadering van het gemeentelijke gegevensmodel.
