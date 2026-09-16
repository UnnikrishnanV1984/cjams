update intakeservreqchildremoval
set activeflag =0, updatedon =now(), updatedby ='CDM-7506'
where intakeservreqchildremovalid ='336f7f2a-c99b-47b4-9758-e3404939670a';

update placement 
set startdatetime ='2020-09-02'::date, updatedon =now(), updatedby ='CDM-7506'
where placementid ='3491fd0c-84b9-4f2d-b740-9838640224b4';

update tb_placement_validation
set update_ts =current_timestamp, update_user_id ='CDM-7506'
where placement_validation_id =1942631;