/*
   Issue Description: CDM-18439
   Category/ Module  : change placement end date
   Root cause: user requeseted to change placement end date
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update placement 
set enddatetime = '2021-11-14 00:00:00', 
	updatedby = 'CDM-19843', 
	updatedon = now()
where placementid = '518cf7a0-fefe-4189-855c-19ce508907bd';

update placementrevision 
set exitdate = '2021-11-14 00:00:00', 
	updatedby = 'CDM-19843', 
	updatedon = now() 
where placementrevisionid = 'cdbd050c-8648-452c-a533-85db3c8dc8ae';

update placement 
set enddatetime = '2021-11-18 00:00:00', 
	updatedby = 'CDM-19843', 
	updatedon = now() 
where placementid = '320ba6a6-6b97-46cb-9c89-2738d7cc1519';

update placementrevision 
set exitdate = '2021-11-18 00:00:00', 
	updatedby = 'CDM-19843', 
	updatedon = now() 
where placementid = '320ba6a6-6b97-46cb-9c89-2738d7cc1519'
	and placementrevisionid in (	'8b4fe422-4780-459d-a611-6dd300121f0c',
									'9f494e34-9a6a-4170-9b79-e035ddc81178'
								);

update tb_placement_validation 
set placement_exit_dt = '2021-11-18',
	update_ts=now(),
	update_user_id='CDM-19843' 
where placement_id='1568189';

