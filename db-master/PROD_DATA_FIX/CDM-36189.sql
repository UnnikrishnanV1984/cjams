/*
 * CDM-36189 - Disposition review
 * Customer Email ID:alicia.snoots@maryland.gov
 * Customer Name:Alicia Snoots
 * Data fix: Please remove the record from Approval inbox -->Case Pending Approval
 * Case ID - 231021281746
 * Note: we provided the data fix to close the case , but still the record is showing in the pending approval inbox.
 * -- objectid b5a49238-7cc9-47a3-afe3-449b574447ba  
 */
   
select distinct routingid,* from routing where objectid = 'b5a49238-7cc9-47a3-afe3-449b574447ba' and activeflag=1;

update routing 
set  updatedby = 'CDM-36189', updatedon = now(), activeflag = 0 
where  routingid in (
	'7d15b69b-b088-4979-878c-01a48628884c'); 
	