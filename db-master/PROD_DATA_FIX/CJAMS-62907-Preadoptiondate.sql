/*
Issue:Please proceed with the data fix to update the adoption finalization date as "12/6/2002" as the client profile can not be saved as the Previous Adoption Date is blank.Client ID: 1414686 (Breanna Clifford) Adoption Case: 3085664 Agreement Start Date: 12/6/2002
Root Cause:User requested to updated the Previous Adoption Date.
Fix Provided (Data Fix Only):Updated into person table.
Data/Code fix ticket#: CJAMS-62907
Regression Impacts:None 
Is Code fix Required?:no
Code fix ticket#: n/a
Reason why no related code fix:Data error
Backup before update/delete:
*/

update person 
set preadoptiondate ='2002-12-06 00:00:00.000',updatedby ='CJAMS-62907',updatedon =now()
where personid ='59b673fe-5c81-4657-b5e4-9829945771fc' and activeflag =1;


