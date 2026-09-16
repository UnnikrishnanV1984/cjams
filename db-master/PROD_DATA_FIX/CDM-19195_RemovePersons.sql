/*
   Issue Description: CDM-19195 Intake- remove persons
   Category/ Module  : Intake quick persons
   Root cause: Quick persons are not removable after intake complete, (new story)
   Pull request# for code fix: 
   Reason why no related code fix:  
   Status of the code fix if already submitted and expected prod fix date: 
*/

	update cjams.intakeservicerequestactor set activeflag =0, updatedby='CDM-19195', updatedon=now() 
	where intakeservicerequestactorid in ('cee68509-628e-40ca-9ca8-d84491533c54','8daa7630-ccd8-47ea-b125-e926ec58e6ad');

	update cjams.actor set activeflag =0, updatedby='CDM-19195', updatedon=now() 
	where actorid in ('5a4bef4d-5a8a-4db4-837a-0bb9893e8be0', '00b95c25-f80b-4230-87d2-7c5349cf13f0');