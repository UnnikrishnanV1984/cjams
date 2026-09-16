/*
Issue Description: CJAMS-58107: Subsidy Payments Not Produced
Category/Module: Payments/ Adoption subsidy
Root cause: Subsidy payments are missing for 3183134 as adoption case end date was not updated as the part of agreement extension in the ticket CDM-43046
Fix provided: Data fix has been done to update the adoption case end date and also adoptionagreementrate table to trigger the adoption payments batch
              CJAMS-57995 adoptioncase enddate was also fixed as the part of this issue.
Data/Code fix ticket#: CJAMS-58107
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: This has occured due to updation missing in CDM-43046 and code fix should resolve it.
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update adoptioncase 
set enddate = '2027-08-26 00:00:00',
    updatedby = 'CJAMS-58017',
    updatedon = now()
where adoptioncaseid='7b253e47-7a88-41e2-86e4-5253d26dcd2a';


update adoptioncaseagreementrate
set updatedon = now(),
    updatedby = 'CJAMS-58017'
where adoptionagreementrateid = 'b13e764a-986e-4818-b9a0-f56c15165659';

update adoptioncase 
set enddate = '2028-02-06 00:00:00',
    updatedby = 'CJAMS-57995',
    updatedon = now()
where adoptioncaseid='534daa22-e18d-4368-a6f9-d93c3465b88c';

update adoptioncaseagreementrate
set updatedon = now(),
    updatedby = 'CJAMS-57995'
where adoptionagreementrateid = '2d669737-357e-4eb6-8a9a-96dd5b4d4977'
and activeflag = 1;