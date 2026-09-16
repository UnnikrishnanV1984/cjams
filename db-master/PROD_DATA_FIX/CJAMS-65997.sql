/*
Issue Description: Please do a data fix to delete the subsidy record
Category/Module: Error
Root cause: user wants to  delete the subsidy record
Fix provided: DB queries to delete the subsidy record
Data/Code fix ticket#:CJAMS-65997
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update gapagreementrate set activeflag=0,
updatedby='CJAMS-65997',updatedon=now() where gapagreementrateid='5ca9bd82-2c70-4174-84c1-fd5c84cd11ce' and activeflag =1;

update gapratesrevision  set activeflag=0,
updatedby='CJAMS-65997',updatedon=now() where gaprateid='5ca9bd82-2c70-4174-84c1-fd5c84cd11ce' and activeflag =1;

update routing set activeflag=0,
updatedby='CJAMS-65997',updatedon=now() where objectid='5ca9bd82-2c70-4174-84c1-fd5c84cd11ce'  and activeflag=1;