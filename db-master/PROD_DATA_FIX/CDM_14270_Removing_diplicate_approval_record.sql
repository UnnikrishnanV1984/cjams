/* Issue Description:CDM-14270 - Removing duplicate removal records
   Category/ Module  :  Service cases authorization id records
   Root cause: unable to reproduce this
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 

*/



delete from routing where routingid in ( 'bc137708-7c60-4973-8f33-059b5f935772',
'11d1f0da-5083-4ca4-8939-345a78bc5cf1',
'df61c997-744d-4f75-a2a6-3feb53a490d9',
'4d4edd6b-c853-4612-8a5d-34c103845202',
'f51492f5-2ed1-4178-89ad-73b3411f3ae8' )
and objectid = '1777154';

update routing set teamid ='13021883-e81b-49f1-8556-4e048236e271', updatedby ='CDM-14270', updatedon =now() where routingid  = '8a727561-1c6a-4e9f-b131-1ad424c20f28'
and  objectid = '1777154';