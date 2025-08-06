SELECT 
    behandelaarsgroep,
    behandelaar,
    COUNT(*) AS aantal_incidenten
FROM dfs.tmp.vw_model
WHERE CAST(
        REPLACE(
            REPLACE(SUBSTR(aanmelddatum, 1, 19), 'T', ' ')
        , 'Z', ''
        ) AS TIMESTAMP
    ) >= TIMESTAMP '2025-03-01 00:00:00'
  AND CAST(
        REPLACE(
            REPLACE(SUBSTR(aanmelddatum, 1, 19), 'T', ' ')
        , 'Z', ''
        ) AS TIMESTAMP
    ) < TIMESTAMP '2025-04-01 00:00:00'
GROUP BY behandelaarsgroep, behandelaar
ORDER BY aantal_incidenten DESC;
