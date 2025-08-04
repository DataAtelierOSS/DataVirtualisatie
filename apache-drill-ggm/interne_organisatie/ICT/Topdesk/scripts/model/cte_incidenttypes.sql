CREATE TABLE dfs.tmp.cte_incidenttypes AS
SELECT 
  CAST(t.id AS VARCHAR) AS incidenttype_id,
  t.name AS incidenttype_name
FROM topdesk.topdesk.`IncidentTypes` t;
