/*
Issue Description: CDM-44123: Suspension End Approval
Category/Module: Payments/ Adoption subsidy
Root cause: Data fix needed to delete the incorrect Adoption subsidy agreements and end date the Actual agreement to  2024-11-08 10:00:00.
            The previous supervisor who has approved the suspension is inactive and data fix is requested by the user to correct the records.
Fix provided: Data fix has been done to delete the incorrect Adoption subsidy agreements and end date the Actual agreement to  2024-11-08 10:00:00.
              Update was done for adoptioncasesuspension and adoptioncasesuspensionrevision.
Data/Code fix ticket#: CDM-44123
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User requested for a data fix as previous supervisor is inactive and not visible in the subsidy page.
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update adoptioncasesuspension
set suspensionenddate ='2024-11-08 10:00:00', approvaldate =now(), updatedon =now(), updatedby ='CDM-44123'
where adoptionsuspensionid ='28dc81e6-3970-4dfc-94a3-8aaaaa98be6b';

update adoptioncasesuspensionrevision
set suspensionenddate ='2024-11-08 10:00:00', approvaldate =now(), updatedon =now(), updatedby ='CDM-44123'
where adoptionsuspensionid ='28dc81e6-3970-4dfc-94a3-8aaaaa98be6b';

update adoptioncasesuspension
set activeflag = 0, updatedon =now(), updatedby ='CDM-44123'
where adoptionsuspensionid  in ('61dc3c92-52ba-466d-8eff-9ab731210de7','a7144dc8-6f2b-4bc6-856f-03bb2954b860','9f51c015-7290-4d7d-a445-09a371e9e701','89a18ede-0704-402d-9a6c-4e9baa7d9575')
and activeflag=1;

update adoptioncasesuspensionrevision
set activeflag = 0, updatedon =now(), updatedby ='CDM-44123'
where adoptionsuspensionid  in ('61dc3c92-52ba-466d-8eff-9ab731210de7','a7144dc8-6f2b-4bc6-856f-03bb2954b860','9f51c015-7290-4d7d-a445-09a371e9e701','89a18ede-0704-402d-9a6c-4e9baa7d9575')
and activeflag=1;

