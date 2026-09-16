-- CIDM-4204 - Placement Validation Enhancement and Checkbox to Identify CfE Youth (B-123939)

-- Add Column in cjams.person table to identify "CfE Resource Home Child" 
alter table cjams.person add column if not exists cferesourcehomechild boolean;
