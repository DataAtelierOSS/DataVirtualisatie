SELECT behandelaar, COUNT(*)
FROM dfs.tmp.incidenten_basis
GROUP BY behandelaar;
