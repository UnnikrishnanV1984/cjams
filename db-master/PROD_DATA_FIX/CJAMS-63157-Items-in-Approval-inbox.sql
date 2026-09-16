/*
  Issue Description:  here are five items that are not being deleted from my approval inbox. The items have been approved already, but continue to stay on my inbox.
   Category/ Module  : service log  
   Root cause: User Request, user request to remove the approved YTP record from the pending dashboard.
   Pull request# for code fix: 
   Reason why no related code fix:NA 
*/

/*
 * 221030015948 - 3 records
select routingstatustypeid,* from routing where objectid ='94bf65cf-d25f-4cb0-97f1-1a2e224781f5' and activeflag = 1
and eventcode = 'YTP' and routingstatustypeid = 15;
*/

update routing
set activeflag = 0,
	updatedby = 'CJAMS-63157',
	updatedon = now()
where routingid in ('2746891e-7905-4582-bcec-3a95e8cdcd1c',
'3d01cd27-e384-400b-96d2-a13d9fcfb5d3',
'9d57c860-de45-4a97-991a-f4170dfc0a8b')
and activeflag = 1;


-- PA: 3767855 and case : 211030010524 
update tb_service_purchase_authorization
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CJAMS-63157'
where authorization_id = 3767855
	and delete_sw = 'N';

update routing
set activeflag = 0,
	updatedby = 'CJAMS-63157',
	updatedon = now()
where objectid = '3767855'
and activeflag = 1;

/*
 * 211030011378
select * from routing where objectid = '202ad7f4-64e4-4348-af1d-d6d0d7f7da46'
and eventcode = 'YTP' and routingstatustypeid = 15  and activeflag = 1;
*/

update routing
set activeflag = 0,
	updatedby = 'CJAMS-63157',
	updatedon = now()
where routingid = 'b0b81bf2-77c4-4e2b-a158-12ff7dfc9eaf'
and activeflag = 1;