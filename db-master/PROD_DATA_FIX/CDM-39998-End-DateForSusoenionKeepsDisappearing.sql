/*
Issue Description: The suspension end of 4/26/24 was sent to my supervisor T. Boston several times. The request end date keeps disappearing even after it is approve. The payments will not generate for the new provider until this is complete.
Category/ Module : Bug
Root cause: User issue: When submitted  suspension is approved, but stil does not show as approved.
Fix provided: Yes, write Db query 
Code fix ticket#: CDM-39998
Reason why no related code fix: Status of the code fix  already submitted 
Status of the code fix if already submitted and expected prod fix date: 
void the rejected provider placement from backend
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Create a new record in routing
insert into routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, routeddescription, servicerequestnumber)
values (gen_random_uuid(), 'ADSR', 'c38b3a54-337e-4d4b-98f2-06c6c65cdfe7', 'c38b3a54-337e-4d4b-98f2-06c6c65cdfe7', 'c9ac2fa2-b9ab-4ca9-a85d-9e429506a95a', 'CWSP', 'CWSP',
(select adoptionsuspensionid from adoptioncasesuspension where adoptioncaseid = '4905e484-3cc8-4feb-beda-aa0d7eb21727' and activeflag = 1
	and transactiondate = '2024-07-03 16:15:22.000') :: character varying, 16, 1, 'CDM-39998', now(), 'CDM-39998', now(), true, 'Adoption Suspension Approved', '3225387');

--Update suspensionenddate in adoptioncasesuspension
update adoptioncasesuspension
set 
	suspensionenddate = '2024-04-26T08:00:00.000',
	updatedby = 'CDM-39998',
	updatedon = now()
where adoptionsuspensionid = '4d7399c2-786d-4e78-b751-e7af2c8d8fb1' and activeflag = 1;

--Update suspensiondate in adoptioncasesuspensionrevision
update adoptioncasesuspensionrevision 
set 
	suspensionenddate = '2024-04-26T08:00:00.000',
	updatedby = 'CDM-39998',
	updatedon = now()
where adoptionsuspensionid = '4d7399c2-786d-4e78-b751-e7af2c8d8fb1' and activeflag = 1;

--Deactivating the other review record from adoptioncasesuspension
update adoptioncasesuspension
set
	activeflag = 0,
	updatedby = 'CDM-39998',
	updatedon = now()
where adoptionsuspensionid = '3baf7688-199d-4738-899e-a0e157d154a9' and activeflag = 1;

--Deactivating the other review record from adoptionscasesuspensionrevision
update adoptioncasesuspensionrevision
set 
	activeflag = 0,
	updatedby = 'CDM-39998',
	updatedon = now()
where adoptionsuspensionid = '3baf7688-199d-4738-899e-a0e157d154a9' and activeflag = 1;