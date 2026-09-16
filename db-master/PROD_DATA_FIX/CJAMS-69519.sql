/*
Issue Description: CJAMS-69519 - Subsidy Rate
Category/Module: Adoption Subsidy Rate
Case ID: 3294571
Root cause: There are two subsidy rate records for the period 11/15/2024 to 11/14/2025. One is in Incomplete
   status and the other one was Rejected by the supervisor. Because of the Rejected record the user is not able
   to add the new rate for 11/15/2025 to 11/14/2026.
Fix provided: Data fix to remove the Rejected subsidy rate record for the period 11/15/2024 to 11/14/2025 as
   requested by the user, so the user can complete the rate and add the new one.
Regression Impacts: N/A
Is Code fix Required?: NO
Code fix ticket#: N/A
Reason why no related code fix: As requested by user
*/

update adoptioncaserevision
set activeflag = 0,
	updatedby = 'CJAMS-69519',
	updatedon = now()
where adoptionrevisionid = '19cc262a-c1f5-471a-9f22-2be21bf78871'
	and adoptionagreementid = '77c013bd-0dea-43de-af08-6054939437ba'
	and adoptionagreementrateid = '380b2050-185a-494e-89c8-d2af9d62c2c9'
	and activeflag = 1;

update routing
set activeflag = 0,
	updatedby = 'CJAMS-69519',
	updatedon = now()
where routingid = 'a969a5f0-6b6f-4fed-b00d-a277d9a77936'
	and objectid = '380b2050-185a-494e-89c8-d2af9d62c2c9'
	and eventcode = 'AARR'
	and activeflag = 1;
