/*
   Issue Description: CDM-22242
   Category/ Module  : Prod data fix to remove the contact notes
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update progressnote set activeflag = 0, updatedby = 'CDM-22242', updatedon = now() 
where witsid in ('9415269', '9429686') and activeflag = 1;

update progressnotedetail set activeflag = 0, updatedby = 'CDM-22242', updatedon = now() 
where progressnoteid in ('b574fdcd-2a01-4886-ada7-e8fb89c7dbf5',
'71df9c13-4123-4787-a904-ec9dd3323bd5') and activeflag = 1;

