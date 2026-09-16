/*
Issue: CJAMS-62260 Closed mistakenly
Category/Module: CPS-IR / Disposition
Root cause: Case closed incorrectly by the user and data fix need to reopen the CPS IR case.
Fix provided:  Data fix has been done to re-open the closed CPS-IR case
Data/Code fix ticket#: 
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error
*/


/*
-- Completed 
select * from intakeserreqstatustype where intakeserreqstatustypeid = '7995cecb-062d-406c-8ea9-b1da4b1877d8';
--open
select * from intakeserreqstatustype where intakeserreqstatustypeid = 'c8dbf10f-843d-4b40-97ca-288d750463da';
-- accepeted: 52ad4cc7-e8f8-4cbb-9e27-d86f2b817690
*/

update Intakeservicerequestdispositioncode 
set servicerequesttypeconfigiddispostionid = '9a333c30-8043-4732-9f9a-622b8d8038da', --screened IN
	updatedon = now(),
	updatedby = 'CJAMS-62260'
where 	intakeservicerequestdispositioncodeid = '9dfad2ca-66c5-4554-8f3e-b57e00abe568';


update Intakeservicerequestdispositioncode
set activeflag =0,
	updatedon = now(),
	updatedby = 'CJAMS-62260'
where 	intakeservicerequestdispositioncodeid in ('6e71bb9b-4ffc-4edf-b5bf-f2b74b6c528c','7fd63035-0e8b-4db9-afe8-5a811d390b67','d62c0b02-e9dd-4605-8818-02c2a7ae2dbe','f91f245d-7812-4313-b599-41759b8d986e');

-- inspect the summary page to get intakeserviceid = '57c9efab-c0a4-46ad-afac-acb7e8994600'
update intakeservicerequest set exitdate = null,updatedby ='CJAMS-62260', updatedon = now(), intakeserreqstatustypeid = '52ad4cc7-e8f8-4cbb-9e27-d86f2b817690'
where intakeserviceid = 'f7912bde-7cd9-4bd9-a6de-662aff7eca2e' and activeflag=1;

--Remove Program area end date

update personprogramarea set enddate = null, updatedon = now() 
where personprogramid in ('32499883-534b-4ae9-9ec3-7b2d48a62110','88bb7b9b-503e-4a2f-a526-9bbee0944797')and activeflag =1;

--case assignement
update caseassignment 
set enddate = null, updatedby = 'CJAMS-62260', updatedon = now() 
where caseassignmentid ='22113b74-9c90-462c-8bbc-e95bdebd2791' and activeflag = 1
and objectid = 'f7912bde-7cd9-4bd9-a6de-662aff7eca2e';