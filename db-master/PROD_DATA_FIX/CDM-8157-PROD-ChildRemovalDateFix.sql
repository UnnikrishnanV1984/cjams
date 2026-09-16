update intakeservreqchildremoval
set removaldate ='2020-11-22 00:00:00', removaltime ='2020-11-22 09:00:00', updatedon =now(), updatedby ='CDM-8157'
where intakeservreqchildremovalid ='688bd285-1fab-40b2-9b11-672f08b5b0cd';

update placement 
set startdatetime ='2020-11-22 09:00:00', starttime ='09:00', enddatetime ='2020-12-03 21:00:00', updatedon =now(), updatedby ='CDM-8157'
where placementid ='b3208601-0d67-4e54-9f48-460cf5552697';

update tb_placement_validation 
set update_ts = current_timestamp, update_user_id ='CDM-8157'
where placement_id =1559652;