/*
   Issue Description: CDM-14944
   Category/ Module  :  Living Arrangement  
   Root cause: user wants to remove
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update livingarrangement 
set livingenddate = '2021-04-28 00:00:00.050337', updatedon = now(), updatedby = 'CDM-14944' 
where placementid = '4abe9bcc-e0bc-42be-a7e7-0612d21517c1';
update placement 
set enddatetime = '2021-04-28 00:00:00.050337', updatedon = now(), updatedby = 'CDM-14944' 
where placementid = '4abe9bcc-e0bc-42be-a7e7-0612d21517c1';