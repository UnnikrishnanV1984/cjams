/*
Issue: CJAMS-64134 Issue Adding Child to Case
Category/Module: Person Profile
Root cause: SEN substance class is blank on both (bio & adopted) client IDs so the adopted client can not be added/saved into new cases.
            Bio Client ID: 4460879 (Davian Javier Gross)
            Adopted Client ID: 202251701 (Davian Javier Creighton)
            Adoption Case: 231040230011 (assigned to Dorchester county)
            Data fix needed to update the substance class as Baby-Marijuana and Opiates for Client ID: 202251701 (Davian Javier Creighton)
Fix provided:  Data fix has been done to add the substance class as as Baby-Marijuana and Opiates for Client ID: 202251701 (Davian Javier Creighton).
Data/Code fix ticket#: CJAMS-64134
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: This is as per system design and data fix is needed to update the SEN information for the child.
*/

update person
set substanceclasses = '["OPIA","BMJA"]',
	updatedby = 'CJAMS-64134', 
	updatedon = now()
where cjamspid = '202251701'
and activeflag =1;