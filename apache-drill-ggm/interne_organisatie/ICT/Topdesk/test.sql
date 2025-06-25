WITH
cte_incidents AS (
  SELECT
    A.number AS Ticketnummer,
    A.briefDescription AS Korte_omschrijving,
    A.creationDate AS Aanmelddatum,
    A.completionDate AS Afmeldingsdatum,
    A.targetDate AS Streefdatum,
    A.id AS incident_id,
    CAST(A.category.id AS VARCHAR) AS category_id,
    CAST(A.subcategory.id AS VARCHAR) AS subcategory_id,
    CAST(A.operatorGroup.id AS VARCHAR) AS operator_group_id,
    CAST(A.operator.id AS VARCHAR) AS operator_id,
    CAST(A.processingStatus.name AS VARCHAR) AS status,
    CAST(A.entryType.name AS VARCHAR) AS ontvangst_via,
    CAST(A.incidentType.name AS VARCHAR) AS type_melding,
    CAST(A.branchId AS VARCHAR) AS vestiging_id,
    CAST(A.assetId AS VARCHAR) AS asset_id,
    'Melding' AS Type_ticket,
    1 AS Aantal
  FROM topdesk.Incidents A
  WHERE A.creationDate IS NOT NULL
    AND SUBSTR(A.creationDate, 1, 4) BETWEEN '2000' AND '2100'
    AND CAST(SUBSTR(A.creationDate, 1, 4) AS INT) >= CAST(SUBSTR(CURRENT_DATE, 1, 4) AS INT) - 3
),

cte_servers AS (
  SELECT
    CAST(s.id AS VARCHAR) AS server_id,
    s.objectId AS server_naam,
    CAST(s.supplier_mgrtd AS VARCHAR) AS leverancier_id
  FROM topdesk.AssetServerList s
),

cte_leveranciers AS (
  SELECT
    CAST(sup.id AS VARCHAR) AS leverancier_id,
    sup.name AS leverancier_naam
  FROM topdesk.Suppliers sup
),

cte_persons AS (
  SELECT
    CAST(p.id AS VARCHAR) AS medewerker_id,
    CAST(p.branchId AS VARCHAR) AS vestiging_id
  FROM topdesk.Persons p
),

cte_categorie AS (
  SELECT
    CAST(id AS VARCHAR) AS id,
    name AS categorie_naam
  FROM topdesk.Categories
),

cte_subcategorie AS (
  SELECT
    CAST(id AS VARCHAR) AS id,
    name AS subcategorie_naam
  FROM topdesk.Subcategories
),

cte_operator_groups AS (
  SELECT
    CAST(id AS VARCHAR) AS id,
    name AS behandelaarsgroep
  FROM topdesk.OperatorGroups
),

cte_operators AS (
  SELECT
    CAST(id AS VARCHAR) AS id,
    name AS behandelaar
  FROM topdesk.Operators
)

SELECT
  i.Ticketnummer,
  i.Korte_omschrijving,
  i.Aanmelddatum,
  i.Afmeldingsdatum,
  i.Streefdatum,
  COALESCE(s.server_naam, 'Onbekend/n.v.t.') AS Applicatie,
  COALESCE(c.categorie_naam, 'Onbekende categorie') AS Categorie,
  COALESCE(sc.subcategorie_naam, 'Onbekende subcategorie') AS Subcategorie,
  COALESCE(g.behandelaarsgroep, 'Onbekende behandelaarsgroep') AS Behandelaarsgroep,
  COALESCE(o.behandelaar, 'Onbekende behandelaar') AS Behandelaar,
  COALESCE(i.status, 'Onbekend') AS Status,
  COALESCE(i.ontvangst_via, 'Onbekend') AS Ontvangst_via,
  COALESCE(i.type_melding, 'Onbekend') AS Type_melding,
  COALESCE(l.leverancier_naam, 'Onbekende leverancier') AS Leverancier,
  i.Type_ticket,
  i.Aantal
FROM cte_incidents i
LEFT JOIN cte_servers s ON s.server_id = i.asset_id
LEFT JOIN cte_leveranciers l ON l.leverancier_id = s.leverancier_id
LEFT JOIN cte_categorie c ON c.id = i.category_id
LEFT JOIN cte_subcategorie sc ON sc.id = i.subcategory_id
LEFT JOIN cte_operator_groups g ON g.id = i.operator_group_id
LEFT JOIN cte_operators o ON o.id = i.operator_id
LIMIT 100;
