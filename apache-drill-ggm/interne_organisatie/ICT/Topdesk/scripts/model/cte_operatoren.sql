
CREATE TABLE dfs.tmp.cte_operatoren AS
SELECT DISTINCT
  CAST(A.`operatorid` AS VARCHAR) AS operator_id,
  F.name AS operator_name,
  CAST(A.`operatorGroupid` AS VARCHAR) AS operatorgroup_id,
  E.name AS operatorgroup_name
FROM topdesk.topdesk.Incidents A
LEFT JOIN topdesk.topdesk.OperatorGroups E
  ON CAST(A.`operatorGroupid` AS VARCHAR) = CAST(E.id AS VARCHAR)
LEFT JOIN topdesk.topdesk.Operators F
  ON CAST(A.`operatorid` AS VARCHAR) = CAST(F.id AS VARCHAR)
WHERE A.`operatorid` IS NOT NULL
   OR A.`operatorGroupid` IS NOT NULL;
