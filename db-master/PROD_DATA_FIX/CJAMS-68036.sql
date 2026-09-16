
/*
Issue Description: CJAMS-68036 - Missing Investigation Finding Tab
Category/Module: Case Management
Root cause: Investigation findings tab was empty because of allegationid mismatch because the investigationallegation row has allegationid pointing to 'Neglect'(updated during the OAH modification), but the maltreatment allegation it still shows "Physical abuse". so UI doesnt show anything because physcial abuse != neglect.
Fix provided: Data fix has been promoted to update update allegation as Physical Abuse from backend, based on the SDM screen allegation is Physical Abuse
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: No
Reason why no related code fix: Data fix 
*/
update investigationallegation set allegationid ='627b574e-aa98-48c1-98c3-cf6f5d155eff', updatedby = 'CJAMS-68036',  updatedon =now()
where investigationallegationid ='cc14c1c3-8194-47a1-8a82-987eb22524bd';