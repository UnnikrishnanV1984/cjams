-- B-137390 - PI 32 - SP05-Historic SEN Persons Flag (CIDM-5758)
-------------------------------------------------------------------------------------------------------
-- Add new columns to capture SEN flag status ( 1 as Active and 0 as Historic)
------------------------------------------------------------------------------------------------------- 

-- Add Column
Alter table cjams.person add column if not exists senstatusflag integer null;
-- Alter table cjams.person alter column senstatusflag set default 1;

COMMENT ON COLUMN cjams.person.senstatusflag IS 'SEN Status Flag to Identify Active vs Historic SENs';
