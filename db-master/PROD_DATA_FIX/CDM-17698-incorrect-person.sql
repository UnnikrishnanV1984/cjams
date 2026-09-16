/*
   Issue Description: CDM-17468
   Category/ Module  :  Incorrect person
   Root cause: The incorrect person(child) was added to the case in error 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update personprogramarea
set startdate ='2020-09-20'::date, updatedby = 'ef3032b3-2f5a-4b48-8b27-c33cf654abf6', updatedon =now()
where personprogramid ='740e665a-2061-403f-801c-7d5b53a74802';

update intakeservicerequestactor set personid ='1929f6d8-fb00-433a-affc-daf459e66e8c', updatedby = 'CDM-17698', updatedon =now()
where intakeservicerequestactorid='1e7c24b9-37bf-4091-9912-1b7f011fa44f';