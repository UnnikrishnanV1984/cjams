/*
-- Issue Description: 
	User requested to delete the record
   Code 7108 Hosptial Overstay Purchase Authorization request approval issue
-- Category/ Module: Service Purchase Authorization (Case Management) 
-- Root cause: Routing ToRoleId is CWCW
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TBD
*/

-- toroleid = 'FNSFW'
select  objectid, eventcode, routingstatustypeid, tosecurityusersid, fromroleid, toroleid, teamid, updatedby, updatedon
from    routing 
where   routingid = '6a1042be-dbed-4f43-b045-7b75bee6896b'
	    and activeflag = 1 ;

update  routing
set    	activeflag = 0,
	    updatedby = 'CDM-25734',
	    updatedon = now()
where   routingid = '6a1042be-dbed-4f43-b045-7b75bee6896b'
	    and activeflag = 1 ;

update 	tb_service_log 
set 	delete_sw = 'Y', update_ts= now()::character varying , update_user_id = 'CDM-25734'  
where 	service_log_id = '2054099';

update 	tb_service_purchase_authorization 
set 	delete_sw = 'Y', update_ts= now()::character varying , update_user_id = 'CDM-25734'  
where 	authorization_id = '1847763';