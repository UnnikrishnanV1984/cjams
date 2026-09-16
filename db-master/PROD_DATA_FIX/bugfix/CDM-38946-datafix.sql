/* 
    Issue Description: CDM-38946
  Category/ Module  : Assignments
  Root cause: As requested end dated the old record
  Pull request# for code fix: 
  Reason why no related code fix: 
  Status of the code fix if already submitted and expected prod fix date: 
  Backup before update/ delete: 
*/

update caseassignment
set enddate = '2024-05-09 00:00:00',
updatedon = now(),
updatedby = 'CDM-38946'
where caseassignmentid = '8051d052-405e-4151-a344-4a01e7c28420';