CREATE TABLE dfs.tmp.cte_incidenttypes AS
SELECT 
  CAST(d.id AS VARCHAR) AS incident_id,
  d.incidentnumber,
  d.briefDescription,
  CAST(d.assetid AS VARCHAR) AS assetid,
  CAST(t.id AS VARCHAR) AS incidenttype_id,
  t.name AS incidenttype_name
FROM topdesk.topdesk.`IncidentDetails` d
LEFT JOIN topdesk.topdesk.`IncidentTypes` t
  ON CAST(d.typeId AS VARCHAR) = CAST(t.id AS VARCHAR);
