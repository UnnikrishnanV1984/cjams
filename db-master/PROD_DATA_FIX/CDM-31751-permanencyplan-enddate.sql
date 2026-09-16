/*
   Issue Description: CDM-31751
   Category/ Module  : Permanency Plan
   Root cause: user wants to change  enddatedate for permanency plan
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
     Need to do data fix
*/

update permanencyplan set enddate = null,updatedby ='CDM-31751',updatedon =now() where permanencyplanid in ('3abe8673-0a53-402d-83b4-d81dcdfab8e8','b81805bd-93b4-4570-9033-f3f82100a092');