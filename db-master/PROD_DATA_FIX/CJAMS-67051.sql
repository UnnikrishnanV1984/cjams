/* 
   Issue Description: CJAMS-67051
   Category/ Module  : AR Case Narrative Summary
   Root cause: Issue is not replicable in stage3 , user wants to delete duplicate record from ARSummary tab
   Fix provided: Data fix has been done to remove the duplicate record from AR summary tab
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/
update investigationallegation 
	set activeflag = 0, updatedon = now(), updatedby = 'CJAMS-67051' 
	where investigationallegationid in ('be75e0d2-7737-48f7-acb8-c54bd3525202') and activeflag = 1;

update investigationallegationmaltreators 
	set activeflag = 0, updatedon = now(), updatedby = 'CJAMS-67051' 
	where investigationallegationid in ('be75e0d2-7737-48f7-acb8-c54bd3525202') and activeflag = 1;