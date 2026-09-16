/*
  Issue Description:  CDM-42515
   Category/ Module  :  Approval
   Root cause: Service case needs to be deleted beacuse there is no information why it has been created
   Pull request# for code fix: NA
   Reason why no related code fix: For deactivating the users from CJAMS data fix is needed
   Status of the code fix if already submitted and expected prod fix date: NO
   Backup before update/ delete: NA
*/

update servicecase
set activeflag = 0,
	updatedon = now(), 	
	updatedby = 'CDM-42515'
where servicecaseid = 'c678236a-d800-4b5c-96b6-316bd8905892'
	and activeflag = 1 ;

    update servicecaserequest
set activeflag = 0,
	updatedon = now(), 	
	updatedby = 'CDM-42515'
where servicecaseid = 'c678236a-d800-4b5c-96b6-316bd8905892'
	and activeflag = 1 ;

    update servicecasedisposition
set activeflag = 0,
	updatedon = now(), 	
	updatedby = 'CDM-42515'
where servicecaseid = 'c678236a-d800-4b5c-96b6-316bd8905892'
	and activeflag = 1 ;

    update routing
set activeflag = 0,
	updatedon = now(), 	
	updatedby = 'CDM-42515'
where objectid = 'c678236a-d800-4b5c-96b6-316bd8905892'
	and eventcode = 'SRVC'
	and activeflag = 1 ;

  update caseassignment 
  set activeflag = 0,
  updatedon = now(), 	
  updatedby = 'CDM-42515'
 where objectid = 'c678236a-d800-4b5c-96b6-316bd8905892' 
 and activeflag = 1;