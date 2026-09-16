/*
Issue Description: CJAMS-58722: Closing MA only adoption case
Category/Module: Adoption subsidy
Root cause: Migrated chessie adoption case needs data fix as follows
            Adoption Case ID: 3213560
            Client ID: 3378414
            Agreement Start Date: 4/16/2012
            Agreement End Date: 7/1/2024
Fix provided: Data fix has been done to update the Adoption subsidy rates and make it approved
Regression Impacts: N/A
Data/Code fix ticket#: CJAMS-58722
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Migration issue and correction is needed as a data fix for the issue.
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/



update adoptioncaseagreementrate
set startdate='2012-04-16 00:00:00.000',
    enddate = '2024-07-01 00:00:00.000',
    status = 'Approved',
    approvaldate =now(),
    updatedby = 'CJAMS-58722',
    updatedon = now()
where adoptionagreementrateid ='f0cb362a-02b1-4a98-b09b-4a8e6093c272' and activeflag=1;


update adoptioncaseagreementrevision
set activeflag= 0,
    updatedby = 'CJAMS-57822',
    updatedon = now()
where adoptioncaseagreementid = 'fc4f4f0a-1cec-4edd-887e-dd296c2faa0b' and
      adoptioncaseagreementrevisionid = '534ea5e6-6fd0-4f65-be89-197f9b155549'
      and activeflag = 1;