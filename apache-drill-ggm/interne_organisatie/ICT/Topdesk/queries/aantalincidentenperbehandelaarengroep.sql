--dfs.tmp.incidenten_basis_v2 voor het model moet je de from hierin veranderen!

SELECT 
    behandelaarsgroep,
    behandelaar,
    COUNT(*) AS aantal_incidenten
FROM dfs.tmp.incidenten_basis_v2
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
