/*

   Issue Description: CDM-39805-Placement-error
    Delete livivng arrrangeemnt for the period 8/18/22 to 8/30/22 
    Client ID: 200010953 (rae'ne walker)

   Category/ Module  :  placement 

   Root cause:User wants to delete livivng arrrangeemnt for the period 8/18/22 to 8/30/22 

   Fix provided :

   Code fix ticket#:

   Reason why no related code fix: 

   Status of the code fix if already submitted and expected prod fix date: 

   Backup before update/ delete:

*/
UPDATE livingarrangement 
SET activeflag = 0,
   updatedby = 'CDM-39805', 
   updatedon = now()
WHERE placementid ='ec07063f-b0cd-45f1-8286-ceab1557b8e2' and activeflag =1;

UPDATE placement 
SET activeflag = 0,
	updatedby = 'CDM-39805',
	updatedon = now()
WHERE
 placementid ='ec07063f-b0cd-45f1-8286-ceab1557b8e2' and activeflag =1;

UPDATE
    cjams.placementrevision
SET
    activeflag = 0,
    updatedby = 'CDM-39805',
    updatedon = now()
WHERE
    placementid = 'ec07063f-b0cd-45f1-8286-ceab1557b8e2'
    and activeflag = 1;

UPDATE
    cjams.routing
SET
    activeflag = 0,
    updatedby = 'CDM-39805',
    updatedon = now()
where
    objectid = 'ec07063f-b0cd-45f1-8286-ceab1557b8e2'
    and activeflag = 1;
