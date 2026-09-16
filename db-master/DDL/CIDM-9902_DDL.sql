/*
-- CIDM-9902 - Added new column in defecttracking.cjamsjiratickets to copy the component name from JIRA ticket
*/
alter table defecttracking.cjamsjiratickets add column cdmcomponent character varying;
COMMENT ON COLUMN defecttracking.cjamsjiratickets.cdmcomponent IS 'this field is to store the component name updated in JIRA CDM ticket';