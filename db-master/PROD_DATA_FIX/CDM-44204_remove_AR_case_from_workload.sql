/*
   Issue Description: CDM-44204
   Category/ Module  : CJAMS
   Root cause: remove: CPS AR case 20200128018396(AR) from Shelley Sexton's workload. 
   Also,SSA approved on 02/21/2025 and please proceed with the data fix to delete the CPS AR case 20200128018396
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Need to do data fix
*/ 
/*
select routedusersid,intakeserreqstatustypeid,* from intakeservicerequest i  where servicerequestnumber = '20200128018396' and activeflag =1;
select * from intakeserreqstatustype i where intakeserreqstatustypekey in ('Closed','Approved');
--closed: 642f18b0-ef6e-4d4b-9871-acc0734f3f5a
--approved: 52ad4cc7-e8f8-4cbb-9e27-d86f2b817690
select * from caseassignment c where objectid ='0947e6d8-a49e-44ea-ba08-606e67f9daf4'
select jsondata,* from intakedastaging i where intakenumber = 'I202000460884' and activeflag =1;
*/

--Ending assignment in caseassignment
update caseassignment
set activeflag = 0,updatedby = 'CDM-44204', updatedon = now()
where caseassignmentid = '289f0d6b-ce47-488a-ad6d-147f878015da' and activeflag = 1;

-- changing status to close, delete case recent change (02/21/2025)
update intakeservicerequest 
set intakeserreqstatustypeid  = '642f18b0-ef6e-4d4b-9871-acc0734f3f5a',
	activeflag = 0,
   actiontype = null,
	updatedby = 'CDM-44204', updatedon = now()
where servicerequestnumber = '20200128018396' and activeflag =1;

/*
select activeflag ,* from intakeservicerequestdispositioncode i
where intakeserviceid = '0947e6d8-a49e-44ea-ba08-606e67f9daf4'
and activeflag = 1;
*/

update intakeservicerequestdispositioncode 
set activeflag = 0,
	updatedby = 'CDM-44204',
	updatedon = now()
where intakeserviceid = '0947e6d8-a49e-44ea-ba08-606e67f9daf4'
and activeflag = 1;
