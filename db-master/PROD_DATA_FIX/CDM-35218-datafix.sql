/*
 * CDM-35218 - Date to be corrected
 * Customer Email ID: tawa.mustapha@maryland.gov
 * Customer Name:Tawa Mustapha
 * Focus Area: Court: TPR
 * Description - 3307172:Completed Subsidy rates to navigate to creating breaking the link and it did not go through as message received indicated subsidy rates not created. 
 * Attempt to update if needed, another rate created to be edited/cancelled.
 * Screen URL: https://cw.cjams.mdthink.maryland.gov/#/pages/case-worker/4bb9c901-fefc-4f77-be49-a571efa171f7/3307172/dsds-action/sc-permanency-plan/placement/adoption/adoption-subsidy/rate
*/

update adoptionagreementraterevision set activeflag = 0, updatedby = 'CDM-35218', updatedon = now()
where  adoptionagreementid = '88db63ce-0949-4be7-be93-127f2b459d43' and adoptionagreementraterevisionid='d3d293e4-8574-46ef-b040-f49bf742a451'
and approvalstatustypekey is null and activeflag =1;