-- CIDM-5447 ResponseTimer Alter DDL to add case worker and supervisor comments

alter table cpsresponsetimeractions add column if not exists caseworkercomments character varying; 
alter table cpsresponsetimeractions add column if not exists supervisorcomments character varying;

COMMENT ON COLUMN cjams.cpsresponsetimeractions.caseworkercomments 
	IS 'Case worker''s comments for the Response Timer Save';
	
COMMENT ON COLUMN cjams.cpsresponsetimeractions.supervisorcomments 
	IS 'Supervisor''s comments for the Response Timer Save Approval/Rejection';
