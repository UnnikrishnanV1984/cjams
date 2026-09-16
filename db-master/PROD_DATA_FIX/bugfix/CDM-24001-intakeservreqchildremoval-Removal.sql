--CDM-24001-Removal
/*
   File Name: CDM-24001-intakeservreqchildremoval-Removal
-- Issue Description: 
    For the case 221030016705: The child with CJAMSPID# 200770087 has two removals entered for the same day. 
	User wants to delete the open removal
	and user wants us to delete from approval box.
    Customer Email ID:kevin.buckley@maryland.gov
  
-- Resolution: Updated the activeflag to zero in intakeservreqchildremoval, personprogramarea table
               and delete_sw to Y in tb_client_eligibility table

-- Category/ Module: Case Management
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A

*/
update
	intakeservreqchildremoval
set
	activeflag = 0 ,
	updatedby = 'CDM-24001' ,
	updatedon = now()
where
	intakeservreqchildremovalid = '3c3b2659-c3b0-48d2-8074-bdc6a17379b7';

update
	tb_client_eligibility
set
	delete_sw = 'Y' ,
	update_user_id = 'CDM-24001' ,
	update_ts = now()
where
	removal_id = '254305';

update
	personprogramarea
set
	activeflag = 0 ,
	updatedby = 'CDM-24001' ,
	updatedon = now()
where
	personprogramid = 'c5875516-2bd0-41c9-b8fb-3912b6799ced';