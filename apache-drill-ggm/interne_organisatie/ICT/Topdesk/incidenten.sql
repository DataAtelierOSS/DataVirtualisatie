WITH incidentgegevens AS (
    SELECT
        B.incidentnumber AS `Ticketnummer`,
        B.briefdescription AS `Korte omschrijving`,
        A.creationdate AS `Aanmelddatum`,
        A.completiondate AS `Afmeldingsdatum`,
        A.Targetdate AS `Streefdatum`,
        CASE
            WHEN Z.objectid IS NULL THEN 'Onbekend/n.v.t.'
            ELSE Z.objectid
        END AS `Applicatie`,
        CASE
            WHEN F.name IS NULL THEN 'Onbekende categorie'
            ELSE F.name
        END AS `Categorie`,
        CASE
            WHEN E.name IS NULL THEN 'Onbekende subcategorie'
            ELSE E.name
        END AS `Subcategorie`,
        CASE
            WHEN C.name IS NULL THEN 'Onbekende behandelaarsgroep'
            ELSE C.name
        END AS `Behandelaarsgroep`,
        CASE
            WHEN D.name IS NULL THEN 'Onbekende behandelaar'
            ELSE D.name
        END AS `Behandelaar`,
        G.name AS `Status`,
        CASE
            WHEN H.name IS NULL THEN 'Onbekend'
            ELSE H.name
        END AS `Ontvangst via`,
        CASE
            WHEN I.name IS NULL THEN 'Onbekend'
            ELSE I.name
        END AS `Type melding`,
        NULL AS `Sjabloon`,
        NULL AS `currentphase`,
        NULL AS `changetype`,
        'Melding' AS `Type ticket`,
        1 AS `Aantal`,
        NULL AS `CurrentPhase_`,
        NULL AS `plannedFinalDate`,
        NULL AS `readytostart`,
        NULL AS `Wijziging`,
        NULL AS `Datum aanmaak wijziging`,
        NULL AS `Status wijziging`,
        NULL AS `StatusCode`
    FROM
        topdesk.`Incidents` A
    LEFT JOIN topdesk.`IncidentDetails` B   ON A.ID = B.ID
    LEFT JOIN topdesk.`cte_applicaties` Z   ON B.assetid = Z.id
    LEFT JOIN topdesk.`OperatorGroups` C    ON A.operatorGroupId = C.id
    LEFT JOIN topdesk.`Operators` D         ON A.operatorId = D.id
    LEFT JOIN topdesk.`Subcategories` E     ON A.subcategoryId = E.id
    LEFT JOIN topdesk.`Categories` F        ON A.categoryId = F.id
    LEFT JOIN topdesk.`IPS` G               ON A.processingStatusId = G.id
    LEFT JOIN topdesk.`EntryTypes` H        ON A.entrytypeid = H.id
    LEFT JOIN topdesk.`Incident_Types` I    ON A.typeid = I.id
    WHERE
        CAST(A.creationdate AS DATE) >= DATE_SUB(CURRENT_DATE, INTERVAL 3 YEAR)
)

SELECT *
FROM incidentgegevens
LIMIT 50;
