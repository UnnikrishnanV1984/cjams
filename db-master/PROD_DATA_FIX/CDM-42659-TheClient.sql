/*
Issue: Needs to do the Data fix for the Subsidy rate 07/23/2024  to 07/22/2025 - 902
Agreement start date in Production is correct - but needs to change in court order 07/23/2024 
Category/Module: Error
Root cause: Incorrect details were entered in the system
Fix provided: DB queries to enter the correct details from backend
Data/Code fix ticket#: CDM-42659
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Updating date in intakeservreqcourtorder
update intakeservreqcourtorder
set courtorderdate = '2024-07-23 00:00:00', updatedby = 'CDM-42659', updatedon = now()
where intakeservreqcourtorderid = '663d6839-1016-4591-87ab-1dcb5d6dcfb4' and activeflag = 1;

--Updating start date in gapagreement
update gapagreement
set startdate = '2024-07-23 00:00:00', updatedby = 'CDM-42659', updatedon = now()
where gapagreementid = '358197f6-f2f1-4830-af5a-214d4c4897a8' and activeflag = 1;

--Updating start date in gapagreementrevision
update gapagreementrevision
set startdate = '2024-07-23 00:00:00', approvaldate = now(), updatedby = 'CDM-42659', updatedon = now()
where gapagreementid = '358197f6-f2f1-4830-af5a-214d4c4897a8' and activeflag = 1;

--Updating subsidy rate and end date in gapagreementrate
update gapagreementrate
set paymentamout = 902, enddate = '2025-07-22 04:00:00', updatedby = 'CDM-42659', updatedon = now()
where gapagreementrateid = '82f60868-2116-49e0-8974-a8abd750797d' and activeflag = 1;

--Deactivating the other two records in gapagreementrate
update gapagreementrate
set activeflag = 0, updatedby = 'CDM-42659', updatedon = now()
where gapagreementrateid in ('cbaabc73-a6fe-42e5-83ec-5783f0ba0369', '84d007a4-fc3c-44e0-acb4-e0072303eacc');

--Updating subsidy rates in gapratesrevision
update gapratesrevision
set paymentamt = 902, rateenddate = '2025-07-22 04:00:00', approvaldate = now(), updatedby = 'CDM-42659', updatedon = now()
where gaprateid = '82f60868-2116-49e0-8974-a8abd750797d' and activeflag = 1;

--Deactivating the other two records in gapratesrevision
update gapratesrevision
set activeflag = 0, updatedby = 'CDM-42659', updatedon = now()
where gaprateid in ('cbaabc73-a6fe-42e5-83ec-5783f0ba0369', '84d007a4-fc3c-44e0-acb4-e0072303eacc');