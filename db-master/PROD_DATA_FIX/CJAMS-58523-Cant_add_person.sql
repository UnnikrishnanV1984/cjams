/* 
    Issue Description: CJAMS-58523
   Category/ Module  : Person
   Root cause: User requested to update pre adoption date in person
   Pull request# for code fix: 
   Reason why no related code fix: User Error 
*/

update person 
set preadoptiondate ='2013-08-22 00:00:00.000', 
	updatedby ='CJAMS-58523', 
	updatedon = now()
where personid ='9bc81680-f4af-42af-ac27-3f8f4504b91f' and activeflag =1;