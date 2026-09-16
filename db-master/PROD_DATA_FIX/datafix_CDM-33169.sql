/*
 * CDM-33169 - CLONE - Screen Out Assistance Required
 * Customer Email ID:carmen.phelps@maryland.gov
 * Customer Name:Carmen Phelps
 * Focus Area:Decision
 * Description - 231020608942:This case was screened in - in error - and placed on CPS Bureau Chief's tree by After Hours covering supervisor. 
 * Administrative Screen Out requested Screen URL: 
 * https://cw.cjams.mdthink.maryland.gov/#/pages/case-worker/3ca6c18d-a14b-4a21-9b28-a82ea643f4aa/231020608942/dsds-action/cw-assignments
 * Change the status in submission history to Closed. Intake # I231010679212
 */

select routingstatustypeid, * from routing where objectid = 'I231010679212';  	

UPDATE cjams.routing
SET routingstatustypeid=8, updatedby='acdceddb-659f-487c-a18c-bae2b5e10b90', updatedon=now()  
WHERE routingid='337151a0-06b6-4c05-9880-19fe89b1672a'; 