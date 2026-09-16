/*
Issue Description: Intake number I241012948633, does not let me continue with the referral after the first tab
Category/Module: Bug
Root cause: Active records in both intakedastaging and intakedastatus got corrupted
Fix provided: DB query to modify the jsondata in intakedastaging and intakedastatus
Code/Data fix ticket#: CDM-40833
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data issue, code is fine. 
Backup before update/ delete:Query:
*/

--Modifying jsondata in intakedastaging
update intakedastaging
set
	jsondata = jsonb_set(
	jsondata, '{General, intakeservice, 0, intakesubservice}', 
	'[{
		"activeflag": 1,
		"intakeservid": "34ed3645-252d-4b1f-8b40-c3387087fed4",
		"intakeservsubtypeid": "269ea9f0-55ad-4fa6-95e6-0c1b646cd5f0",
		"intakeservsubtypekey": "IFPS",
		"typedescription": "Interagency Family Preservation Services"
	}]'::jsonb),
	updatedby = 'CDM-40833', updatedon = now()
where jsondata -> 'General' -> 'intakeservice' -> 0 -> 'intakesubservice' is null and intakenumber = 'I241012948633' and activeflag = 1;