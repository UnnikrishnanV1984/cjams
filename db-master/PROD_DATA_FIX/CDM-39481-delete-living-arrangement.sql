/*
   Issue Description: CDM-39481 Remove incorrect living arrangment
                      305446:The living arrangement for Mahogany Brown from 11-1-23 to 1-12-24 labeled as ICPC Foster Home - Incoming needs to be deleted. This was entered in error and the correct placement is in the system already.
   Category/ Module  : Living Arrangement (Case Management) 
   Root cause: Please do a data fix to remove the highlighted Living Arrangement below as requested.
               Client ID: 200140025 (Mahogany-Mocha Brown)
               Living Arrangement: ICPC Foster Home - Incoming
   Fix Provided : Data fix has been promoted to delete the living arrangeement for Mahogany Brown from 11-1-23 to 1-12-24 labled as ICPC Foster Home - Incoming
   Pull request# for code fix:  N/A
   Reason why no related code fix: N/A
   Status of the code fix if already submitted and expected prod fix date: N/A
   Backup before update/ delete: N/A
*/

UPDATE livingarrangement 
SET activeflag = 0,
   updatedby = 'CDM-39481', 
   updatedon = now()
WHERE placementid ='421b5cbc-640b-4225-b2c1-ac6ac240bfbb' and activeflag =1;

UPDATE placement 
SET activeflag = 0,
	updatedby = 'CDM-39481',
	updatedon = now()
WHERE
 placementid ='421b5cbc-640b-4225-b2c1-ac6ac240bfbb' and activeflag =1;

UPDATE
    cjams.placementrevision
SET
    activeflag = 0,
    updatedby = 'CDM-39481',
    updatedon = now()
WHERE
    placementid = '421b5cbc-640b-4225-b2c1-ac6ac240bfbb'
    and activeflag = 1;

UPDATE
    cjams.routing
SET
    activeflag = 0,
    updatedby = 'CDM-39481',
    updatedon = now()
where
    objectid = '421b5cbc-640b-4225-b2c1-ac6ac240bfbb'
    and activeflag = 1;