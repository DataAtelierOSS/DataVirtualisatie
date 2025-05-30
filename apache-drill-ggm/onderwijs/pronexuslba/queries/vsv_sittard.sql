-- Query: Lokale identificatie van mogelijke voortijdig schoolverlaters (VSV)
-- Doel: Leerlingen vinden die het onderwijs hebben verlaten zonder startkwalificatie
-- Domein: GGM Onderwijs
-- Gemeente: Sittard-Geleen
-- Dataset: Lokale LBA-data (Drill views)
-- Laatste update: 2025-04-23

SELECT 
  li.PERSOON_LBAID,
  li.laatste_inschrijving,
  li.laatst_opleiding_niveau,
  li.uitstroomcode,
  COALESCE(vz.verzuimmomenten, 0) AS verzuim,
  COALESCE(md.meldingen, 0) AS meldingen
FROM laatste_inschrijving li
LEFT JOIN verzuim_signaal vz ON li.PERSOON_LBAID = vz.PERSOON_LBAID
LEFT JOIN melding_signaal md ON li.PERSOON_LBAID = md.PERSOON_LBAID
WHERE li.uitstroomcode IS NOT NULL
  AND CAST(li.laatst_opleiding_niveau AS INT) NOT IN (3, 4)
  AND li.laatste_inschrijving < TIMESTAMPADD(YEAR, -1, CURRENT_DATE);
