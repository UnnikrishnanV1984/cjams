/*
   Issue Description: CDM-17691
   Category/ Module  : delete duplicate entries
   Root cause: user wants to remove duplicate entries
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update intakesnapshot set activeflag =0,updatedby ='CDM-16961',updatedon =now() where intakesnapshotid in ('b5c815ff-7f0a-4d04-8b1f-b923d24bd826','ece5abb2-65f0-40a2-b312-d8db943cc66c');
