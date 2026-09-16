/*
Issue Description: Need data fix for the start and end dates as per the screenshots shown
Category/Module: Error
Root cause: Users cannot save Traditional eligibility data in old plans after recent update
Fix provided: DB query to change start and end dates for serviceplan and actions
Code/Data fix ticket#: CDM-40592
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: CIDM-9172
Reason why no related code fix: Codefix already deployed
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Updating effective date in serviceplan record
update serviceplan
set effectivedate = '2022-06-13 04:00:00', targetenddate = '2024-11-29 05:00:00', updatedby = 'CDM-40592', updatedon = now()
where serviceplanid = '814fd56b-8ed1-4a96-bfb3-0598551d4762' and activeflag = 1;

--Updating dates in corresponding serviceplanaction records
update serviceplanaction
set startdate = '2022-06-13 04:00:00', enddate = '2024-11-29 05:00:00', updatedby = 'CDM-40592', updatedon = now()
where serviceplanactionid in ('777d86e1-d299-42d7-b338-2c9ba5c715fa', '103a44dc-63aa-489d-bf8f-c0237922c48e') and activeflag = 1;

update serviceplanaction
set startdate = '2022-06-13 04:00:00', enddate = '2024-11-29 05:00:00', updatedby = 'CDM-40592', updatedon = now()
where serviceplanactionid in ('faf52086-6bf6-490a-b1d7-ac5907c7aef2', '519b8dce-5bb8-4120-97c8-962b5d34c049') and activeflag = 1;