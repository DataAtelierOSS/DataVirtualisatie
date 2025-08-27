CREATE OR REPLACE VIEW dfs.tmp.vw_model AS
SELECT
  -- Incident basics
  CAST(B.incidentnumber AS VARCHAR) AS ticketnummer,
  COALESCE(CAST(B.briefDescription AS VARCHAR), 'Geen omschrijving') AS omschrijving,
  aanmelddatum,
  afmeldingsdatum,
  streefdatum,

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
  COALESCE(T.incidenttype_name, 'Onbekend') AS type_melding

FROM dfs.tmp.incidenten A

-- IncidentDetails + IncidentTypes
LEFT JOIN dfs.tmp.vw_cte_incidentdetails B
  ON CAST(A.id AS VARCHAR) = B.incident_id

LEFT JOIN dfs.tmp.vw_cte_incidenttypes T
  ON CAST(A.incidenttype_id AS VARCHAR) = T.incidenttype_id

-- Applicaties
LEFT JOIN dfs.tmp.vw_cte_applicaties Z
  ON CAST(B.assetid AS VARCHAR) = CAST(Z.id AS VARCHAR)

-- Operators + OperatorGroups
LEFT JOIN dfs.tmp.vw_cte_operatoren O
  ON CAST(A.operator_id AS VARCHAR) = CAST(O.operator_id AS VARCHAR)
  AND CAST(A.operatorGroup_id AS VARCHAR) = CAST(O.operatorgroup_id AS VARCHAR)

-- Categories + Subcategories
LEFT JOIN dfs.tmp.vw_cte_categories C
  ON CAST(A.category_id AS VARCHAR) = CAST(C.category_id AS VARCHAR)
  AND CAST(A.subcategory_id AS VARCHAR) = CAST(C.subcategory_id AS VARCHAR)

-- EntryTypes
LEFT JOIN dfs.tmp.vw_entrytypes H
  ON CAST(A.entrytype_id AS VARCHAR) = CAST(H.id AS VARCHAR);
