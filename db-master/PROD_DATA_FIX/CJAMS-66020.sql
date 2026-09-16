/*
Issue Description: Wrong Response Timer
Category/Module: Bug
Root cause:Requested to midify start date from 12/17/2025 to 02/23/2026 for Finley Lantz and Maisy Lantz
Fix provided: Data fix is done to modify the start date
Data/Code fix ticket#: CJAMS-66020
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Support 
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update gapagreement 
set startdate='2026-02-23 00:00:00',
updatedby='CJAMS-66020',updatedon=now()
where gapagreementid in ('0b85395c-0b13-4205-9c82-98553c3019c8','8e9a26d6-1f2e-4d8c-b738-3ca3a28925dc') and activeflag=1;

update gapagreementrevision 
set startdate='2026-02-23 00:00:00',
updatedby='CJAMS-66020',updatedon=now()
where gapagreementid in ('0b85395c-0b13-4205-9c82-98553c3019c8','8e9a26d6-1f2e-4d8c-b738-3ca3a28925dc') and activeflag=1;