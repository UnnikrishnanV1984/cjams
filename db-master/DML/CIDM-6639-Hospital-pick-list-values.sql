
 

    delete from cjams.tb_picklist_values where picklist_type_id=450 and picklist_value_cd in ('4501','4502','4503','4504','4505');


    INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('4501', 450, 'Unable to return to previous caregiver or placement provider', 'Unable to return to previous caregiver or placement provider', 'Y', 0, now(), 'cadmin', now(), 'cadmin', 'N', NULL)on conflict do nothing;
  
  
  INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('4502', 450, 'Lack of available provider', 'Lack of available provider', 'Y', 0, now(), 'CIDM-6693', now(), 'cadmin', 'N', NULL)on conflict do nothing;
  
  
  INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('4503', 450, 'Waitlist for identified placement provider', 'Waitlist for identified placement provider', 'Y', 0, now(), 'CIDM-6693', now(), 'cadmin', 'N', NULL)on conflict do nothing;


  INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('4504', 450, 'Parent/Caregiver training needs', 'Parent/Caregiver training needs', 'Y', 0, now(), 'CIDM-6693', now(), 'cadmin', 'N',  NULL)on conflict do nothing;

  
  
  INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('4505', 450, 'Denials by providers', 'Denials by providers', 'Y', 0, now(), 'cadmin', now(), 'cadmin', 'N', NULL)on conflict do nothing;
  
  





  
  
    delete from cjams.tb_picklist_values where picklist_type_id=452 and picklist_value_cd in ('4520','4521','4524','4522','4523','4525','4526','4527','4528','4529');


  INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('4520', 452, 'level of acuity', 'level of acuity', 'Y', 0, now(), 'CIDM-6693', now(), 'CIDM-6693', 'N', NULL)on conflict do nothing;
  
  INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('4521', 452, 'Other', 'Other', 'Y', 0, now(), 'cadmin', now(), 'cadmin', 'N', NULL)on conflict do nothing;

  INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('4524', 452, 'Medical complexity', 'Medical complexity', 'Y', 0, now(), 'CIDM-6693', now(), 'CIDM-6693', 'N', NULL)on conflict do nothing;
  

  INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('4522', 452, 'Self-harm', 'Self-harm', 'Y', 0, now(), 'CIDM-6693', now(), 'CIDM-6693', 'N', NULL)on conflict do nothing;

  INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('4523', 452, 'aggression towards staff', 'aggression towards staff', 'Y', 0, now(), 'CIDM-6693', now(), 'CIDM-6693', 'N', NULL)on conflict do nothing;


  INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('4525', 452, 'property destruction', 'property destruction', 'Y', 0, now(), 'CIDM-6693', now(), 'CIDM-6693', 'N', NULL)on conflict do nothing;


  INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('4526', 452, 'sexualized behaviors', 'sexualized behaviors', 'Y', 0, now(), 'CIDM-6693', now(), 'CIDM-6693', 'N', NULL)on conflict do nothing;


INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('4527', 452, 'history of firesetting', 'history of firesetting', 'Y', 0, now(), 'CIDM-6693', now(), 'CIDM-6693', 'N', NULL)on conflict do nothing;


INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('4528', 452, 'Autism diagnosis', 'Autism diagnosis', 'Y', 0, now(), 'CIDM-6693', now(), 'CIDM-6693', 'N', NULL)on conflict do nothing;



INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('4529', 452, 'intellectual disability/developmental disability', 'intellectual disability/developmental disability', 'Y', 0, now(), 'CIDM-6693', now(), 'CIDM-6693', 'N', NULL)on conflict do nothing;
  
  





    delete from cjams.tb_picklist_values where picklist_type_id=453 and picklist_value_cd in ('4531','4532','4533','4534','4535','4536','4537');

    INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('4531', 453, 'Community', 'Community', 'Y', 0, now(), 'CIDM-6693', now(), 'CIDM-6693', 'N', NULL)on conflict do nothing;

  
    INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('4532', 453, 'Group home', 'Group home', 'Y', 0, now(), 'CIDM-6693', now(), 'CIDM-6693', 'N', NULL)on conflict do nothing;



    INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('4533', 453, 'DETP', 'DETP', 'Y', 0, now(), 'CIDM-6693', now(), 'CIDM-6693', 'N', NULL)on conflict do nothing;



    INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('4534', 453, 'Adult Det Ctr', 'Adult Det Ctr', 'Y', 0, now(), 'CIDM-6693', now(), 'CIDM-6693', 'N', NULL)on conflict do nothing;


    INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('4535', 453, 'DJS Juven Det Ctr', 'DJS Juven Det Ctr', 'Y', 0, now(), 'CIDM-6693', now(), 'CIDM-6693', 'N', NULL)on conflict do nothing;

    INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('4536', 453, 'Psychiatric hosp ', 'Psychiatric hosp', 'Y', 0, now(), 'CIDM-6693', now(), 'CIDM-6693', 'N', NULL)on conflict do nothing;

    INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('4537', 453, 'ILP', 'ILP', 'Y', 0, now(), 'CIDM-6693', now(), 'CIDM-6693', 'N', NULL)on conflict do nothing;

  




  
    delete from cjams.tb_picklist_values where picklist_type_id=454 and picklist_value_cd in ('4541','4542','4543','4544','4545');


  INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('4541', 454, 'Medically Fragile', 'Medically Fragile', 'Y', 0, now(), 'CIDM-6693', now(), 'CIDM-6693', 'N', NULL)on conflict do nothing;

    INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('4542', 454, 'DDA, Therapeutic, Group', 'DDA, Therapeutic, Group', 'Y', 0, now(), 'CIDM-6693', now(), 'CIDM-6693', 'N', NULL)on conflict do nothing;

    INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('4543', 454, 'RTC', 'RTC', 'Y', 0, now(), 'CIDM-6693', now(), 'CIDM-6693', 'N', NULL)on conflict do nothing;
  
    INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('4544', 454, 'Treatment Foster Care', 'Treatment Foster Care', 'Y', 0, now(), 'CIDM-6693', now(), 'CIDM-6693', 'N', NULL)on conflict do nothing;

    INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('4545', 454, 'Reunification', 'Reunification', 'Y', 0, now(), 'CIDM-6693', now(), 'CIDM-6693', 'N', NULL)on conflict do nothing;







    delete from cjams.tb_picklist_values where picklist_type_id=310 and picklist_value_cd in ('10688','10689','10690','10691','10692','10693','10694','10695','10696','10697');


INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('10688', 310, 'Other', 'Other', 'Y', 0, now(), 'CIDM-6693', now(), 'CIDM-6693', 'N', NULL)on conflict do nothing;


INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('10689', 310, 'Aggression ', 'Aggression', 'Y', 0, now(), 'CIDM-6693', now(), 'CIDM-6693', 'N', NULL)on conflict do nothing;

INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('10690', 310, 'Behavioral ', 'Behavioral', 'Y', 0, now(), 'CIDM-6693', now(), 'CIDM-6693', 'N', NULL)on conflict do nothing;

INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('10691', 310, 'Behavioral/Medical ', 'Behavioral/Medical', 'Y', 0, now(), 'CIDM-6693', now(), 'CIDM-6693', 'N', NULL)on conflict do nothing;

INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('10692', 310, 'Fire Setting', 'Fire Setting', 'Y', 0, now(), 'CIDM-6693', now(), 'CIDM-6693', 'N', NULL)on conflict do nothing;

INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('10693', 310, 'Low IQ', 'Low IQ', 'Y', 0, now(), 'CIDM-6693', now(), 'CIDM-6693', 'N', NULL)on conflict do nothing;

INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('10694', 310, 'Medical', 'Medical', 'Y', 0, now(), 'CIDM-6693', now(), 'CIDM-6693', 'N', NULL)on conflict do nothing;


INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('10695', 310, 'Self Harming', 'Self Harming', 'Y', 0, now(), 'CIDM-6693', now(), 'CIDM-6693', 'N', NULL)on conflict do nothing;

INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('10696', 310, 'Sexualized Behaviors', 'Sexualized Behaviors', 'Y', 0, now(), 'CIDM-6693', now(), 'CIDM-6693', 'N', NULL)on conflict do nothing;








    delete from cjams.tb_picklist_values where picklist_type_id=230 and picklist_value_cd in ('32789','32790');

INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('32789', 230, 'Psychiatric', 'Psychiatric', 'Y', 0, now(), 'CIDM-6693', now(), 'CIDM-6693', 'N', NULL)on conflict do nothing;


INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('32790', 230, 'Medical', 'Medical', 'Y', 0, now(), 'CIDM-6693', now(), 'CIDM-6693', 'N', NULL)on conflict do nothing;



    delete from cjams.tb_picklist_values where picklist_type_id=280 and picklist_value_cd in ('1000','1001','1002','1003','1004');


	
	INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('1000', 280, 'Risk of or actual harm to self ', 'Risk of or actual harm to self', 'Y', 0, now(), 'CIDM-6693', now(), 'CIDM-6693', 'N', NULL)on conflict do nothing;
	
	

		INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('1001', 280, 'Other ', 'Other', 'Y', 0, now(), 'CIDM-6693', now(), 'CIDM-6693', 'N', NULL)on conflict do nothing;


		INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('1002', 280, 'Risk of or actual harm to others ', 'Risk of or actual harm to others', 'Y', 0, now(), 'CIDM-6693', now(), 'CIDM-6693', 'N', NULL)on conflict do nothing;
	
	
		INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('1003', 280, 'Diagnostic evaluation for presenting psychiatric/behavioral symptoms', 'Diagnostic evaluation for presenting psychiatric/behavioral symptoms', 'Y', 0, now(), 'CIDM-6693', now(), 'CIDM-6693', 'N', NULL)on conflict do nothing;



	INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('1004', 280, 'Medication trial/adjustment for known mental health diagnosis (stabilization)', 'Medication trial/adjustment for known mental health diagnosis (stabilization)', 'Y', 0, now(), 'CIDM-6693', now(), 'CIDM-6693', 'N', NULL)on conflict do nothing;



    delete from cjams.tb_picklist_values where picklist_type_id=310 and picklist_value_cd in (
      '1261', '1260', '1258', '1257', '1256', '1255', '1254', '1253', '1252', '1203', '1204', '1205', '1206', '1207', '1208', '1209'
        , '1210', '1211', '1212', '1213', '1214', '1215', '1216', '1217', '1218', '1219', '1220', '1221', '1222', '1223', '1224', '1225', '1226', '1227', '1228', '1229', '1230', '1231', '1232', '1233', '1234', '1217', '1218', '1219', '1220'
        , '1221', '1222', '1223', '1224', '1225', '1226', '1227', '1228', '1229', '1230', '1231', '1232', '1233', '1234', '1235', '1236', '1237', '1238'
        , '1239', '1240', '1241', '1242', '1243', '1244', '1245', '1246', '1247', '1248', '1249', '1250', '1251'
    );




	
INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('1203', 310, 'Acute Care', 'Acute Care', 'Y', 0, now(), 'CIDM-6693', now(), 'CIDM-6693', 'N', NULL)on conflict do nothing;

	
INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('1204', 310, 'Allergic Reaction', 'Allergic Reaction', 'Y', 0, now(), 'CIDM-6693', now(), 'CIDM-6693', 'N', NULL)on conflict do nothing;

	
INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('1205', 310, 'Anemia', 'Anemia', 'Y', 0, now(), 'CIDM-6693', now(), 'CIDM-6693', 'N', NULL)on conflict do nothing;

	
INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('1206', 310, 'Appendicitis', 'Appendicitis', 'Y', 0, now(), 'CIDM-6693', now(), 'CIDM-6693', 'N', NULL)on conflict do nothing;

	
INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('1207', 310, 'Asthma', 'Asthma', 'Y', 0, now(), 'CIDM-6693', now(), 'CIDM-6693', 'N', NULL)on conflict do nothing;

	
INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('1208', 310, 'Back Problems', 'Back Problems', 'Y', 0, now(), 'CIDM-6693', now(), 'CIDM-6693', 'N', NULL)on conflict do nothing;

	
INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('1209', 310, 'Blood Disorder', 'Blood Disorder', 'Y', 0, now(), 'CIDM-6693', now(), 'CIDM-6693', 'N', NULL)on conflict do nothing;

	
INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('1210', 310, 'Broken Bone(s)', 'Broken Bone(s)', 'Y', 0, now(), 'CIDM-6693', now(), 'CIDM-6693', 'N', NULL)on conflict do nothing;
	
	
	INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('1210', 310, 'Bronchitis', 'Bronchitis', 'Y', 0, now(), 'CIDM-6693', now(), 'CIDM-6693', 'N', NULL)on conflict do nothing;
	
	
	INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('1211', 310, 'Broken Bone(s)', 'Broken Bone(s)', 'Y', 0, now(), 'CIDM-6693', now(), 'CIDM-6693', 'N', NULL)on conflict do nothing;
	
INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('1212', 310, 'Burn Unit/Treatment', 'Burn Unit/Treatment', 'Y', 0, now(), 'CIDM-6693', now(), 'CIDM-6693', 'N', NULL)on conflict do nothing;
	
INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('1213', 310, 'Cardiac Problem', 'Cardiac Problem', 'Y', 0, now(), 'CIDM-6693', now(), 'CIDM-6693', 'N', NULL)on conflict do nothing;
	
INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('1214', 310, 'Childbirth', 'Childbirth', 'Y', 0, now(), 'CIDM-6693', now(), 'CIDM-6693', 'N', NULL)on conflict do nothing;
	
INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('1215', 310, 'Circulatory Disorder', 'Circulatory Disorder', 'Y', 0, now(), 'CIDM-6693', now(), 'CIDM-6693', 'N', NULL)on conflict do nothing;
	
INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('1216', 310, 'Congenital Abnormality', 'Congenital Abnormality', 'Y', 0, now(), 'CIDM-6693', now(), 'CIDM-6693', 'N', NULL)on conflict do nothing;
	
INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('1217', 310, 'Dehydration', 'Dehydration', 'Y', 0, now(), 'CIDM-6693', now(), 'CIDM-6693', 'N', NULL)on conflict do nothing;
	
INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('1218', 310, 'Diabetes', 'Diabetes', 'Y', 0, now(), 'CIDM-6693', now(), 'CIDM-6693', 'N', NULL)on conflict do nothing;
	
INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('1219', 310, 'Digestive Disorder', 'Digestive Disorder', 'Y', 0, now(), 'CIDM-6693', now(), 'CIDM-6693', 'N', NULL)on conflict do nothing;
	

INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('1220', 310, 'Ear Injury', 'Ear Injury', 'Y', 0, now(), 'CIDM-6693', now(), 'CIDM-6693', 'N', NULL)on conflict do nothing;
	
	
	
	
	
INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('1221', 310, 'Eye Injury', 'Ear Injury', 'Y', 0, now(), 'CIDM-6693', now(), 'CIDM-6693', 'N', NULL)on conflict do nothing;
	

INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('1222', 310, 'Endocrine Disorder', 'Endocrine Disorder', 'Y', 0, now(), 'CIDM-6693', now(), 'CIDM-6693', 'N', NULL)on conflict do nothing;
	

INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('1223', 310, 'Electrolyte Disorder', 'Electrolyte Disorder', 'Y', 0, now(), 'CIDM-6693', now(), 'CIDM-6693', 'N', NULL)on conflict do nothing;
	

INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('1224', 310, 'Epilepsy', 'Epilepsy', 'Y', 0, now(), 'CIDM-6693', now(), 'CIDM-6693', 'N', NULL)on conflict do nothing;
	

INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('1225', 310, 'Failure to Thrive', 'Failure to Thrive', 'Y', 0, now(), 'CIDM-6693', now(), 'CIDM-6693', 'N', NULL)on conflict do nothing;
	

INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('1226', 310, 'Female Reproductive Disorder', 'Female Reproductive Disorder', 'Y', 0, now(), 'CIDM-6693', now(), 'CIDM-6693', 'N', NULL)on conflict do nothing;
	

INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('1227', 310, 'Gynecological Condition', 'Gynecological Condition', 'Y', 0, now(), 'CIDM-6693', now(), 'CIDM-6693', 'N', NULL)on conflict do nothing;
	

INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('1228', 310, 'Hospice', 'Hospice', 'Y', 0, now(), 'CIDM-6693', now(), 'CIDM-6693', 'N', NULL)on conflict do nothing;
	

INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('1229', 310, 'Immunity Disorder', 'Immunity Disorder', 'Y', 0, now(), 'CIDM-6693', now(), 'CIDM-6693', 'N', NULL)on conflict do nothing;
	

INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('1230', 310, 'Infectious Disease', 'Infectious Disease', 'Y', 0, now(), 'CIDM-6693', now(), 'CIDM-6693', 'N', NULL)on conflict do nothing;
	
	
	
	
	
INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('1231', 310, 'Injury', 'Injury', 'Y', 0, now(), 'CIDM-6693', now(), 'CIDM-6693', 'N', NULL)on conflict do nothing;

INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('1232', 310, 'Intestinal Infection', 'Intestinal Infection', 'Y', 0, now(), 'CIDM-6693', now(), 'CIDM-6693', 'N', NULL)on conflict do nothing;

INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('1233', 310, 'Intracranial Hemorrhage', 'Intracranial Hemorrhage', 'Y', 0, now(), 'CIDM-6693', now(), 'CIDM-6693', 'N', NULL)on conflict do nothing;

INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('1234', 310, 'Intensive Care', 'Intensive Care', 'Y', 0, now(), 'CIDM-6693', now(), 'CIDM-6693', 'N', NULL)on conflict do nothing;


INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('1235', 310, 'Jaundice', 'Jaundice', 'Y', 0, now(), 'CIDM-6693', now(), 'CIDM-6693', 'N', NULL)on conflict do nothing;

INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('1236', 310, 'Kidney Disorder', 'Kidney Disorder', 'Y', 0, now(), 'CIDM-6693', now(), 'CIDM-6693', 'N', NULL)on conflict do nothing;

INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('1237', 310, 'Long Term Care', 'Long Term Care', 'Y', 0, now(), 'CIDM-6693', now(), 'CIDM-6693', 'N', NULL)on conflict do nothing;


INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('1238', 310, 'Maternity', 'Maternity', 'Y', 0, now(), 'CIDM-6693', now(), 'CIDM-6693', 'N', NULL)on conflict do nothing;

INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('1239', 310, 'Metabolic Disorder (NOS)', 'Metabolic Disorder (NOS)', 'Y', 0, now(), 'CIDM-6693', now(), 'CIDM-6693', 'N', NULL)on conflict do nothing;


INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('1240', 310, 'Musculoskeletal Disease', 'Musculoskeletal Disease', 'Y', 0, now(), 'CIDM-6693', now(), 'CIDM-6693', 'N', NULL)on conflict do nothing;


INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('1241', 310, 'Nervous System Disease', 'Nervous System Disease', 'Y', 0, now(), 'CIDM-6693', now(), 'CIDM-6693', 'N', NULL)on conflict do nothing;


INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('1242', 310, 'Nonspecific Chest Pain', 'Nonspecific Chest Pain', 'Y', 0, now(), 'CIDM-6693', now(), 'CIDM-6693', 'N', NULL)on conflict do nothing;


INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('1243', 310, 'Nutritional disorder', 'Nutritional disorder', 'Y', 0, now(), 'CIDM-6693', now(), 'CIDM-6693', 'N', NULL)on conflict do nothing;

INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('1244', 310, 'Oncology/Cancer Treatment', 'Oncology/Cancer Treatment', 'Y', 0, now(), 'CIDM-6693', now(), 'CIDM-6693', 'N', NULL)on conflict do nothing;

INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('1245', 310, 'Orthopedic', 'Orthopedic', 'Y', 0, now(), 'CIDM-6693', now(), 'CIDM-6693', 'N', NULL)on conflict do nothing;

INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('1246', 310, 'Overdose', 'Overdose', 'Y', 0, now(), 'CIDM-6693', now(), 'CIDM-6693', 'N', NULL)on conflict do nothing;

INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('1247', 310, 'Pancreas Disorder', 'Pancreas Disorder', 'Y', 0, now(), 'CIDM-6693', now(), 'CIDM-6693', 'N', NULL)on conflict do nothing;

INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('1248', 310, 'Parasitic Disease', 'Parasitic Disease', 'Y', 0, now(), 'CIDM-6693', now(), 'CIDM-6693', 'N', NULL)on conflict do nothing;

INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('1249', 310, 'Pneumonia', 'Pneumonia', 'Y', 0, now(), 'CIDM-6693', now(), 'CIDM-6693', 'N', NULL)on conflict do nothing;

INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('1250', 310, 'Poisoning', 'Poisoning', 'Y', 0, now(), 'CIDM-6693', now(), 'CIDM-6693', 'N', NULL)on conflict do nothing;

INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('1251', 310, 'Pregnancy', 'Pregnancy', 'Y', 0, now(), 'CIDM-6693', now(), 'CIDM-6693', 'N', NULL)on conflict do nothing;
	
	
	INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('1252', 310, 'Pulmonary (Lung) Disease', 'Pulmonary (Lung) Disease', 'Y', 0, now(), 'CIDM-6693', now(), 'CIDM-6693', 'N', NULL)on conflict do nothing;
	
INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('1253', 310, 'Physical Rehabilitation', 'Physical Rehabilitation', 'Y', 0, now(), 'CIDM-6693', now(), 'CIDM-6693', 'N', NULL)on conflict do nothing;
	

INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('1254', 310, 'Shaken Baby Syndrome', 'Shaken Baby Syndrome', 'Y', 0, now(), 'CIDM-6693', now(), 'CIDM-6693', 'N', NULL)on conflict do nothing;
	

INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('1255', 310, 'Sickle Cell Anemia', 'Sickle Cell Anemia', 'Y', 0, now(), 'CIDM-6693', now(), 'CIDM-6693', 'N', NULL)on conflict do nothing;
	

INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('1256', 310, 'Sleep Disorder Unit', 'Sleep Disorder Unit', 'Y', 0, now(), 'CIDM-6693', now(), 'CIDM-6693', 'N', NULL)on conflict do nothing;
	

INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('1257', 310, 'Skin Disease', 'Skin Disease', 'Y', 0, now(), 'CIDM-6693', now(), 'CIDM-6693', 'N', NULL)on conflict do nothing;
	

INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('1258', 310, 'Surgery', 'Surgery', 'Y', 0, now(), 'CIDM-6693', now(), 'CIDM-6693', 'N', NULL)on conflict do nothing;
	

INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('1259', 310, 'Upper Respiratory Infection', 'Upper Respiratory Infection', 'Y', 0, now(), 'CIDM-6693', now(), 'CIDM-6693', 'N', NULL)on conflict do nothing;
	

INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('1260', 310, 'Urinary Tract Infection', 'Urinary Tract Infection', 'Y', 0, now(), 'CIDM-6693', now(), 'CIDM-6693', 'N', NULL)on conflict do nothing;
	

INSERT INTO cjams.tb_picklist_values
(picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx)
VALUES('1261', 310, 'Viral Infection', 'Viral Infection', 'Y', 0, now(), 'CIDM-6693', now(), 'CIDM-6693', 'N', NULL)on conflict do nothing;
	
	
	

