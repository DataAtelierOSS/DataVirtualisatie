CREATE VIEW dfs.tmp.incidenten AS
SELECT
  CAST(id AS VARCHAR) AS id,
  creationDate,
  completionDate,
  targetDate,
  CAST(categoryId AS VARCHAR) AS category_id,
  CAST(subcategoryId AS VARCHAR) AS subcategory_id,
  CAST(operatorGroupId AS VARCHAR) AS operatorGroup_id,
  CAST(operatorId AS VARCHAR) AS operator_id,
  CAST(processingStatusId AS VARCHAR) AS status_id,
  CAST(entryTypeId AS VARCHAR) AS entrytype_id,
  CAST(typeId AS VARCHAR) AS incidenttype_id,
  CAST(configurationItemId AS VARCHAR) AS config_item_id 
FROM topdesk.topdesk.`Incidents`
WHERE creationDate IS NOT NULL
  AND SUBSTR(creationDate, 1, 4) BETWEEN '2000' AND '2100'
  AND CAST(SUBSTR(creationDate, 1, 4) AS INT) >= CAST(SUBSTR(CURRENT_DATE, 1, 4) AS INT) - 3;
