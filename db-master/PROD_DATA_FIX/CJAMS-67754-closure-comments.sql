/*
   Issue Description: CJAMS-67754
   Category/ Module  : Case closure comments
   Root cause: User accidentally placed one case's "Case Closure Summary" under another cases decision and requested to delete it.
   Fix provided: Data fix is done by deleteing the case closure comments as requested
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


update servicecasedisposition
set comments='', updatedby='CJAMS-67754', updatedon=now()
where servicecaseid='6f59a3b2-5513-4378-8d26-cdd272e153b9' 
and servicecasedispositionid='30d6bed6-a25f-4b7d-b8c1-1db90279b5f8';