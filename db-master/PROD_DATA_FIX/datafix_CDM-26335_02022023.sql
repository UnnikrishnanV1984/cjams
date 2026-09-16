-- CDM-26335 - In CJAMS user have two accounts. Merge them in CJAMS.
/*
-- Issue Description:

   Old login # angelesa.blackwell@maryland.gov
   New login # angelesa.blackwell1@maryland.gov
   
   Dashboard:Hello, In CJAMS i have two accounts. Is it possible to merge them so that I am listed once in CJAMS.
*/

select * from routing where tosecurityusersid='2f5db488-b4b2-4445-be6c-5fa9879672db' and routingstatustypeid = 15 and activeflag = 1;

update routing
set tosecurityusersid = '231ea491-1d2d-4050-a48f-5d3b844ce2c7',
	updatedby = 'CDM-26335',
	updatedon = now()
where tosecurityusersid = '2f5db488-b4b2-4445-be6c-5fa9879672db' and routingstatustypeid = 15 and activeflag = 1;

select * from routing where tosecurityusersid='2f5db488-b4b2-4445-be6c-5fa9879672db' and routingstatustypeid = 1 and activeflag = 1;

update routing
set tosecurityusersid = '231ea491-1d2d-4050-a48f-5d3b844ce2c7',
	updatedby = 'CDM-26335',
	updatedon = now()
where tosecurityusersid = '2f5db488-b4b2-4445-be6c-5fa9879672db' and routingstatustypeid = 1 and activeflag = 1;