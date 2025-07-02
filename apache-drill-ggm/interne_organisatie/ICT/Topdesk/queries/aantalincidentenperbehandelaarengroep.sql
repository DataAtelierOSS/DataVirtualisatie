SELECT
  behandelaarsgroep,
  behandelaar,
  COUNT(*) AS aantal_incidenten
FROM cte_basis
GROUP BY behandelaarsgroep, behandelaar
ORDER BY behandelaarsgroep, aantal_incidenten DESC;
