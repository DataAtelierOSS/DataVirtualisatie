SELECT
  behandelaarsgroep,
  COUNT(*) AS aantal_incidenten
FROM cte_basis
GROUP BY behandelaarsgroep
ORDER BY aantal_incidenten DESC;
