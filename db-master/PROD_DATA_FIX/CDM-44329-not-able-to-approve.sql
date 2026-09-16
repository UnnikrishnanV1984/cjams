/*
 * CDM-44329 Unable to approve
 * Customer Email ID:christineb.whitworth@maryland.gov
 * Focus Area:O PLacement Approval
 * Description - Supervisor has attempted to approve the placement review. Once approved I recieve the successfully approved,
     but when I go back to my case pending approval's it is still there. 
 * data fix to update the exittypekey
 * Root cause: The exittypekey value was getting more than the defined type in db.
 * Code fix: CIDM-10219
 Note: After the code fix there is no issue but below were the data fix before the implementation of the codefix.
*/

update placementrevision 
set exittypekey  = 'CIPS',
updatedon = now(),
updatedby = 'CDM-44329'
where placementid = '14d22aed-7ded-4395-ae2c-75a140e86c02'
and activeflag =1;