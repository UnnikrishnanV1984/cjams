/*
   Issue Description: CDM-30135
   Category/ Module  : teammember roletypekey updated
   Root cause: superviosr not shown in the supervisor list
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
     Need to do data fix
*/


Update teammember as tm set roletypekey = 'CWSP' , updatedby = 'CDM-30135'
where tm.activeflag = 1 and tm.teammemberid = '412271a7-7b7b-4028-8807-edc2a9f0564d';
