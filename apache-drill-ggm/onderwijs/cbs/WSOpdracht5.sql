CREATE OR REPLACE VIEW dfs.tmp.`vsv_gemeente_vs_nl` AS
SELECT 
  g.Perioden,
  g.VoortijdigSchoolverlatersPercentage_4 AS GemeentePerc,
  n.VoortijdigSchoolverlatersPercentage_4 AS LandelijkPerc,
  g.VoortijdigSchoolverlatersPercentage_4 - n.VoortijdigSchoolverlatersPercentage_4 AS Verschil
FROM cbs.cbs.`84780NED/TypedDataSet` g
JOIN cbs.cbs.`84780NED/TypedDataSet` n 
  ON g.Perioden = n.Perioden
WHERE RTRIM(g.Regiokenmerken) = 'GM1883'   -- vervang door jouw gemeente
  AND RTRIM(g.Geslacht) = 'T001038'
  AND RTRIM(n.Regiokenmerken) = 'NL01'
  AND RTRIM(n.Geslacht) = 'T001038'
ORDER BY g.Perioden;
