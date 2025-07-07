CREATE TABLE dfs.tmp.cte_applicaties AS
SELECT 
  CAST(asl.id AS VARCHAR) AS id,
  COALESCE(
    CAST(asd.application AS VARCHAR),
    CAST(asl.name AS VARCHAR),
    CAST(asl.objectid AS VARCHAR)
  ) AS applicatie
FROM dfs.tmp.assetsoftwarelist asl
LEFT JOIN dfs.tmp.assetsoftwaredetaillist asd
  ON CAST(asl.id AS VARCHAR) = CAST(asd.id AS VARCHAR)

UNION ALL

SELECT 
  CAST(id AS VARCHAR) AS id,
  CAST(objectid AS VARCHAR) AS applicatie
FROM dfs.tmp.assetserverlist;
