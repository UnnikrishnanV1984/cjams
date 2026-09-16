
update cjams.tb_picklist_values set value_tx ='Adult Detention Center', description_tx ='Adult Detention Center', update_user_id  ='CIDM-9160', update_ts = now()
where picklist_type_id =453 and picklist_value_cd ='4534';

update cjams.tb_picklist_values set value_tx ='DJS Juvenile Detention Center', description_tx ='DJS Juvenile Detention Center', update_user_id  ='CIDM-9160', update_ts = now()
where picklist_type_id =453 and picklist_value_cd ='4535';



DELETE FROM cjams.tb_picklist_values
WHERE picklist_type_id=453 AND picklist_value_cd in('4538','4539', '4540','4541','4542','4543','4544','4545');


INSERT INTO cjams.tb_picklist_values (picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx, mdmcode)
VALUES('4538', 453, 'Diagnostic Evaluation Treatment Program', 'Diagnostic Evaluation Treatment Program', 'Y', 0, now(), 'CIDM-9160', now(), 'CIDM-9160', 'N', NULL, NULL);


INSERT INTO cjams.tb_picklist_values (picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx, mdmcode)
VALUES('4539', 453, 'Psychiatric/Mental Health Facility', 'Psychiatric/Mental Health Facility', 'Y', 0, now(), 'CIDM-9160', now(), 'CIDM-9160', 'N', NULL, NULL);


INSERT INTO cjams.tb_picklist_values (picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx, mdmcode)
VALUES('4540', 453, 'Independent Living Program', 'Independent Living Program', 'Y', 0, now(), 'CIDM-9160', now(), 'CIDM-9160', 'N', NULL, NULL);


INSERT INTO cjams.tb_picklist_values (picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx, mdmcode)
VALUES('4541', 453, 'Relative/Fictive Kin', 'Relative/Fictive Kin', 'Y', 0, now(), 'CIDM-9160', now(), 'CIDM-9160', 'N', NULL, NULL);


INSERT INTO cjams.tb_picklist_values (picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx, mdmcode)
VALUES('4542', 453, 'Parent/Legal Guardian', 'Parent/Legal Guardian', 'Y', 0, now(), 'CIDM-9160', now(), 'CIDM-9160', 'N', NULL, NULL);


INSERT INTO cjams.tb_picklist_values (picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx, mdmcode)
VALUES('4543', 453, 'Foster Home', 'Foster Home', 'Y', 0, now(), 'CIDM-9160', now(), 'CIDM-9160', 'N', NULL, NULL);



INSERT INTO cjams.tb_picklist_values (picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx, mdmcode)
VALUES('4544', 453, 'Treatment Foster Care', 'Treatment Foster Care', 'Y', 0, now(), 'CIDM-9160', now(), 'CIDM-9160', 'N', NULL, NULL);



INSERT INTO cjams.tb_picklist_values (picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx, mdmcode)
VALUES('4545', 453, 'Other ', 'Other', 'Y', 0, now(), 'CIDM-9160', now(), 'CIDM-9160', 'N', NULL, NULL);


update cjams.tb_picklist_values set delete_sw  = 'Y',active_sw ='N', update_user_id  ='CIDM-9160', update_ts = now()
where picklist_type_id =453 and picklist_value_cd in('4533','4537', '4536');
