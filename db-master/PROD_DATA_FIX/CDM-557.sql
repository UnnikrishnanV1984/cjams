update tb_picklist_values
set picklist_value_cd = '1751'
where value_tx= 'Adoption' and  picklist_type_id = 147;

update permanencyplan
set  primaryarrangetype = 'APPADOPFLY', concurrentarrangetype = 'APPADOPFLY', projecteddate = '2019-12-10 00:00:00', updatedon = now(), updatedby = 'Datafix user as per CDM-557'
where permanencyplanid in ('d9a12564-93ac-4770-89fd-90cbf467eae9','a5407ad2-f00b-4921-aa1d-228a3cfc5dbd');

