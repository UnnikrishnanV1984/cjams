/*
   Issue Description: CDM-32190
   Category/ Module  :Investigation Findings
   Root cause: User requested to remove wrong investigation findings
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/ 
update intakeservicerequest 
set 
   activeflag = 1,
   updatedby ='CDM-32190',
   updatedon =now() 
where 
   intakeserviceid = '1bccbe9c-f94c-4605-a3f3-071547235269';