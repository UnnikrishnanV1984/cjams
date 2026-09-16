/* 
    Issue Description: CDM-39750
  Category/ Module  : Placement
  Root cause: User error to change the CPA home address 
  Pull request# for code fix: 
  Reason why no related code fix: N/A
  Status of the code fix if already submitted and expected prod fix date: 
  Backup before update/ delete: 
*/


update assessment 
    set submissiondata = replace(submissiondata::text, ' 143 Ironwood Rosedale MD 21237', '935 Pirates Court Edgewood, Maryland 21040')::json
	WHERE assessmentid = '17def785-b141-48a1-ade5-a56ca4237395' AND activeflag = 1;
    

update assessment 
    set submissiondata = replace(submissiondata::text, ' 143 Ironwood Rosedale MD 21237', '935 Pirates Court Edgewood, Maryland 21040')::json
	WHERE assessmentid = 'e33355a2-f068-41c8-b791-03dd18e3c199' AND activeflag = 1;