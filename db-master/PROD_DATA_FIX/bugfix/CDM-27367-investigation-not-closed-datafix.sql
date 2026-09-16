-- CDM-27367 - investigation not closed
/*
-- Issue Description: 
#Case # 3177705 
Two cases listed under Program Assignments should have been end dated because the cases were already closed.
202101320109206 - End Date should be 7/09/2021

202003420960695 - End Date should be 2/02/2021

-- Resolution: updated enddate for programarea

-- Category/ Module: Case Management
-- Root cause: User Request
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A

*/

select 	enddate, * from personprogramarea 
where 	personprogramid in ('846410c3-8a45-421c-9ed1-9fc1576d43fd','348d0f11-e8e5-485b-b446-c9b275642b0a');

update 	personprogramarea
set 	enddate = '2021-07-09',
		updatedon = now(),
		updatedby = 'CDM-27367'
where 	personprogramid ='846410c3-8a45-421c-9ed1-9fc1576d43fd' and activeflag = 1;

update 	personprogramarea
set 	enddate = '2021-02-02',
		updatedon = now(),
		updatedby = 'CDM-27367'
where 	personprogramid = '348d0f11-e8e5-485b-b446-c9b275642b0a' and activeflag = 1;

