/*
   Issue Description: CDM-33676
   Category/ Module  : Contacts
   Root cause: User requested to update the worker error in contact purpose
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/ 

update progressnote 
set progressnotereasontypekey='CM,PCV,MV',
updatedby ='CDM-33676',
updatedon =now()
where witsid =11089855 and progressnoteid ='34d181f6-1b2c-4f90-b357-f7293a58499d';