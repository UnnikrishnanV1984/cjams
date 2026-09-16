/* Issue Description:CDM-13500 - updating contact information based on the actual user time enter
   Category/ Module  :  Contacts Information
   Root cause: unable to reproduce this
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 

*/



update progressnote set insertedon  ='2021-05-14 14:00:00', updatedby='CDM-13500', updatedon=now()  where progressnoteid ='5a79f7c7-405c-41eb-b2a9-088523355e6a';
update progressnotedetail set insertedon  ='2021-05-14 14:00:00', effectivedate ='2021-05-14 14:00:00', updatedby='CDM-13500', updatedon=now() where progressnoteid ='5a79f7c7-405c-41eb-b2a9-088523355e6a';