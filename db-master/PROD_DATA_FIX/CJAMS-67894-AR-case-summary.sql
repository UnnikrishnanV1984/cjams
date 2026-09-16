/*
   Issue Description: CJAMS-67894
   Category/ Module  : Prod data fix to revert maltreament type
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


update investigationallegation 
set activeflag=0, updatedby = 'CJAMS-67894', updatedon = now()
where investigationallegationid in ('c9bf1fb8-2b61-4999-be81-aee849066740','79063fa1-83a3-4840-860d-560e0096fc44') and activeflag = 1;

update investigationallegationmaltreators 
set activeflag = 0, updatedby = 'CJAMS-67894', updatedon = now()
where investigationallegationid in ('c9bf1fb8-2b61-4999-be81-aee849066740','79063fa1-83a3-4840-860d-560e0096fc44') and activeflag = 1;

