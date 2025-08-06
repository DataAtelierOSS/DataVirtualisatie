
CREATE VIEW dfs.tmp.vw_cte_applicaties AS
WITH
  filtered_software AS (
    SELECT
      CAST(id AS VARCHAR) AS id,
      CAST(name AS VARCHAR) AS name,
      CAST(objectid AS VARCHAR) AS objectid,
      CAST(REPLACE(SUBSTR(creationDate, 1, 19), 'T', ' ') AS TIMESTAMP) AS parsed_creationDate
    FROM topdesk.topdesk.`AssetSoftwareList`
    WHERE CAST(REPLACE(SUBSTR(creationDate, 1, 19), 'T', ' ') AS TIMESTAMP) >= TIMESTAMP '2025-01-01 00:00:00'
  ),

  filtered_detail AS (
    SELECT
      CAST(id AS VARCHAR) AS id,
      CAST(application AS VARCHAR) AS application
    FROM topdesk.topdesk.`AssetSoftwareDetailList`
  ),

  filtered_server AS (
    SELECT
      CAST(id AS VARCHAR) AS id,
      CAST(objectid AS VARCHAR) AS objectid,
      CAST(REPLACE(SUBSTR(creationDate, 1, 19), 'T', ' ') AS TIMESTAMP) AS parsed_creationDate
    FROM topdesk.topdesk.`AssetServerList`
    WHERE CAST(REPLACE(SUBSTR(creationDate, 1, 19), 'T', ' ') AS TIMESTAMP) >= TIMESTAMP '2025-01-01 00:00:00'
  )

SELECT 
  s.id,
  MIN(
    COALESCE(
      d.application,
      s.name,
      s.objectid
    )
  ) AS applicatie
FROM filtered_software s
LEFT JOIN filtered_detail d
  ON s.id = d.id
GROUP BY s.id

UNION ALL

SELECT
  id,
  objectid AS applicatie
FROM filtered_server;
