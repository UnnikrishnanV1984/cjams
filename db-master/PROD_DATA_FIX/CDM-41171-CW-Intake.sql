/*
Issue Description: Need to do a Data fix to add the following Narrative received from DSS after the intake was closed.
Category/Module: Error
Root cause: User received additional data after intake was closed
Fix provided: DB queries to add said additional data to the intake narrative
Data/Code fix ticket#:CDM-41171
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data issue
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Updating jsondata in intakedastaging
update intakedastaging
set jsondata = jsonb_set(jsondata, '{General, Narrative}',
	to_jsonb(jsondata->'General'->>'Narrative' || '<p><br></p><p>DJS response:</p><p><br></p><p>The Department received the CINS referral and placed the youth on informal supervision back in April. However, informal supervision was not good enough for the family. Ms. Whittington wanted Jamel out of the home and when she was informed that by Department that we could not take him out of the home she was no longer interested in informal supervision. Jamel was not willing to engage in informal supervision. I tried to get the family engaged. However, all Ms. Whittington was worried about was having me talk to her landlord to tell him the Department was working on getting him into long term placement so she could keep her housing. The Department has not received a Delinquent referral including MDOP (Destruction of Property) on neither one of Ms. Whittington"s children at this time.</p><p><br></p><p>Lakkisha N. Dryden</p><p><br></p><p>Case Management Specialist III, Community</p><p><br></p><p>Eastern Shore Region</p><p><br></p><p>Department of Juvenile Services</p>')
	),
	updatedby = 'CDM-41171', updatedon = now()
where intakenumber = 'I241013063407' and activeflag = 1;

--Updating jsondata in intakedastatus
update intakedastatus
set jsondata = jsonb_set(jsondata, '{General, Narrative}',
	to_jsonb(jsondata->'General'->>'Narrative' || '<p><br></p><p>DJS response:</p><p><br></p><p>The Department received the CINS referral and placed the youth on informal supervision back in April. However, informal supervision was not good enough for the family. Ms. Whittington wanted Jamel out of the home and when she was informed that by Department that we could not take him out of the home she was no longer interested in informal supervision. Jamel was not willing to engage in informal supervision. I tried to get the family engaged. However, all Ms. Whittington was worried about was having me talk to her landlord to tell him the Department was working on getting him into long term placement so she could keep her housing. The Department has not received a Delinquent referral including MDOP (Destruction of Property) on neither one of Ms. Whittington"s children at this time.</p><p><br></p><p>Lakkisha N. Dryden</p><p><br></p><p>Case Management Specialist III, Community</p><p><br></p><p>Eastern Shore Region</p><p><br></p><p>Department of Juvenile Services</p>')
	),
	updatedby = 'CDM-41171', updatedon = now()
where intakedastatusid = '8080226f-4602-4e62-9de4-3c5060de4f9f' and activeflag = 1;

--Updating jsondata in intakesnapshot
update intakesnapshot
set jsondata = jsonb_set(jsondata, '{General, Narrative}',
	to_jsonb(jsondata->'General'->>'Narrative' || '<p><br></p><p>DJS response:</p><p><br></p><p>The Department received the CINS referral and placed the youth on informal supervision back in April. However, informal supervision was not good enough for the family. Ms. Whittington wanted Jamel out of the home and when she was informed that by Department that we could not take him out of the home she was no longer interested in informal supervision. Jamel was not willing to engage in informal supervision. I tried to get the family engaged. However, all Ms. Whittington was worried about was having me talk to her landlord to tell him the Department was working on getting him into long term placement so she could keep her housing. The Department has not received a Delinquent referral including MDOP (Destruction of Property) on neither one of Ms. Whittington"s children at this time.</p><p><br></p><p>Lakkisha N. Dryden</p><p><br></p><p>Case Management Specialist III, Community</p><p><br></p><p>Eastern Shore Region</p><p><br></p><p>Department of Juvenile Services</p>')
	),
	updatedby = 'CDM-41171', updatedon = now()
where intakeserviceid = 'cd9c6ca3-6624-40d9-ba65-3a87cfd70e0c' and activeflag = 1;

--Updating narrative in intakeservicerequest
update intakeservicerequest
set narrative = narrative || '<p><br></p><p>DJS response:</p><p><br></p><p>The Department received the CINS referral and placed the youth on informal supervision back in April. However, informal supervision was not good enough for the family. Ms. Whittington wanted Jamel out of the home and when she was informed that by Department that we could not take him out of the home she was no longer interested in informal supervision. Jamel was not willing to engage in informal supervision. I tried to get the family engaged. However, all Ms. Whittington was worried about was having me talk to her landlord to tell him the Department was working on getting him into long term placement so she could keep her housing. The Department has not received a Delinquent referral including MDOP (Destruction of Property) on neither one of Ms. Whittington"s children at this time.</p><p><br></p><p>Lakkisha N. Dryden</p><p><br></p><p>Case Management Specialist III, Community</p><p><br></p><p>Eastern Shore Region</p><p><br></p><p>Department of Juvenile Services</p>',
	updatedby = 'CDM-41171', updatedon = now()
where intakeserviceid = 'cd9c6ca3-6624-40d9-ba65-3a87cfd70e0c' and activeflag = 1;