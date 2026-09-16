/*
 * CDM-32959 - Service Plan - Incomplete Approval
 * Customer Email ID:katherine.slavin1@maryland.gov
 * Customer Name:Katherine Slavin
 * Focus Area:Service Plan
 * Description - 3284786:Service plan unable to resend for approval and does not reflect approval. 
 * Screen URL: https://cw.cjams.mdthink.maryland.gov/#/pages/case-worker/9c308b7a-42ac-4fdd-9670-45aa64b52a2b/3284786/dsds-action/service-plan/sc-gc
 * The Service Plan status is pending but this service plan is not available under the supervisor pending approval to be approved. 
 */

--SELECT    DISTINCT r.servicerequestnumber
--, r.insertedon  assignedon
--, r.remarks
--, r.fromsecurityusersid
--, r.eventcode
--,r.objectid
--, r.entityid, routingstatustypeid 
--FROM ROUTING R 
--WHERE R.tosecurityusersid = '330d12cd-f428-41b9-b332-36e53fe5f16a'
--AND routingstatustypeid in(15,39)
--AND R.activeflag =1
--AND R.eventcode NOT IN ('ASST')
--and R.servicerequestnumber = '3284786';
--
--select * from routingstatustype where sequencenumber = 39;

UPDATE cjams.routing
SET routingstatustypeid=15, fromsecurityusersid='d8d2196c-7b3b-434b-8160-1c6eb29eed6e', fromroleid='CW' 
WHERE servicerequestnumber='3284786' and 
objectid='9c308b7a-42ac-4fdd-9670-45aa64b52a2b' and 
routingid='68f9ba08-8c7f-48ee-877e-ace586a6025b';