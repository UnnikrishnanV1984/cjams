/* Issue Description:CDM-13501 - updating contact information based on the actual user time enter
   Category/ Module  :  Contacts Information
   Root cause: unable to reproduce this
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 

*/



update progressnote set insertedon  ='2021-05-14 14:00:00', updatedby='CDM-13501',updatedon=now() where progressnoteid ='73cfac8e-a485-4f58-a23c-a31114563dd3';
update progressnotedetail set insertedon  ='2021-05-14 14:00:00', effectivedate ='2021-05-14 14:00:00', updatedby='CDM-13501', updatedon=now() where progressnoteid ='73cfac8e-a485-4f58-a23c-a31114563dd3';

