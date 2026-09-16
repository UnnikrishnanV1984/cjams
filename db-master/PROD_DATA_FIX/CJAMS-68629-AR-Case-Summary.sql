/* 
   Issue Description: CJAMS-68629
   Category/ Module  : AR Case Narrative Summary
   Root cause: we are having two records in database for maltreatment allegation but on UI we are unifying and showing it as single record so need further analysis on this issue  ,code fix ticket has been raised and for this we are removing the duplicate AR summary record as part of datafix.
   Fix provided: Data fix has been done to remove the duplicate record from AR summary tab
   Is code fix required : CIDM-11344
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
  
*/
update investigationallegation 
	set activeflag = 0, updatedon = now(), updatedby = 'CJAMS-68629' 
	where investigationallegationid in ('a0e7efa4-3d8f-49b6-8dd2-705969a8e969') and activeflag = 1;

update investigationallegationmaltreators 
	set activeflag = 0, updatedon = now(), updatedby = 'CJAMS-68629' 
	where investigationallegationid in ('a0e7efa4-3d8f-49b6-8dd2-705969a8e969') and activeflag = 1;