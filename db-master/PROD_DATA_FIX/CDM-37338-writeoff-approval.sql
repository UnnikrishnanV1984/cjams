/*
   Issue Description: CDM-37338
   Category/ Module  :  Writoff-approval
   Root cause: user requested to change the write off approver
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update routing set 
tosecurityusersid  ='e7ea364c-c81d-473b-82db-2abbdf28b9e0',
updatedby  ='CDM-37338',
updatedon =now()
where objectid = '1739893'
and eventcode = 'FNSWO'
and activeflag = 1;