/*
   Issue Description: CDM-24740
   Category/ Module  : Removing Duplicate ProgramArea from case
   Root cause: user requeseted to remove ProgramArea
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update personprogramarea set activeflag = 0, updatedby = 'CDM-24740', updatedon = now() 
where  personprogramid in ('c11fedc1-9fdf-43c0-a8ad-6c57eb76ee63', 'e4a54ed8-a4d3-4fde-a620-d853915b9ce8', '07281f11-2e92-4a87-a321-33d3b622d22d');