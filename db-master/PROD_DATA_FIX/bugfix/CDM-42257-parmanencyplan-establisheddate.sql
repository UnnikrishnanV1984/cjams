/*
 * CDM-42257 - Deleted the record which was added accidentally by the user
 * Customer Email ID:erika.robinson@maryland.gov
 * Description - Permanency plan -  Requested record was deleted and removed the end date for latest record to make it as active/open
 * 
 */

update permanencyplan 
set activeflag = 0, updatedby='CDM-42257', updatedon=now()
where permanencyplanid = 'ede23c67-3539-477d-9bcb-e60d354e4cec';

update permanencyplan 
set enddate = null, updatedby='CDM-42257', updatedon=now()
where permanencyplanid = '7696af0f-8bba-4417-b266-d20d7626f795';

update permanencyplan_history 
set activeflag =0, updatedby='CDM-42257', updatedon=now()
where permanencyplanid = 'ede23c67-3539-477d-9bcb-e60d354e4cec' and activeflag =1;


update routing 
set activeflag =0, updatedby='CDM-42257', updatedon=now()
where objectid  = 'ede23c67-3539-477d-9bcb-e60d354e4cec' and activeflag =1;


update permanencyplan_history 
set activeflag =0, updatedby='CDM-42257', updatedon=now()
where permanencyplanid = '7696af0f-8bba-4417-b266-d20d7626f795' and activeflag =1;

update routing 
set activeflag = 1, updatedby='CDM-42257', updatedon=now()
where routingid  = 'c7259894-127b-4221-a7cc-2a85448c4808' and activeflag =0;