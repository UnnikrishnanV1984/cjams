/*
 * CDM-34866 - bug
 * Customer Email ID:angelesa.blackwell1@maryland.gov
 * Customer Name:Angelesa Blackwell
 * Focus Area:Assessments: Other
 * Description - 221020268884:The below is added to my tree however, I am unsure why. CJAMS will not allow me to review decline or approved. 
 * Had a call with worker, the following highlighted record should be deleted from the Approval inbox.
 * 
*/

select * from routing where objectid = 'e8ab2c2d-16a0-44c9-b2e3-540939fecc96' and activeflag = 1;
update cjams.routing set activeflag=0, updatedby='CDM-34866' ,updatedon=now() where routingid='c6b2f6d7-6458-4d20-a97a-83b369bcfc9d';
