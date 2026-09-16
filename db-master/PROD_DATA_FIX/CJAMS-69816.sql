/*
Issue Description: CJAMS-69816
Category/Module: Overdue Reason
Root cause: Only the 1st drop down was saved for both overdue reasons. The 2nd drop down has to be picked before the 3rd one appears, so the 2nd and 3rd values were never saved.
Fix provided: Data fix to update the over due reason as Alleged victim Unavailable > Attempted Face to Face > 3-4 Attempts and Initial Contact Caregiver Unavailable > Attempted Face to Face > 3-4 Attempts
Reason why no related code fix: User error
*/

update cpsresponsetimeractions
set cpsresponsetimerreason2='VAFF',
	cpsresponsetimerreason3='V34F',
	cpsresponsetimerreason8='CFFN',
	cpsresponsetimerreason9='C34F',
	updatedby='CJAMS-69816',
	updatedon=now()
where cpsresponsetimeractionsid='8396675a-dc44-4ac0-9f8b-97b60ccb4804' and activeflag=1;