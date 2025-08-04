CREATE TABLE dfs.tmp.cte_suppliers AS
SELECT 
    supplier_id,
    supplier_name,
    operator_id
FROM (
    SELECT 
        CAST(s.id AS VARCHAR) AS supplier_id,
        s.name AS supplier_name,
        CAST(sc.operatorId AS VARCHAR) AS operator_id,
        ROW_NUMBER() OVER (
            PARTITION BY s.id, sc.operatorId 
            ORDER BY s.name
        ) AS rn
    FROM topdesk.topdesk.`Suppliers` s
    JOIN topdesk.topdesk.`SupplierContracts` sc
        ON CAST(s.id AS VARCHAR) = CAST(sc.supplierId AS VARCHAR)
) t
WHERE rn = 1;
