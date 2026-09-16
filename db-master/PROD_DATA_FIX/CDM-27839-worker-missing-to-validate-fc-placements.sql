/*
   Issue Description: CDM-27839
   Category/ Module  : placements
   Root cause: case worker is not showing in the placement screen drop down
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update
  teammember
set
  roletypekey = 'CWCW',
  updatedby = 'CDM-27839',
  updatedon = now()
where
  teammemberid = '870753dc-9138-49c8-97e7-062b520e1291';