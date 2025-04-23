-- Analyse: Voortijdig schoolverlaters in Sittard-Geleen per schooljaar
-- Bron: CBS OData API (84780NED)
-- GGM-domein: Onderwijs
-- Gemeente: GM1883 (Sittard-Geleen)

SELECT 
  SUBSTR(Perioden, 1, 4) AS Jaar,
  SUM(CAST(VoortijdigSchoolverlaters_2 AS INT)) AS Totaal_VSV,
  SUM(CAST(Leerlingen_1 AS INT)) AS Aantal_Leerlingen,
  ROUND(AVG(CAST(VoortijdigSchoolverlatersPercentage_4 AS FLOAT)), 1) AS Gemiddeld_Percentage
FROM cbs.cbs.`84780NED/TypedDataSet`
WHERE Regiokenmerken LIKE 'GM1883%'
GROUP BY SUBSTR(Perioden, 1, 4)
ORDER BY Jaar;
