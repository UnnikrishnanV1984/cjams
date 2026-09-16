/*
Issue: Persons
Category/Module: Persons
Root cause: User requested to update the client Previous Adoption Date as 02/07/2001 under the person profile.
Client ID#: 1723892 (LANEAH HELEN SHAW)
Fix provided: Data fix has been done to  to update the client Previous Adoption Date as 02/07/2001 under the person profile.
Client ID#: 1723892 (LANEAH HELEN SHAW)
Data/Code fix ticket#: CJAMS-61436
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update person set preadoptiondate = '2001-02-07 00:00:00.000',
updatedby = 'CJAMS-61436', updatedon = now()
where personid = 'bf886a6f-33b9-47aa-8c39-e256ab030768' and activeflag = 1;