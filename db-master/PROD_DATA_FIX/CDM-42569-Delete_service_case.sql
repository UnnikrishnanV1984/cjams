/*
 * CDM-42569 - Delete Service Case
 * Service case # 231030150720. Please remove the service case as requested.
 * 
 */

 update servicecase
set activeflag=0, updatedby='CDM-42569', updatedon=now()
where servicecaseid='cae596f5-b9e5-43a1-b21d-0bf781dc69ec' and activeflag=1;

update servicecasedisposition
set activeflag=0, updatedby='CDM-42569', updatedon=now()
where servicecasedispositionid='f31f53f0-e185-41d9-a085-bba1877e9b06' and activeflag=1;

update servicecaserequest
set activeflag=0, updatedby='CDM-42569', updatedon=now()
where servicecaserequestid='c53e56f5-43da-471a-b913-52b1d5ab5867' and activeflag=1;

update routing
set activeflag=0, updatedby='CDM-42569', updatedon=now()
where routingid='e85db67b-63ed-422b-bca4-4c9955d0bac7' and activeflag=1;

update activity
set activeflag=0, updatedby='CDM-42569', updatedon=now()
where objectid='cae596f5-b9e5-43a1-b21d-0bf781dc69ec' and activeflag=1;

update activitytask
set activeflag=0, updatedby='CDM-42569', updatedon=now()
where activityid  
		in ( select activityid from activity where objectid  = 'cae596f5-b9e5-43a1-b21d-0bf781dc69ec' )
	and activeflag  = 1 ;




