/*
   Issue Description: CDM-39485 Remove incorrect living arrangment
                      3288225:Living Arrangement from 8/16/2021 to 7/29/2022 is a duplicate entry. There is already a TFC placement with CPA Home entered for that time period. Please delete this Living Arrangement.
   Category/ Module  : Living Arrangement (Case Management) 
   Root cause: Please do a data fix to remove the highlighted Living Arrangement below as requested.
               Client ID: 3108579 (TALAYAH LAZENBY)
               Living Arrangement: Foster Care - Home
   Fix Provided : Data fix has been promoted to delete the living arrangeement for TALAYAH LAZENBY from  8/16/2021 to 7/29/2022 as it is a duplicate entry.
   Pull request# for code fix:  N/A
   Reason why no related code fix: N/A
   Status of the code fix if already submitted and expected prod fix date: N/A
   Backup before update/ delete: N/A
*/

UPDATE livingarrangement 
SET activeflag = 0,
   updatedby = 'CDM-39485', 
   updatedon = now()
WHERE placementid ='61b90070-1383-4c8a-9186-5a74a14fa1f3' and activeflag =1;

UPDATE placement 
SET activeflag = 0,
	updatedby = 'CDM-39485',
	updatedon = now()
WHERE
 placementid ='61b90070-1383-4c8a-9186-5a74a14fa1f3' and activeflag =1;

UPDATE
    cjams.placementrevision
SET
    activeflag = 0,
    updatedby = 'CDM-39485',
    updatedon = now()
WHERE
    placementid = '61b90070-1383-4c8a-9186-5a74a14fa1f3'
    and activeflag = 1;

UPDATE
    cjams.routing
SET
    activeflag = 0,
    updatedby = 'CDM-39485',
    updatedon = now()
where
    objectid = '61b90070-1383-4c8a-9186-5a74a14fa1f3'
    and activeflag = 1;