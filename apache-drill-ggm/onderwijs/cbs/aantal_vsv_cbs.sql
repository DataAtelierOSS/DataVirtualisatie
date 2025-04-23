-- CBS VSV-telling per jaar voor gemeente GM1883 (Sittard-Geleen)
-- Dataset: 84780NED - Voortijdig schoolverlaters, CBS StatLine

SELECT 
  SUBSTR(Perioden, 1, 4) AS Jaar,
  SUM(CAST(VoortijdigSchoolverlaters_2 AS INT)) AS Aantal_VSV_CBS
FROM cbs.cbs.`84780NED/TypedDataSet`
WHERE Regiokenmerken LIKE 'GM1883%'
GROUP BY SUBSTR(Perioden, 1, 4)
ORDER BY Jaar;
