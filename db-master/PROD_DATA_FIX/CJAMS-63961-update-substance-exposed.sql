/*
Issue: CJAMS-63902 change name
Category/Module: Person Profile
Root cause: Adoption Case# 251040576105, Connected with the user, the issue is user is unable to add the SSN number to the Client ID: 204234375 (LIAM ALEXZANDER Wilkinson) because the SEN Substance class which is a mandatory field is not having data due to which the profile is not getting saved. Requested the user for the "Substance Class" details to be updated as a data fix. 
            Need data fix to update the SEN "Substance class" for the Client ID: 204234375 (LIAM ALEXZANDER Wilkinson), Adoption Case# 251040576105.
            Substance Class: Baby - Methadone.
Fix provided:Data fix has been done to update the SEN "Substance class" for the Client ID: 204234375 (LIAM ALEXZANDER Wilkinson), Adoption Case# 251040576105.
Data/Code fix ticket#: CJAMS-63961
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: This is as per system design and data fix is needed to update the SEN information for the child.
*/

update person
set substanceclasses = '["BMTD"]',
	updatedby = 'CJAMS-63961', 
	updatedon = now()
where cjamspid = '204234375'
	and activeflag = 1;