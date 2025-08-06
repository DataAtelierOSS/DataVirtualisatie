CREATE VIEW dfs.tmp.vw_cte_incidentdetails AS
SELECT 
  CAST(d.id AS VARCHAR) AS incident_id,
  d.incidentnumber,
  d.briefDescription,
  CAST(d.assetid AS VARCHAR) AS assetid
FROM topdesk.topdesk.`IncidentDetails` d;
