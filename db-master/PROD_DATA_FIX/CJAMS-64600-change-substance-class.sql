/*
Issue: CJAMS-64600 Cannot Add Household Child to the Case.
Category/Module: Person
Root cause: Data Entry error and substance class is not entered for the 
            Client ID: 200662311 (Maddox Gray Howard)
            Case ID: 2021012607720
            Data fix needed to update Baby - Methadone and Baby - Cocaine as substance class for the Client ID: 200662311 (Maddox Gray Howard).
Fix provided:Data fix has been done to update Baby - Methadone and Baby - Cocaine as substance class for the Client ID: 200662311 (Maddox Gray Howard).  
Data/Code fix ticket#: CJAMS-64600
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data entry error
*/

update person
set substanceclasses = '["BCOC","BMTD"]',
	updatedby = 'CJAMS-64600', 
	updatedon = now()
where cjamspid = '200662311'
and   personid = '43805415-a5f8-4195-a7d7-28b7049c4fdf'
	and activeflag = 1;