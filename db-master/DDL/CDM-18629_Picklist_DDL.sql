-- CDM-18629 -  CJAMS - MDM person registration issues
-------------------------------------------------------------------------------------------------------
-- Add new column to capture MDM Reference Codes 
------------------------------------------------------------------------------------------------------- 

-- Add Column
Alter table cjams.tb_picklist_values add column if not exists mdmcode varchar(20) NULL;

COMMENT ON COLUMN cjams.tb_picklist_values.mdmcode IS 'Column to capture MDM Reference Value Codes';
