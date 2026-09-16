/*
Issue Description: Need data fix to cleanup the empty spaces in cisclientid.
Category/Module: CW CJAMS
Root cause: Existing data in old records (max insertedon, updatedon - 2023 records)
Fix provided: DB query to update the btrimmed values
Data/Code fix ticket#: CIDM-10196
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#:  N/A
Reason why no related code fix: Data Fix
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

UPDATE cjams.person
SET cisclientid = btrim(cisclientid)
WHERE cisclientid <> btrim(cisclientid) 
AND activeflag = 1
and cisclientid is not null
and btrim(cisclientid) <> '';