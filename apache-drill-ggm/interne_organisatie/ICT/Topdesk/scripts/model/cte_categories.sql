CREATE TABLE dfs.tmp.cte_categories AS
SELECT 
  CAST(c.id AS VARCHAR) AS category_id,
  c.name AS category_name,
  CAST(s.id AS VARCHAR) AS subcategory_id,
  s.name AS subcategory_name
FROM dfs.tmp.categories c
LEFT JOIN dfs.tmp.subcategories s
  ON CAST(s.categoryId AS VARCHAR) = CAST(c.id AS VARCHAR);
