
/*
Issue:Remove the SEN Flag for the client  Semari MurrayPID#204016073
Add the following in the intake comments - "CJAMS Contact Support TicketS20240323062902. SSA program staff on 11/25/2024 approved SEN box unchecked for Semari Murray as newborn does not meet SEN criteria. Drug panel results received from the medical hospital, Upper Chesapeake Health, show negative tox results, and no other medical documentation indicates effects of prenatal substance exposure or FASD. Drug panel results are uploaded in the CJAMS Documents tab. "
Change the supervisor decision from Screen In to Screen out in the dropdown and update the submission history (Supervisor decision - Screen out, Status - Closed)
Delete the connected service case - 241030419625.
Category/Module: Error
Root cause:User flagged SEN  in error.
Fix provided: DB queries to remove SEN Flagged
Data/Code fix ticket#: CDM-42775
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--1.update person 
update person 
set senstatusflag = null, substanceexposednewbornflag = null, substanceexposednewbornsourceid = null, substanceexposednewbornsourcetypekey = null,
	substanceexposednewborntimetamp = null, substanceclasses = null, othersubstances = null, updatedby = 'CDM-42775', updatedon = now()
where cjamspid = '204016073' and activeflag = 1;

--2,3.Add the following in the intake comments
update intakesnapshot
set jsondata = jsonb_set(
	jsonb_set(
		jsonb_set(
			jsonb_set(
				jsonb_set(
					jsonb_set(
						jsonb_set(jsondata::jsonb, '{DAType,DATypeDetail,0,supComments}',
							'"CJAMS Contact Support TicketS20240323062902. SSA program staff on 11/25/2024 approved SEN box unchecked for Semari Murray as newborn does not meet SEN criteria. Drug panel results received from the medical hospital, Upper Chesapeake Health, show negative tox results, and no other medical documentation indicates effects of prenatal substance exposure or FASD. Drug panel results are uploaded in the CJAMS Documents tab. "', false
							), '{DAType,DATypeDetail,0,supDisposition}', '"ScreenOUT"', false
						), '{disposition,0,supComments}',
					'"CJAMS Contact Support TicketS20240323062902. SSA program staff on 11/25/2024 approved SEN box unchecked for Semari Murray as newborn does not meet SEN criteria. Drug panel results received from the medical hospital, Upper Chesapeake Health, show negative tox results, and no other medical documentation indicates effects of prenatal substance exposure or FASD. Drug panel results are uploaded in the CJAMS Documents tab. "', false
					),'{disposition,0,supDisposition}','"ScreenOUT"', false
				),'{intakeDATypeDetails,0,supComments}',
			'"CJAMS Contact Support TicketS20240323062902. SSA program staff on 11/25/2024 approved SEN box unchecked for Semari Murray as newborn does not meet SEN criteria. Drug panel results received from the medical hospital, Upper Chesapeake Health, show negative tox results, and no other medical documentation indicates effects of prenatal substance exposure or FASD. Drug panel results are uploaded in the CJAMS Documents tab. "', false
			), '{intakeDATypeDetails,0,supDisposition}','"ScreenOUT"', false
		),'{reviewstatus,commenttext}',
	'"CJAMS Contact Support TicketS20240323062902. SSA program staff on 11/25/2024 approved SEN box unchecked for Semari Murray as newborn does not meet SEN criteria. Drug panel results received from the medical hospital, Upper Chesapeake Health, show negative tox results, and no other medical documentation indicates effects of prenatal substance exposure or FASD. Drug panel results are uploaded in the CJAMS Documents tab. "', false
	), updatedby = 'CDM-42775', updatedon = now()
where intakesnapshotid = '514b586b-f399-4c0f-8451-cb4c30dbfe26' and activeflag = 1;

--3. Updating routing to screenout
update routing
set supervisordecision = 'screenout', routingstatustypeid = 8,
	updatedby = '3904820f-3991-4ff4-821b-ee98aee48470', updatedon = now()
where routingid = 'd3c6a7c0-a1ee-49b5-abee-07c6d2d07914' and activeflag = 1;

--4.Delete the connected service case - 241030419625/intakeservicerequest
update intakeservicerequest
set servicecaseid = null, updatedby = 'CDM-42775', updatedon = now()
where intakeserviceid = 'ff1dfab0-fd9c-4022-9139-0778d3979ad9' and activeflag =1; 

--4.Delete the connected service case - 241030419625/servicecase
update servicecase
set updatedby = 'CDM-42775', updatedon = now(), activeflag = 0
where servicecaseid = 'f78f3af3-8295-40c1-ac05-e7331b2b4fcd' and activeflag = 1;