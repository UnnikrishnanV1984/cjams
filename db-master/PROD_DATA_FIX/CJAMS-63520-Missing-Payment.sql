/*
Issue Description: Please carry out data fix to update the Negotiated Amount (Permanency Plan -> Subsidy Rate) as $887 against Case ID: 2020023102462 Client ID: 4471489 (KA'LEA DALE)
Root cause: The GAP Subsidy Rate dates were entered incorrectly during the previous approval, causing the system to calculate payments starting from the wrong month, which resulted in the August 2025 payment not generating.
Fix provided: DB queries  update gapagreementrate tables
Data/Code fix ticket#: CJAMS-63520
Regression Impacts: N/A 
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update gapagreementrate
set startdate ='2025-07-29 00:00:00' ,enddate ='2026-07-28 00:00:00',updatedby ='CJAMS-63520',updatedon =now()
where gapagreementrateid ='0cfb9cf2-0f43-4666-9eb7-4d395dd436ba' and activeflag=1;


update gapratesrevision
set ratestartdate ='2025-07-29 00:00:00' ,rateenddate ='2026-07-28 00:00:00',updatedby ='CJAMS-63520',updatedon =now(),approvaldate = now()
where gapratesrevisionid in ('73b9c030-0beb-4815-99da-25f697dd27b9',
'be08805e-89c2-4466-913b-336af37a707a') and activeflag=1;
