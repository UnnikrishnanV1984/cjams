-- CDM-17113 - missing case info
/*
-- Issue Description: 
	3246350: the entire case of documentation is missing
	User is saying that she lost all the data
	(assessment, documents, contact notes) entered after the case is reopened in 2021. 
   
-- SEN Inatke # I211010163842 - 4f099bec-7531-4de7-af2d-e83e837a7ccb - 211020126082
-- CASE ID 3246350 - 1eae8872-1fab-4926-a4fd-b858b6f75f79 was re-opned in 2021 with RISK OF HARM

-- Issue:  This intake (# I211010163842) was originally connected with the Service case # 211030008448. 
-- And this case was deleted as a part of CDM-14118

-- Issue:  This intake (# I211010163842) was originally connected with the Service case # 211030008448. And this case was deleted as a part of CDM-14118
-- To move Contacts and Asessments from Service CAse # 211030008448 to Service Case # 3246350
 
-- Category/ Module: Case Data (Case Management) 
-- Root cause: N/A
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Progress Notes

select progressnoteid, contactdate, entitytype, entitytypeid, activeflag, updatedby, updatedon 
	from progressnote 
where entitytypeid = 'c98b96c8-78f6-4476-a42a-5baa526cbd5f' -- 211030008448
	and activeflag = 1 ;
	
update progressnote
set entitytype = 'servicecase',
	entitytypeid = '1eae8872-1fab-4926-a4fd-b858b6f75f79', -- 3246350
	updatedby = 'CDM-17113',
	updatedon = now()
where entitytypeid = 'c98b96c8-78f6-4476-a42a-5baa526cbd5f' -- 211030008448
	and activeflag = 1 ;

	
-- Assessments
select assessmentid, objectname, objectid, servicecaseid, activeflag, updatedby, updatedon 
from assessment a 
where ( objectid = 'c98b96c8-78f6-4476-a42a-5baa526cbd5f' -- 211030008448
		or
		servicecaseid = 'c98b96c8-78f6-4476-a42a-5baa526cbd5f' -- 211030008448
	)	
	and activeflag  = 1 ;

update assessment
set objectname = 'servicecase',
	objectid = '1eae8872-1fab-4926-a4fd-b858b6f75f79', -- 3246350
	servicecaseid = '1eae8872-1fab-4926-a4fd-b858b6f75f79' -- 3246350
--	updatedby = 'CDM-17113',
--	updatedon = now()
where ( objectid = 'c98b96c8-78f6-4476-a42a-5baa526cbd5f' -- 211030008448
		or
		servicecaseid = 'c98b96c8-78f6-4476-a42a-5baa526cbd5f' -- 211030008448
	)	
	and activeflag  = 1 ;

-- No Documents
select count(*)
	from documentproperties d  
where  objectid = 'c98b96c8-78f6-4476-a42a-5baa526cbd5f' -- 211030008448
	and activeflag = 1 ;
