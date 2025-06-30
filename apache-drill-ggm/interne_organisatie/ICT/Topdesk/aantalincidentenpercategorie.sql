SELECT
  COALESCE(F.name, 'Onbekende categorie') AS categorie,  
  COUNT(*) AS aantal_incidenten                      
FROM topdesk.`Incidents` A
LEFT JOIN topdesk.`Categories` F 
    ON CAST(A.categoryId AS VARCHAR) = F.id         
WHERE A.creationDate IS NOT NULL                     
  AND CAST(SUBSTR(A.creationDate, 1, 4) AS INT) >= 
      CAST(SUBSTR(CURRENT_DATE, 1, 4) AS INT) - 3     
GROUP BY COALESCE(F.name, 'Onbekende categorie')
ORDER BY aantal_incidenten DESC;
