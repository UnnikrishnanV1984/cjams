/*
 * CDM-33009 - Assistance required for administrative screen out
 * Customer Email ID:carmen.phelps@maryland.gov
 * Customer Name:Carmen Phelps
 * Focus Area:Decision
 * Description - 231020571621:Case screened in - in error - by after hours covering supervisor and placed on Program Manager's "tree". 
 * Assistance required with conducting an administrative override Screen URL: 
 * https://cw.cjams.mdthink.maryland.gov/#/pages/case-worker/cfbe47fa-cad0-4a95-b0c6-288bd2eb96e0/231020571621/dsds-action/cw-assignments
 * Change the status in submission history to Closed. Intake # I231010638085
 * 
 */

select routingstatustypeid, * from routing where objectid = 'I231010638085';  	

UPDATE cjams.routing
SET routingstatustypeid=8, updatedby='e8379a8c-fc16-4073-8cb7-90c54d395eb4', updatedon=now()  
WHERE routingid in ('998d90da-c42a-44f5-af7e-a199e8edeb06'); 