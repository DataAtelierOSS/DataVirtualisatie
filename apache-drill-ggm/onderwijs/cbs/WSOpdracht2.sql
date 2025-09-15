SELECT 
  Regiokenmerken,
  Geslacht,
  Perioden,
  Leerlingen_1,
  VoortijdigSchoolverlaters_2,
  VoortijdigSchoolverlatersPercentage_4
FROM cbs.cbs.`84780NED/TypedDataSet`
WHERE RTRIM(Regiokenmerken) = 'GM1883'
ORDER BY Perioden DESC;
