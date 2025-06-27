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
        number,
        briefDescription,
        creationDate,
        completionDate,
        targetDate,
        CAST(categoryId AS VARCHAR) AS category_id,
        CAST(subcategoryId AS VARCHAR) AS subcategory_id,
        CAST(operatorGroupId AS VARCHAR) AS operatorGroup_id,
        CAST(operatorId AS VARCHAR) AS operator_id,
        CAST(processingStatusId AS VARCHAR) AS status_id,
        CAST(entryTypeId AS VARCHAR) AS entrytype_id,
        CAST(incidentTypeId AS VARCHAR) AS incidenttype_id
    FROM topdesk.`Incidents`
    WHERE creationDate IS NOT NULL
      AND CAST(SUBSTR(creationDate, 1, 4) AS INT) >= CAST(SUBSTR(CURRENT_DATE, 1, 4) AS INT) - 3
),
cte_basis AS (
    SELECT
        A.number                                   AS ticketnummer,
        A.briefDescription                         AS omschrijving,
        A.creationDate                             AS aanmelddatum,
        A.completionDate                           AS afmeldingsdatum,
        A.targetDate                               AS streefdatum,
        COALESCE(Z.objectid, 'Onbekend/n.v.t.')    AS applicatie,
        COALESCE(C.name, 'Onbekende behandelaarsgroep') AS behandelaarsgroep,
        COALESCE(D.name, 'Onbekende behandelaar')       AS behandelaar,
        COALESCE(F.name, 'Onbekende categorie')         AS categorie,
        COALESCE(E.name, 'Onbekende subcategorie')      AS subcategorie,
        COALESCE(G.name, 'Onbekend')                    AS status,
        COALESCE(H.name, 'Onbekend')                    AS ontvangst_via,
        COALESCE(I.name, 'Onbekend')                    AS type_melding
    FROM cte_incidents A
    LEFT JOIN topdesk.`IncidentDetails` B ON A.number = B.incidentnumber
    LEFT JOIN cte_applicaties Z            ON B.assetid = Z.id
    LEFT JOIN topdesk.`OperatorGroups` C   ON A.operatorGroup_id = C.id
    LEFT JOIN topdesk.`Operators` D        ON A.operator_id = D.id
    LEFT JOIN topdesk.`Categories` F       ON A.category_id = F.id
    LEFT JOIN topdesk.`Subcategories` E    ON A.subcategory_id = E.id
    LEFT JOIN topdesk.`IPS` G              ON A.status_id = G.id
    LEFT JOIN topdesk.`EntryTypes` H       ON A.entrytype_id = H.id
    LEFT JOIN topdesk.`Incident_Types` I   ON A.incidenttype_id = I.id
)
