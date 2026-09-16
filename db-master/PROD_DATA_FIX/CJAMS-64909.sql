/*
Issue: CJAMS-64909
Category/Module: Contact Notes
Root cause: Worker clicked received instead of initiated, need to correct 'Contact was Initiated/Received' field
Fix provided:  Data fix is done as the part of this ticket to correct the data for contact id 15805299 of case 3172256.
Regression Impacts: N/A
Is Code fix Required?: Yes
Code fix ticket#: NA
Reason why no related code fix: N/A
*/

update cjams.progressnote 
	set initiationindicator = true,
		updatedon = now(),
		updatedby = 'CJAMS-64909'
	where progressnoteid = 'dab831f8-8d6c-4197-ab5b-9f38ee5337e8';