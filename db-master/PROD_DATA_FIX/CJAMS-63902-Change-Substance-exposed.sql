
/*
Issue: CJAMS-63902 change name
Category/Module: Person Profile
Root cause: The client is having a SEN history with a blank substance class which is not editable. User is unable to change the child's name to adoptive name due to this.
            Data fix is needed to add the substance class as Baby - Cocaine and Baby - Marijuana 
            Case ID: 251040607458
            Client ID: 204368024 (DYLAN Jackson)
Fix provided:  Data fix has been done to add the substance class as Baby - Cocaine and Baby - Marijuana 
Data/Code fix ticket#: CJAMS-63902
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: This is as per system design and data fix is needed to update the SEN information for the child.
*/

update person
set substanceclasses = '["BCOC","BMJA"]',
	updatedby = 'CJAMS-63902', 
	updatedon = now()
where cjamspid = '204368024'
	and activeflag = 1;