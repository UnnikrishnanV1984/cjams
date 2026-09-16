/*
Issue:Please proceed with the data fix to update the adoption finalization date as "12/6/2002" as the client profile can not be saved as the Previous Adoption Date is blank.Client ID: 1414686 (Breanna Clifford) Adoption Case: 3085664 Agreement Start Date: 12/6/2002
Root Cause:User requested to updated the removal type key.
Fix Provided (Data Fix Only):Updated into intakeservreqchildremoval table.
Data/Code fix ticket#: CJAMS-62831
Regression Impacts:None 
Is Code fix Required?:no
Code fix ticket#: n/a
Reason why no related code fix:Data error
Backup before update/delete:
*/

update intakeservreqchildremoval 
set parent2comments  ='The father is unknown',updatedby  ='CJAMS-62831',updatedon  =now()
where intakeservreqchildremovalid ='4e28ceaf-1236-402b-9ae3-4e3fca1fd89a' and activeflag =1;


update intakeservreqchildremoval_history 
set parent2comments  ='The father is unknown',updatedby  ='CJAMS-62831',updatedon  =now()
where intakeservreqchildremovalid ='4e28ceaf-1236-402b-9ae3-4e3fca1fd89a' and activeflag =1;

