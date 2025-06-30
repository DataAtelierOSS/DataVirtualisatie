WITH cte_applicaties AS (
  SELECT 
    CAST(id AS VARCHAR) AS id,
    CAST(objectid AS VARCHAR) AS objectid
  FROM topdesk.`AssetSoftwareList`

  UNION ALL

  SELECT 
    CAST(id AS VARCHAR) AS id,
    CAST(objectid AS VARCHAR) AS objectid
  FROM topdesk.`AssetServerList`
),

cte_suppliers AS (
  SELECT
    CAST(S.id AS VARCHAR) AS supplier_id,
    CAST(SC.operatorId AS VARCHAR) AS operator_id,
    S.name AS supplier_name
  FROM topdesk.`Suppliers` S
  JOIN topdesk.`SupplierContracts` SC
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
    CAST(typeId AS VARCHAR) AS incidenttype_id  -- ✅ Correct FK for type_melding
  FROM topdesk.`Incidents`
  WHERE creationDate IS NOT NULL
    AND CAST(SUBSTR(creationDate, 1, 4) AS INT) >= CAST(SUBSTR(CURRENT_DATE, 1, 4) AS INT) - 3
),

cte_basis AS (
  SELECT
    CAST(B.incidentnumber AS VARCHAR)                               AS ticketnummer,
    COALESCE(CAST(B.briefDescription AS VARCHAR), 'Geen omschrijving') AS omschrijving,
    A.creationDate                                                  AS aanmelddatum,
    A.completionDate                                                AS afmeldingsdatum,
    A.targetDate                                                    AS streefdatum,
    COALESCE(CAST(Z.objectid AS VARCHAR), 'Onbekend/n.v.t.')        AS applicatie,
    COALESCE(CAST(C.name AS VARCHAR), 'Onbekende behandelaarsgroep') AS behandelaarsgroep,
    COALESCE(CAST(D.name AS VARCHAR), 'Onbekende behandelaar')      AS behandelaar,
    COALESCE(CAST(F.name AS VARCHAR), 'Onbekende categorie')        AS categorie,
    COALESCE(CAST(E.name AS VARCHAR), 'Onbekende subcategorie')     AS subcategorie,
    COALESCE(CAST(G.name AS VARCHAR), 'Onbekend')                   AS status,
    COALESCE(CAST(H.name AS VARCHAR), 'Onbekend')                   AS ontvangst_via,
    COALESCE(CAST(I.name AS VARCHAR), 'Onbekend')                   AS type_melding,
    COALESCE(CAST(S.supplier_name AS VARCHAR), 'Onbekende leverancier') AS leverancier
  FROM cte_incidents A
  LEFT JOIN topdesk.`IncidentDetails` B 
    ON A.id = CAST(B.id AS VARCHAR)
  LEFT JOIN cte_applicaties Z 
    ON CAST(B.id AS VARCHAR) = Z.id
  LEFT JOIN topdesk.`OperatorGroups` C 
    ON A.operatorGroup_id = CAST(C.id AS VARCHAR)
  LEFT JOIN topdesk.`Operators` D 
    ON A.operator_id = CAST(D.id AS VARCHAR)
  LEFT JOIN topdesk.`Categories` F 
    ON A.category_id = CAST(F.id AS VARCHAR)
  LEFT JOIN topdesk.`Subcategories` E 
    ON A.subcategory_id = CAST(E.id AS VARCHAR)
  LEFT JOIN topdesk.`IncidentProcessingStatuses` G 
    ON A.status_id = CAST(G.id AS VARCHAR)
  LEFT JOIN topdesk.`EntryTypes` H 
    ON A.entrytype_id = CAST(H.id AS VARCHAR)
  LEFT JOIN topdesk.`IncidentTypes` I 
    ON A.incidenttype_id = CAST(I.id AS VARCHAR)
  LEFT JOIN cte_suppliers S 
    ON A.operator_id = S.operator_id
)

SELECT *
FROM cte_basis;
