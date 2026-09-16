/*
Issue: CJAMS-60892 Contact Correct PID with Adoption Case
Category/Module: Person / Adoption case
Root cause: Incorrect persons have been added to the adoption case and data fix is needed to correct them.
Fix provided:Data fix has been done to correct the persons in the adoption case
             case number : 211040011966
             Adoptive Parent Monique Amy Ellison 200827287 to be replaced with  3848367
            Adoptive Parent Katrina Yvette Ellison 200827288 to be replaced with  200108496   
Data/Code fix ticket#: CJAMS-60892
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data entry error
*/


update adoptioncaseactor 
set personid = 'e3077fd5-8016-4379-b5e2-9fc5903a89e9',
	updatedby = 'CJAMS-60892',
	updatedon = now()
where adoptioncaseactorid = 'ab741392-449a-46f3-bf3f-5cd4ecbf2946'
and adoptioncaseid  = '5d2f3d89-f213-4ef5-a67b-bad5e68625a3'
and activeflag = 1;


update adoptioncaseactor 
set personid = 'de3d8192-0409-4883-8d93-22e0e741d28b',
	updatedby = 'CJAMS-60892',
	updatedon = now()
where adoptioncaseactorid = 'ec9111d6-3c15-4cf6-8787-f9bcce147a50'
and adoptioncaseid  = '5d2f3d89-f213-4ef5-a67b-bad5e68625a3'
and activeflag = 1 ;
