/*
Issue:3259656:The worker who put in the initial GAP for this case should have end dated it 6/30/25. They end dated it for 2026 which is preventing me from putting in a new subsidy with the correct date as part of the annual review.
Root cause: User requet to updates GAP start and end dates.
Fix provided: DB queries  update enddate intakeservreqchildremoval tables
Data/Code fix ticket#: CJAMS-60669
Regression Impacts: N/A 
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error.
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update gapagreementrate
set enddate = '2025-06-30 04:00:00.000',updatedby  = 'CJAMS-60669',updatedon =now()
where gapagreementrateid = '26e8f344-7b75-41f4-90eb-6327580842f4' and activeflag =1;


update gapratesrevision
set  rateenddate = '2025-06-30 04:00:00.000',updatedby = 'CJAMS-60669',updatedon =now()
where gapratesrevisionid in ('5c20b04d-bbd3-42cc-803a-2e325b4aac65',
'bd7220a5-af36-4c0d-9997-10dc17b2330b')  and activeflag = 1;

update gapagreementrate 
set startdate = '2025-07-01 00:00:00.000', enddate = '2026-06-30 04:00:00.000',updatedby = 'CJAMS-60669',updatedon =now()
where gapagreementrateid = '3e25d785-059e-4e21-adbc-187d60f9b5c4' and activeflag =1;

update gapratesrevision
set ratestartdate = '2025-07-01 00:00:00.000', rateenddate = '2026-06-30 04:00:00.000',updatedby = 'CJAMS-60669',updatedon =now()
where gapratesrevisionid = 'f312b678-08da-4911-8122-d094d341c6e1' and activeflag = 1;

update gapratesrevision
set updatedby = 'CJAMS-60669',updatedon =now(),approvaldate=NOW()
 where gaprateid in ('3e25d785-059e-4e21-adbc-187d60f9b5c4','26e8f344-7b75-41f4-90eb-6327580842f4') and activeflag=1;


