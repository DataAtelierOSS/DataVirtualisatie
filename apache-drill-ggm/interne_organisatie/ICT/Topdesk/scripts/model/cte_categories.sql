CREATE TABLE dfs.tmp.cte_categories AS
SELECT 
  CAST(c.id AS VARCHAR) AS category_id,
  c.name AS category_name,
  CAST(s.mainCategoryId AS VARCHAR) AS subcategory_id,
  s.name AS subcategory_name
FROM topdesk.topdesk.`Categories` c
LEFT JOIN topdesk.topdesk.`Subcategories` s
  ON CAST(s.mainCategoryId AS VARCHAR) = CAST(c.id AS VARCHAR);
