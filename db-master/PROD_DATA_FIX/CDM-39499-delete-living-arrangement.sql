/*
   Issue Description: CDM-39499 Get rid of living arrangement
                      3215342:Caseworker at the time entered the 9/20/2021-8/31/2022 living arrangement incorrectly. Please remove this line. There is an overlapping placement with Leigh Tstottles that covers this timeframe.
   Category/ Module  : Living Arrangement (Case Management) 
   Root cause: Please do a data fix to remove the highlighted Living Arrangement below as requested.
               Client ID: 3308728 (TESSA MARION SEEBO)
               Living Arrangement: Foster Care - Home
   Fix Provided : Data fix has been promoted to delete the living arrangement dated 9/20/2021-8/31/2022 for the client 3308728 (TESSA MARION SEEBO)
   Pull request# for code fix:  N/A
   Reason why no related code fix: N/A
   Status of the code fix if already submitted and expected prod fix date: N/A
   Backup before update/ delete: N/A
*/

UPDATE livingarrangement 
SET activeflag = 0,
   updatedby = 'CDM-39499', 
   updatedon = now()
WHERE placementid ='e523cc2f-27ff-4654-8eb5-46d16f1e06ff' and activeflag =1;

UPDATE placement 
SET activeflag = 0,
	updatedby = 'CDM-39499',
	updatedon = now()
WHERE
 placementid ='e523cc2f-27ff-4654-8eb5-46d16f1e06ff' and activeflag =1;

UPDATE
    cjams.placementrevision
SET
    activeflag = 0,
    updatedby = 'CDM-39499',
    updatedon = now()
WHERE
    placementid = 'e523cc2f-27ff-4654-8eb5-46d16f1e06ff'
    and activeflag = 1;

UPDATE
    cjams.routing
SET
    activeflag = 0,
    updatedby = 'CDM-39499',
    updatedon = now()
where
    objectid = 'e523cc2f-27ff-4654-8eb5-46d16f1e06ff'
    and activeflag = 1;