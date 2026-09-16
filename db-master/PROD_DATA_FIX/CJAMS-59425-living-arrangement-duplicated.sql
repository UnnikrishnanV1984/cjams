/*
Issue Description:CJAMS-59425 :202103605823:I entered a Kin as living arrangement in the Placement section and it duplicated. I approved one, but please remove the entree that is still under review
Category/Module: Living Arrangement 
Root cause:Duplicate living arrangement got inserted while creating a RFKH and data fix needs to be done remove it.
           We are investigating further in this ticket and CIDM will be created for investigating this issue.
Fix provided: Data fix to delete duplicate living arrangement record.
Regression Impacts: N/A
Is Code fix Required?: yes
Code fix ticket#: TBD 
Reason why no related code fix: We are unable to replicate this ticket and stage-3 and we are closely monitoring this issue.
*/


update placement 
set activeflag = 0,
	updatedby = 'CJAMS-59425',
	updatedon = now()
where placementid ='38849670-a2aa-42ba-bbdc-ebe3b202fe16' and activeflag =1;

update livingarrangement 
set activeflag = 0,
   updatedby = 'CJAMS-59425', 
   updatedon = now()
where placementid ='38849670-a2aa-42ba-bbdc-ebe3b202fe16' and activeflag =1;


update placementrevision
set activeflag = 0,
    updatedby = 'CJAMS-59425', 
   updatedon = now()
where placementid ='38849670-a2aa-42ba-bbdc-ebe3b202fe16' and activeflag =1;


UPDATE routing 
SET activeflag = 0, updatedby = 'CJAMS-59425', updatedon = now() 
WHERE objectid = '38849670-a2aa-42ba-bbdc-ebe3b202fe16' and activeflag=1;