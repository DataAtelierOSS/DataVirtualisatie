CREATE TABLE dfs.tmp.incidenten_basis AS

WITH cte_applicaties AS (
  SELECT 
    CAST(S.id AS VARCHAR) AS id,
    COALESCE(
      CAST(D.application AS VARCHAR),
      CAST(S.name AS VARCHAR),
      CAST(S.objectid AS VARCHAR)
    ) AS applicatie,
    CAST(S.supplier_mgrtd AS VARCHAR) AS supplier_mgrtd
  FROM topdesk.topdesk.`AssetSoftwareList` S
  LEFT JOIN topdesk.topdesk.`AssetSoftwareDetailList` D
    ON CAST(S.id AS VARCHAR) = CAST(D.id AS VARCHAR)

  UNION ALL

  SELECT 
    CAST(id AS VARCHAR) AS id,
    CAST(objectid AS VARCHAR) AS applicatie,
    CAST(supplier_mgrtd AS VARCHAR) AS supplier_mgrtd
  FROM topdesk.topdesk.`AssetServerList`
),
cte_suppliers AS (
  SELECT
    CAST(S.id AS VARCHAR) AS supplier_id,
    CAST(SC.operatorId AS VARCHAR) AS operator_id,
    S.name AS supplier_name
  FROM topdesk.topdesk.`Suppliers` S
  JOIN topdesk.topdesk.`SupplierContracts` SC
    ON CAST(S.id AS VARCHAR) = CAST(SC.supplierId AS VARCHAR)
),
cte_incidents AS (
  SELECT
    CAST(id AS VARCHAR) AS id,
    creationDate,
    completionDate,
    targetDate,
    CAST(categoryId AS VARCHAR) AS category_id,
    CAST(subcategoryId AS VARCHAR) AS subcategory_id,
    CAST(operatorGroupId AS VARCHAR) AS operatorGroup_id,
    CAST(operatorId AS VARCHAR) AS operator_id,
    CAST(processingStatusId AS VARCHAR) AS status_id,
    CAST(entryTypeId AS VARCHAR) AS entrytype_id,
    CAST(typeId AS VARCHAR) AS incidenttype_id,
    CAST(configurationItemId AS VARCHAR) AS config_item_id 
  FROM topdesk.topdesk.`Incidents`
  WHERE creationDate IS NOT NULL
    AND SUBSTR(creationDate, 1, 4) BETWEEN '2000' AND '2100'
    AND CAST(SUBSTR(creationDate, 1, 4) AS INT) >= CAST(SUBSTR(CURRENT_DATE, 1, 4) AS INT) - 3
),
cte_basis AS (
  SELECT
    CAST(B.incidentnumber AS VARCHAR) AS ticketnummer,
    COALESCE(CAST(B.briefDescription AS VARCHAR), 'Geen omschrijving') AS omschrijving,
    A.creationDate AS aanmelddatum,
    A.completionDate AS afmeldingsdatum,
    A.targetDate AS streefdatum,
    COALESCE(Z.applicatie, 'Onbekend/n.v.t.') AS applicatie,
    COALESCE(CAST(C.name AS VARCHAR), 'Onbekende behandelaarsgroep') AS behandelaarsgroep,
    COALESCE(CAST(D.name AS VARCHAR), 'Onbekende behandelaar') AS behandelaar,
    COALESCE(CAST(F.name AS VARCHAR), 'Onbekende categorie') AS categorie,
    COALESCE(CAST(E.name AS VARCHAR), 'Onbekende subcategorie') AS subcategorie,
    COALESCE(CAST(G.name AS VARCHAR), 'Onbekend') AS status,
    COALESCE(CAST(H.name AS VARCHAR), 'Onbekend') AS ontvangst_via,
    COALESCE(CAST(I.name AS VARCHAR), 'Onbekend') AS type_melding,
    COALESCE(CAST(S.supplier_name AS VARCHAR), 'Onbekende leverancier') AS leverancier
  FROM cte_incidents A
  LEFT JOIN topdesk.topdesk.`IncidentDetails` B 
    ON A.id = CAST(B.id AS VARCHAR)
  LEFT JOIN cte_applicaties Z 
    ON CAST(B.assetid AS VARCHAR) = Z.id 
  LEFT JOIN topdesk.topdesk.`OperatorGroups` C 
    ON A.operatorGroup_id = CAST(C.id AS VARCHAR)
  LEFT JOIN topdesk.topdesk.`Operators` D 
    ON A.operator_id = CAST(D.id AS VARCHAR)
  LEFT JOIN topdesk.topdesk.`Categories` F 
    ON A.category_id = CAST(F.id AS VARCHAR)
  LEFT JOIN topdesk.topdesk.`Subcategories` E 
    ON A.subcategory_id = CAST(E.id AS VARCHAR)
  LEFT JOIN topdesk.topdesk.`IncidentProcessingStatuses` G 
    ON A.status_id = CAST(G.id AS VARCHAR)
  LEFT JOIN topdesk.topdesk.`EntryTypes` H 
    ON A.entrytype_id = CAST(H.id AS VARCHAR)
  LEFT JOIN topdesk.topdesk.`IncidentTypes` I 
    ON A.incidenttype_id = CAST(I.id AS VARCHAR)
  LEFT JOIN cte_suppliers S 
    ON A.operator_id = S.operator_id
)

SELECT *
FROM cte_basis;
