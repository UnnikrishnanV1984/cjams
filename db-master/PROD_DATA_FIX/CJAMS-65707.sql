/*
Issue Description: Please do a data fix to update the subsidy enddate to 2026-01-31 and delete the subsidy record
Category/Module: Error
Root cause: user wants to update the subsidy end date and delete the subsidy record
Fix provided: DB queries to update subsidy end date and delete the subsidy record
Data/Code fix ticket#:CJAMS-65707
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/



update gapagreementrate set enddate='2026-01-31 00:00:00',
updatedby='CJAMS-65707',updatedon=now() where gapagreementrateid='9395b035-370d-4519-992c-ad46bdabfd34' and activeflag =1;

update gapratesrevision  set rateenddate='2026-01-31 00:00:00',
updatedby='CJAMS-65707',updatedon=now() where gaprateid='9395b035-370d-4519-992c-ad46bdabfd34' and activeflag =1;

update gapagreementrate set activeflag=0,
updatedby='CJAMS-65707',updatedon=now() where gapagreementrateid='748623db-7729-4b17-a4e4-e41dc1dfccd8' and activeflag =1;

update gapratesrevision  set activeflag=0,
updatedby='CJAMS-65707',updatedon=now() where gaprateid='748623db-7729-4b17-a4e4-e41dc1dfccd8' and activeflag =1;

update routing set activeflag=0,
updatedby='CJAMS-65707',updatedon=now() where objectid='748623db-7729-4b17-a4e4-e41dc1dfccd8' and routingid='1b6415b9-2e6e-471d-931e-ddf6373c60e6' and activeflag=1;