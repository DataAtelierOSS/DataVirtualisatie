CREATE TABLE dfs.tmp.cte_suppliers AS
SELECT 
  CAST(s.id AS VARCHAR) AS supplier_id,
  s.name AS supplier_name,
  CAST(sc.operatorId AS VARCHAR) AS operator_id
FROM dfs.tmp.suppliers s
JOIN dfs.tmp.suppliercontracts sc
  ON CAST(s.id AS VARCHAR) = CAST(sc.supplierId AS VARCHAR);
