
SELECT 
  leerling_id
FROM schoolloopbaan_basis
GROUP BY leerling_id
HAVING COUNT(melding_datum) = 0;
