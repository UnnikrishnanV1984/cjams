/*
Issue Description: Please do a data fix to update the GAP agreement start date as 08/09/2024
Category/Module: Error
Root cause: The most recent entry in intakeservreqcourtorder had the start date 08/28/2024
Fix provided: DB queries to update the start date
Data/Code fix ticket#: CDM-41340
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Updating start date in intakeservreqcourtorder
update intakeservreqcourtorder
set courtorderdate = '2024-08-09 04:00:00', updatedby = 'CDM-41340', updatedon = now()
where intakeservreqcourtorderid = '0c338756-3c37-48ad-a423-1bc8b39a91ab' and activeflag = 1;

--Updating start date in gapagreement
update gapagreement
set startdate = '2024-08-09 04:00:00', updatedby = 'CDM-41340', updatedon = now()
where gapid = 'bf386d92-1529-490e-ac1d-2a6808e0ec3b' and activeflag = 1;

--Updating start date in gapagreementrevision
update gapagreementrevision
set startdate = '2024-08-09 04:00:00', updatedby = 'CDM-41340', updatedon = now()
where gapid = 'bf386d92-1529-490e-ac1d-2a6808e0ec3b' and activeflag = 1;