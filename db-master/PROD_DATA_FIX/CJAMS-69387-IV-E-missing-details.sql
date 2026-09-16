/*
Category/Module: Primary caregiver details to be updated on child removal to display them on IV E
Root cause: Missing primary caregiver details on IV-E side as they are not updated in child removal
Fix provided: Data fix has been provide by updating primary caregiver details child removal so that they reflect on IV-E screen
Is Code fix Required?: NO
Code fix ticket#: N/A 
Reason why no related code fix: User error
*/



update intakeservreqchildremoval 
set primarycaregiverid ='1504528', 
	primarycaregiveractorid ='fbc62662-8467-4f71-b759-e2ec937aedce',
	isverifiedreporteradd =1, 
	primarycaregiveradd ='13117 Wonderland Way Apt B, Germantown, MD', 
	updatedby ='CJAMS-69387', 
	updatedon =now()
where intakeservreqchildremovalid ='7f5f2391-5975-4031-a112-4f49c93f9007' and servicecaseid ='86a68812-5951-43e5-a672-83bf7a93945a' and activeflag =1;