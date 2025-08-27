CREATE OR REPLACE VIEW dfs.tmp.incidenten AS
SELECT
  CAST(id AS VARCHAR) AS id,
  CAST(REPLACE(REPLACE(SUBSTR(A.creationDate, 1, 19), 'T', ' '), 'Z', '') AS TIMESTAMP) AS aanmelddatum,
  CAST(REPLACE(REPLACE(SUBSTR(A.completionDate, 1, 19), 'T', ' '), 'Z', '') AS TIMESTAMP) AS afmeldingsdatum,
  CAST(REPLACE(REPLACE(SUBSTR(A.targetDate, 1, 19), 'T', ' '), 'Z', '') AS TIMESTAMP) AS streefdatum,
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
  AND CAST(REPLACE(REPLACE(SUBSTR(creationDate, 1, 19), 'T', ' '), 'Z', '') AS TIMESTAMP) >= TIMESTAMPADD(YEAR, -3, CURRENT_DATE);
