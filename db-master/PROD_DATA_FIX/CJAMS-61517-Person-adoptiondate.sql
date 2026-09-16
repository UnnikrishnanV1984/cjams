/* 
    Issue Description: CJAMS-61517
   Category/ Module  : Person
   Root cause: User requested to update pre adoption date in person
   Pull request# for code fix: 
   Reason why no related code fix: User Error 
*/

update person 
set preadoptiondate ='2007-01-04', 
	updatedby ='CJAMS-61517', 
	updatedon = now()
where personid ='cc988ba6-d6d6-44d1-a80b-166a7a1c141e' and activeflag =1;
