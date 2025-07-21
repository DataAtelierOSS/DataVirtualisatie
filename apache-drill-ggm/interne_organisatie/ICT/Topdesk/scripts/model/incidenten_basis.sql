CREATE TABLE dfs.tmp.incidenten_basis_v2 AS
SELECT
  -- Incident basics
  CAST(B.incidentnumber AS VARCHAR) AS ticketnummer,
  COALESCE(CAST(B.briefDescription AS VARCHAR), 'Geen omschrijving') AS omschrijving,
  A.creationDate AS aanmelddatum,
  A.completionDate AS afmeldingsdatum,
  A.targetDate AS streefdatum,

  -- Applicatie info
  COALESCE(Z.applicatie, 'Onbekend/n.v.t.') AS applicatie,

  -- Behandelaarsgroep & behandelaar
  COALESCE(O.operatorgroup_name, 'Onbekende behandelaarsgroep') AS behandelaarsgroep,
  COALESCE(O.operator_name, 'Onbekende behandelaar') AS behandelaar,

  -- Categorie & subcategorie
  COALESCE(C.category_name, 'Onbekende categorie') AS categorie,
  COALESCE(C.subcategory_name, 'Onbekende subcategorie') AS subcategorie,

  -- Ontvangst & type melding
  COALESCE(H.name, 'Onbekend') AS ontvangst_via,
  COALESCE(B.incidenttype_name, 'Onbekend') AS type_melding,

  -- Leverancier
  COALESCE(S.supplier_name, 'Onbekende leverancier') AS leverancier

FROM dfs.tmp.incidents_staging A

-- IncidentDetails + IncidentTypes
LEFT JOIN dfs.tmp.cte_incidenttypes B 
  ON CAST(A.id AS VARCHAR) = B.incident_id

-- Applicaties
LEFT JOIN dfs.tmp.cte_applicaties Z 
  ON CAST(B.assetid AS VARCHAR) = Z.id 

-- Operators + OperatorGroups
LEFT JOIN dfs.tmp.cte_operatoren O 
  ON CAST(A.operatorid AS VARCHAR) = O.operatorid

-- Categories + Subcategories
LEFT JOIN dfs.tmp.cte_categories C 
  ON CAST(A.category_id AS VARCHAR) = C.category_id
 AND CAST(A.subcategory_id AS VARCHAR) = C.subcategory_id

-- EntryTypes
LEFT JOIN dfs.tmp.entrytypes H 
  ON CAST(A.entrytype_id AS VARCHAR) = CAST(H.id AS VARCHAR)

-- Suppliers + SupplierContracts
LEFT JOIN dfs.tmp.cte_suppliers S 
  ON CAST(A.operator_id AS VARCHAR) = S.operator_id;
