/*
Issue Description: Please remove the client from the person tab and make sure the case will not display on the person case prior history.
Category/Module: Error
Root cause: Charles Thompson PID 203970828 was added to the wrong service case
Fix provided: DB queries to remove said person from the service case
Data/Code fix ticket#:CDM-41349
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Deactivating client from actor
update actor
set activeflag = 0, updatedby = 'CDM-41349', updatedon = now()
where actorid = '231189d5-5a6a-4adc-aa26-a418e5fc4817' and activeflag = 1;

--Deactivating client from intakeservicerequestactor
update intakeservicerequestactor
set activeflag = 0, updatedby = 'CDM-41349', updatedon = now()
where intakeservicerequestactorid = 'e15c39bf-2e30-45e0-9346-4a537eefc52b' and activeflag = 1;

--Deactivating client from actorrelationship
update actorrelationship
set activeflag = 0, updatedby = 'CDM-41349', updatedon = now()
where actorrelationshipid = '67fe4e5b-4969-4e73-a568-1702fee50ded' and activeflag = 1;

--Deactivating client from personrole
update personrole
set activeflag = 0, updatedby = 'CDM-41349', updatedon = now()
where personroleid = 'cc958d9d-1f7a-4ac2-b3f7-e2b0db55a148' and activeflag = 1;

--Deactivating client from personprogramarea
update personprogramarea
set activeflag = 0, updatedby = 'CDM-41349', updatedon = now()
where personprogramid = '34cecc0e-2bd0-429e-b8c5-570365695aa1' and activeflag = 1;

--Resetting audit logs so prior case info isn't shown
update personauditlog
set personjson = (
	jsonb_set(
		jsonb_set(
			jsonb_set(
				jsonb_set(
					jsonb_set(
						jsonb_set(
							jsonb_set(
								jsonb_set(personjson::jsonb, '{roles}', '[""]'::jsonb),
								'{objectid}', '""'::jsonb),
							'{objecttype}', '""'::jsonb),
						'{personRole,0,roletype}', '""'::jsonb),
					'{caseInfo,objectType}', '""'::jsonb),
				'{caseInfo,objectNumber}', '""'::jsonb),
			'{intakenumber}', '""'::jsonb),
		'{servicecaseid}', '""'::jsonb)::json
	),
	updatedby = 'CDM-41349', updatedon = now()
where personid = 'a89e2813-8053-410d-9910-78d3418ea725' and activeflag = 1;