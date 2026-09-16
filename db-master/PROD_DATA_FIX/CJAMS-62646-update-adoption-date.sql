/*
Issue Description: CJAMS-62646 Unable to add Adoption Date
Category/Module: Person Profile
Root cause:  The alleged maltreator, Bryan Daveler, has a prior adoption case. However, CJAMS would not allow me or the Administrative Asst enter the adoption date (11/8/2001) to the screen, which is needed to Save/Enter him
            data fix to add the Previous Adoption Date with 11/08/2001

Client ID: 1244937 (Bryan J Daveler)
Adoption Case: 3053511
Fix provided: Data fix has been done to update the previous adoption date (03/05/1996) for the client 1379932
Data/Code fix ticket#: CJAMS-62646
Regression Impacts: N/A
Is Code fix Required?: N/A
Code fix ticket#: N/A
Reason why no related code fix: Known issue with user profile as it cannot be updated without previous adoption date and data fix needed to update it.
*/

update person 
set preadoptiondate ='2001-11-08', 
	updatedby ='CJAMS-62646',
	updatedon = now()
where personid ='08b1e534-2b43-40d8-8e7a-063b39437cf2' and activeflag =1;