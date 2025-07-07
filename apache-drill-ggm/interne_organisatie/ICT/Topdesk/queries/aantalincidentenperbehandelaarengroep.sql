--dfs.tmp.incidenten_basis_v2 voor het model moet je de from hierin veranderen!

SELECT
  behandelaarsgroep,
  behandelaar,
  COUNT(*) AS aantal_incidenten
FROM cte_basis
GROUP BY behandelaarsgroep, behandelaar
ORDER BY behandelaarsgroep, aantal_incidenten DESC;
