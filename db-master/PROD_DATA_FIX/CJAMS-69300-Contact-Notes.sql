/*
Issue: CJAMS-69300
Category/Module: Contact Notes
Root cause:Case ID - 3181268 / Contact ID: 16414631 - Needs to change from Received to Initiated
           Case ID - 2020025802995 - Contact ID: 16414844
           Case ID - 201903220791 /  Contact ID: 16414309
Fix provided:  Data fix is done as the part of this ticket to correct the data for contact id.
Regression Impacts: N/A
Is Code fix Required?: Yes
Code fix ticket#: NA
Reason why no related code fix: N/A
*/

update cjams.progressnote 
	set initiationindicator = true,
		updatedon = now(),
		updatedby = 'CJAMS-69300'
	where witsid = 16414631 and activeflag = 1;


    
update cjams.progressnote 
	set initiationindicator = true,
		updatedon = now(),
		updatedby = 'CJAMS-69300'
	where witsid = 16414844 and activeflag = 1;


    
update cjams.progressnote 
	set initiationindicator = true,
		updatedon = now(),
		updatedby = 'CJAMS-69300'
	where witsid = 16414309 and activeflag = 1;