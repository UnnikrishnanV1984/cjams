/*
   Issue Description: CDM-33157
   Category/ Module  : Permanency plan
   Root cause: wrong reviewdate
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


update permanencyplan set reviewdate ='2023-07-14 00:00:00',updatedby ='CDM-33157',updatedon =now() where permanencyplanid ='f0090a32-1954-4d42-8395-100a75227f39';