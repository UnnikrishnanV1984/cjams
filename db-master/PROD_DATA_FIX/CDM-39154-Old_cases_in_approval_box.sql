/*
   Issue Description: CDM-39154
   Category/ Module  : SDM 
   Root cause: safec checklist is not checked in ar summary
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update routing 
set activeflag = 0, updatedby ='CDM-39154', updatedon=now() 
where eventcode ='CPLAN2' 
and activeflag = 1
and tosecurityusersid  ='9ed99ad6-2333-412f-8a80-6f14cef4f13e'; 