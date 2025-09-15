SELECT 
  Perioden,
  VoortijdigSchoolverlatersPercentage_4 AS perc_vsv
FROM cbs.cbs.`84780NED/TypedDataSet`
WHERE RTRIM(Regiokenmerken) = 'GM1883'
  AND RTRIM(Geslacht) = 'T001038'
ORDER BY Perioden
