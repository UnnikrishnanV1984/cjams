/*
 * CDM-39410 - Need Assistance with D365
 * Customer Email ID:lequita.preston@maryland.gov
 * Need data fix on the purchase auth approval.
 * Case ID: 231030185592
 * Client ID: 200897820
 * Provider ID: 5006872
 * Auth ID: 3023691
 * 
 */

--select activeflag, routingstatustypeid, remarks,  * from routing 
--where objectid = '3023691' and eventcode  in ( 'PCAUTHR', 'PCAUTH' )
--order by insertedon desc;

UPDATE cjams.routing
SET activeflag=1, updatedby='CDM-39410', updatedon=now() 
WHERE routingid='7c422098-a202-4efb-b1c9-c58c2529914c';
