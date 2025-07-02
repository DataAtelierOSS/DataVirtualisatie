SELECT
  categorie,
  COUNT(*) AS aantal_incidenten
FROM cte_basis
GROUP BY categorie
ORDER BY aantal_incidenten DESC;
