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
where placementrevisionid in (
'ce874c07-658c-4f3a-8e8a-4fb4fe41dd3e',
'88a425fb-4b9e-4f91-b640-d2016b9ff686',
'b2572757-083a-4084-bd91-9a8b54c9e8c0',
'30c80677-1d82-4cb9-9488-0f5fe072cadd',
'f107fd0f-c4e4-442a-abcc-d1c959709ef5'
 ) and activeflag =1;

 /*where  placementid in(
'14d22aed-7ded-4395-ae2c-75a140e86c02',
'0fcba57c-ac10-4003-8eeb-e2c244c9e2f6',
'485c648b-e02f-4771-b0ee-7df93fa9d03d',
'8c6a7c7a-752c-4091-bb7a-b63b9564bf8e',
'2a5bbba3-f940-470c-8d81-f2765eb1edbe'
 )*/

 /*
 select servicecasenumber ,* from servicecase s where servicecaseid in (
select servicecaseid from placement p
where  placementid in(
'14d22aed-7ded-4395-ae2c-75a140e86c02',
'0fcba57c-ac10-4003-8eeb-e2c244c9e2f6',
'485c648b-e02f-4771-b0ee-7df93fa9d03d',
'8c6a7c7a-752c-4091-bb7a-b63b9564bf8e',
'2a5bbba3-f940-470c-8d81-f2765eb1edbe'
 ) );
*/

/*
221030017431
221030016036
3201884
221030017431
202105406171*/
  