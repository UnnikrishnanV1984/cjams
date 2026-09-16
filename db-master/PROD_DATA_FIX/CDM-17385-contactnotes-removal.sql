/*
   Issue Description: CDM-17385
   Category/ Module  :  Contacts
   Root cause: user requeseted to remove the contact note
   Pull request# for code fix: 7393
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update progressnote 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-17385'
where progressnoteid = '34f17bf4-4da3-4a24-91e6-7264ec763aa7';