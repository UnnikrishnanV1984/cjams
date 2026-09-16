update placement 
set enddatetime ='2020-10-05 00:00:00', updatedon =now(), updatedby ='CDM-12101'
where placementid ='add8e81b-10c4-494e-a2b9-7575e3af3cdd';

update placementrevision 
set exitdate ='2020-10-05 00:00:00', updatedon =now(), updatedby ='CDM-12101'
where placementrevisionid in ('98bac6ba-ab2b-49f7-b628-7cfe9835b3ea','f85c4610-b8d2-4001-a6c2-e614765cd922');

update tb_placement_validation 
set update_ts =current_timestamp, update_user_id ='CDM-12101'
where placement_validation_id =1938362;