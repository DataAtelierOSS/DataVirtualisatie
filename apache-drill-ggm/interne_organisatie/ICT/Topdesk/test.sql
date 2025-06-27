WITH cte_applicaties AS (
    SELECT id, objectid 
    FROM topdesk.`AssetSoftwareList`
    UNION ALL
    SELECT id, objectid 
    FROM topdesk.`AssetSoftwareDetailList`
),
cte_incidents AS (
    SELECT
        id,
        CAST(id AS VARCHAR) AS id_str,
        number,
        briefDescription,
        creationDate,
        completionDate,
        targetDate,
        CAST(categoryId AS VARCHAR) AS category_name,
        CAST(subcategoryId AS VARCHAR) AS subcategory_name,
        CAST(operatorGroupId AS VARCHAR) AS operatorGroup_id,
        CAST(operatorId AS VARCHAR) AS operator_id,
        CAST(processingStatusId AS VARCHAR) AS status_id,
        CAST(entryTypeId AS VARCHAR) AS entrytype_id,
        CAST(incidentTypeId AS VARCHAR) AS incidenttype_id
    FROM topdesk.`Incidents`
    WHERE creationDate IS NOT NULL
      AND CAST(SUBSTR(creationDate, 1, 4) AS INT) >= CAST(SUBSTR(CURRENT_DATE, 1, 4) AS INT) - 3
),
cte_details AS (
    SELECT
        id,
        incidentnumber,
        briefdescription,
        assetid
    FROM topdesk.`IncidentDetails`
)

SELECT
    B.incidentnumber                           AS `Ticketnummer`,
    B.briefdescription                         AS `Korte omschrijving`,
    A.creationDate                             AS `Aanmelddatum`,
    A.completionDate                           AS `Afmeldingsdatum`,
    A.targetDate                               AS `Streefdatum`,
    COALESCE(Z.objectid, 'Onbekend/n.v.t.')    AS `Applicatie`,
    COALESCE(A.category_name, 'Onbekende categorie')    AS `Categorie`,
    COALESCE(A.subcategory_name, 'Onbekende subcategorie') AS `Subcategorie`,
    COALESCE(C.name, 'Onbekende behandelaarsgroep')     AS `Behandelaarsgroep`,
    COALESCE(D.name, 'Onbekende behandelaar')           AS `Behandelaar`,
    COALESCE(G.name, 'Onbekend')                        AS `Status`,
    COALESCE(H.name, 'Onbekend')                        AS `Ontvangst via`,
    COALESCE(I.name, 'Onbekend')                        AS `Type melding`,
    CAST(NULL AS VARCHAR)                               AS `Sjabloon`,
    CAST(NULL AS VARCHAR)                               AS `currentphase`,
    CAST(NULL AS VARCHAR)                               AS `changetype`,
    'Melding'                                           AS `Type ticket`,
    1                                                   AS `Aantal`,
    CAST(NULL AS VARCHAR)                               AS `CurrentPhase_`,
    CAST(NULL AS VARCHAR)                               AS `plannedFinalDate`,
    CAST(NULL AS VARCHAR)                               AS `readytostart`,
    CAST(NULL AS VARCHAR)                               AS `Wijziging`,
    CAST(NULL AS VARCHAR)                               AS `Datum aanmaak wijziging`,
    CAST(NULL AS VARCHAR)                               AS `Status wijziging`,
    CAST(NULL AS VARCHAR)                               AS `StatusCode`
FROM cte_incidents A
LEFT JOIN cte_details B              ON A.id_str = B.id
LEFT JOIN cte_applicaties Z          ON B.assetid = Z.id
LEFT JOIN (
    SELECT id, name FROM topdesk.`OperatorGroups`
) C                                   ON A.operatorGroup_id = C.id
LEFT JOIN (
    SELECT id, name FROM topdesk.`Operators`
) D                                   ON A.operator_id = D.id
LEFT JOIN (
    SELECT id, name FROM topdesk.`IPS`
) G                                   ON A.status_id = G.id
LEFT JOIN (
    SELECT id, name FROM topdesk.`EntryTypes`
) H                                   ON A.entrytype_id = H.id
LEFT JOIN (
    SELECT id, name FROM topdesk.`Incident_Types`
) I                                   ON A.incidenttype_id = I.id
LIMIT 100;
