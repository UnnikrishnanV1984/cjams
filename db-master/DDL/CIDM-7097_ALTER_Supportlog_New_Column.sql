alter table defecttracking.supportlog add column if not exists cdmticketno character varying;  
COMMENT ON COLUMN defecttracking.supportlog.cdmticketno IS 'JIRA CDM Ticket Corresponding to Contact Support Ticket'; 
