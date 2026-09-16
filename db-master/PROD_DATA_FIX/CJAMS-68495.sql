/* 
   Issue Description: CJAMS-68495
   Category/ Module  : AR Case Narrative Summary
   Root cause: Issue is not replicable in stage3 , user wants to delete duplicate record from ARSummary tab
   Fix provided: Data fix has been done to remove the duplicate record from AR summary tab
   Is code fix required: N
   Reason why no related code fix: Not replicable in stage3
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/
update investigationallegation 
	set activeflag = 0, updatedon = now(), updatedby = 'CJAMS-68495' 
	where investigationallegationid in ('bd91cd6d-eaa7-4a56-a460-516c156fbc6c') and activeflag = 1;

update investigationallegationmaltreators 
	set activeflag = 0, updatedon = now(), updatedby = 'CJAMS-68495' 
	where investigationallegationid in ('bd91cd6d-eaa7-4a56-a460-516c156fbc6c') and activeflag = 1;