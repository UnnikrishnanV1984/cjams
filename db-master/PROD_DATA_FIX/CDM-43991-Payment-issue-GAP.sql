/*
   Issue Description: CDM-43991
   Category/ Module : Payment issue.
  Root cause: user wants to change
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   
*/

update gapratesrevision
set approvaldate = now(),updatedon = now(), updatedby ='CDM-43991'
where gaprateid = '88751d6d-59ac-4352-ac36-ba0a34c68993' and activeflag = 1 ;