/*
    Issue Description: CDM-10191 TASHAY WILLIS
   Category/ Module  :  GAP
   Root cause: User wanted to update the end date
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
 Backup: enddate:2021-06-04 04:00:00
 */

update gapagreementrate set enddate='2021-07-03',updatedby='CDM-10191',updatedon=now() where gapagreementid='47e91d02-ef87-45c3-883a-84324c05e2f5'
and gapagreementrateid in ('faf158f3-38a0-4138-a489-d902ff2a2ef4');

update gapratesrevision set rateenddate='2021-07-03',updatedby='CDM-10191',updatedon=now() where gaprateid in ('faf158f3-38a0-4138-a489-d902ff2a2ef4');

update gapagreementrate set activeflag=0,updatedby='CDM-10191',updatedon=now() where gapagreementid='47e91d02-ef87-45c3-883a-84324c05e2f5'
and gapagreementrateid in ('e0f1860b-c2aa-4fe3-9fa7-304b2018d469');
update gapratesrevision set activeflag=0,updatedby='CDM-10191',updatedon=now() where gaprateid in ('e0f1860b-c2aa-4fe3-9fa7-304b2018d469');