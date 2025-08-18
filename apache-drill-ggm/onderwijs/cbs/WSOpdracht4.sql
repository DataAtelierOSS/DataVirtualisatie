WITH gemeente AS (
  SELECT Perioden, VoortijdigSchoolverlatersPercentage_4 AS gemeente_perc
  FROM cbs.cbs.`84780NED/TypedDataSet`
  WHERE RTRIM(Regiokenmerken) = 'GM1883'
    AND RTRIM(Geslacht) = 'T001038'
),
landelijk AS (
  SELECT Perioden, VoortijdigSchoolverlatersPercentage_4 AS landelijk_perc
  FROM cbs.cbs.`84780NED/TypedDataSet`
  WHERE RTRIM(Regiokenmerken) = 'NL01'
    AND RTRIM(Geslacht) = 'T001038'
)
SELECT 
  g.Perioden,
  g.gemeente_perc,
  l.landelijk_perc,
  g.gemeente_perc - l.landelijk_perc AS verschil
FROM gemeente g
JOIN landelijk l ON g.Perioden = l.Perioden
ORDER BY g.Perioden;
