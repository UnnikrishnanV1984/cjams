update placement 
set 
startdatetime = '2021-03-23 00:00:00',
updatedon = now(),
updatedby = 'CDM-13943'
where placementid = 'b491954a-9d3c-4448-94a0-0e4c66da79bd';

update tb_placement_validation 
set 
update_ts = now(),
update_user_id = 'CDM-13943'
where placement_validation_id = '1956643';

update placementrevision 
set 
entrydate = '2021-03-23 00:00:00',
updatedon = now(),
updatedby = 'CDM-13943'
where placementid = 'b491954a-9d3c-4448-94a0-0e4c66da79bd';