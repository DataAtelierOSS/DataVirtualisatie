CREATE TABLE dfs.tmp.cte_applicaties AS
(SELECT 
  CAST(S.id AS VARCHAR) AS id,
  MIN(
    COALESCE(
      CAST(D.application AS VARCHAR),
      CAST(S.name AS VARCHAR),
      CAST(S.objectid AS VARCHAR)
    )
  ) AS applicatie
FROM topdesk.topdesk.`AssetSoftwareList` S
LEFT JOIN topdesk.topdesk.`AssetSoftwareDetailList` D
  ON CAST(S.id AS VARCHAR) = CAST(D.id AS VARCHAR)
GROUP BY S.id

UNION ALL

SELECT 
  CAST(id AS VARCHAR) AS id,
  CAST(objectid AS VARCHAR) AS applicatie
FROM topdesk.topdesk.`AssetServerList`
)
