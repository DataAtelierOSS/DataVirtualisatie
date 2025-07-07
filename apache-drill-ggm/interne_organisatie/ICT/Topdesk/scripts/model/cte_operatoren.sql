CREATE TABLE dfs.tmp.cte_operatoren AS
SELECT 
  CAST(op.id AS VARCHAR) AS operator_id,
  op.name AS operator_name,
  CAST(og.id AS VARCHAR) AS operatorgroup_id,
  og.name AS operatorgroup_name
FROM dfs.tmp.operators op
LEFT JOIN dfs.tmp.operatorgroups og
  ON CAST(op.operatorGroupId AS VARCHAR) = CAST(og.id AS VARCHAR);
