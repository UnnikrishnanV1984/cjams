/*
   Issue Description: CJAMS-66481
   Category/ Module  :  Requested to delete the duplicate person (cjamspid #200887770 )
   Root Cause: User Wants to delete the duplicate person (cjamspid #200887770 )
   Fix provided: Data fix has been done by deleting the requested duplicate person (cjamspid #200887770 )
   Pull request for code fix: 
*/

update person
set activeflag =1, updatedby ='CJAMS-66481', updatedon =now()
where cjamspid ='200887770' and personid ='c3327cea-a20e-4ee5-b0cc-aca4d7ec511f';

update personprogramarea 
set activeflag =0, updatedby ='CJAMS-66481', updatedon =now()
where personid ='c3327cea-a20e-4ee5-b0cc-aca4d7ec511f' and activeflag =1;

update actor
set activeflag =0, updatedby ='CJAMS-66481', updatedon =now()
where actorid ='69ece847-17b0-4e54-82b5-1128d3338659' and activeflag =1;

update intakeservicerequestactor 
set activeflag =0, updatedby ='CJAMS-66481', updatedon =now()
where intakeservicerequestactorid ='fbbfbaf0-dfac-44d1-b41c-c3d10b38d57e' and actorid ='69ece847-17b0-4e54-82b5-1128d3338659';

update personrole
set activeflag =0, updatedby ='CJAMS-66481', updatedon =now()
where personroleid ='eab83071-ef34-4991-93a6-d0a6d7bd7799' and personid ='c3327cea-a20e-4ee5-b0cc-aca4d7ec511f';

update personroletype 
set activeflag =0, updatedby ='CJAMS-66481', updatedon =now()
where personroleid  ='eab83071-ef34-4991-93a6-d0a6d7bd7799' and personroletypeid ='08030936-f82f-4678-806c-3707e3a961cd';

update
	cjams.assessment
set
	submissiondata = jsonb_set(submissiondata, '{childdatagrid}', '[
	{
	    "age": "5 Yrs",
	    "clientid": "4354357",
	    "childname": "AMARI S BRYANT"
	}
  ]') ,
	updatedon = now(), updatedby='CJAMS-66481'
where
	assessmentid in ('97d5e7ec-b892-44e2-b776-523052d44c78', '73118c9a-48a0-4408-827c-c163f3fb3a0e');