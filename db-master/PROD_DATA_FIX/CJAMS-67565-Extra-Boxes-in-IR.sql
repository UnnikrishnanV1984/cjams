/* 
   Issue Description: CJAMS-67565
   Category/ Module  : IR investigation findings
   Root cause: CPS IR case is closed on 05/01/2026 and there are duplicate investigation findings for the same maltreatment type, alleged victim and alleged maltreator.
   Fix provided: Data fix has been done to remove the duplicate record from IR Findings.
   Is code fix required : CIDM-11344
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
  
*/


update investigationallegation 
set activeflag = 0, updatedon = now(), updatedby = 'CJAMS-67565' 
where investigationallegationid in ('cc919766-fd4a-479d-a4ca-f9d03d6207cb','6f26c962-bc61-4fa3-b346-e9e43dff42ca','08955303-1b18-41a7-888e-65eb02025cc3') and activeflag = 1;

update investigationallegationmaltreators 
set activeflag = 0, updatedon = now(), updatedby = 'CJAMS-67565' 
where investigationallegationid in('cc919766-fd4a-479d-a4ca-f9d03d6207cb','6f26c962-bc61-4fa3-b346-e9e43dff42ca','08955303-1b18-41a7-888e-65eb02025cc3') and activeflag = 1;