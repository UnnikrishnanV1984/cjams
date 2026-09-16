/*
   Issue Description: CDM-24999
   Category/ Module  :  Approval inbox 
   Root cause: Approval records  
   Pull request# for code fix: 
   Reason why no related code fix: checked the proc changes everything is good seems to be it's a glitch
*/



update cjams.routing set activeflag =0, updatedon =now(), updatedby='CDM-24999' where routingid in ('f44835b3-f997-4314-a2e1-ec244c3eb2bb','d226fcd3-5b74-4fad-bf82-66d616cff80c');



INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('eb3052d0-c5e6-4d6d-b1a1-ee3506e602f0', 'CHRR', '17c19204-05ca-4a76-9140-c3cad9b41dca', '1e60bdbb-6d9e-430a-9877-3311e0ef0bd1', '70c5f926-488c-44ec-a363-29ab1c8bf749', 'CWCW', 'CWSP', '110e650d-78fa-4387-8d4f-1380e9bef730', 16, 1, '17c19204-05ca-4a76-9140-c3cad9b41dca', '2022-09-09 11:27:17.186', 'CDM-24999', now(), true, 'Child Removal Submitted for review', NULL, 'Child Removal Submitted for review', '221030018333', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);


INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('2999fe8d-d71e-49d3-ae41-04c451ef9465', 'CHRR', '17c19204-05ca-4a76-9140-c3cad9b41dca', '1e60bdbb-6d9e-430a-9877-3311e0ef0bd1', '70c5f926-488c-44ec-a363-29ab1c8bf749', 'CWCW', 'CWSP', '4f6b34aa-47b6-4713-b34d-b384a69637c9', 16, 1, '17c19204-05ca-4a76-9140-c3cad9b41dca', '2022-09-09 11:21:40.271', 'CDM-24999', now(), true, 'Child Removal Submitted for review', NULL, 'Child Removal Submitted for review', '221030018333', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);


INSERT INTO cjams.tb_client_eligibility 
            (start_dt, 
             end_dt, 
             eligibility_type_cd, 
             eligibility_status_cd, 
             client_id, 
             removal_id, 
             create_user_id, 
             update_user_id, 
             delete_sw, 
             adoption_id, 
             case_id, 
             data_valid_sw, 
             client_merge_id, 
             guardian_subsidy_id, 
             transactionid, 
             create_ts, 
             update_ts)   
		SELECT isrcr.removaldate::date,
			isrcr.returndate::Date,  
			'2931', 
			'2909', 
			(select p.cjamspid from person p where p.personid = isrcr.personid ), 
			'254615',
			isrcr.insertedby,
			isrcr.updatedby, 
			'N',
			0,
			case when isrcr.servicecaseid is not null then --'yes' else 'no' end 
				(select servicecasenumber::int8
					from servicecase 
				 where servicecaseid = isrcr.servicecaseid 
				 order by insertedon 
				 desc limit 1
				 )
			else 
				(select CASE WHEN substring(servicerequestnumber,1,2) = 'CW' THEN 
							substring(servicerequestnumber,3) 
						ELSE 
							servicerequestnumber 
						END::int8 
				from intakeservicerequest  
				where intakeserviceid = isrcr.intakeserviceid 
				order by insertedon desc 
				limit 1
				)
			 end as a,
			 null,
			 null,
			 null,
			 null,
			 now(),
			 now()
 		FROM cjams.intakeservreqchildremoval isrcr 
		where isrcr.intakeservreqchildremovalid = '110e650d-78fa-4387-8d4f-1380e9bef730'; 


		  INSERT INTO cjams.tb_client_eligibility 
            (start_dt, 
             end_dt, 
             eligibility_type_cd, 
             eligibility_status_cd, 
             client_id, 
             removal_id, 
             create_user_id, 
             update_user_id, 
             delete_sw, 
             adoption_id, 
             case_id, 
             data_valid_sw, 
             client_merge_id, 
             guardian_subsidy_id, 
             transactionid, 
             create_ts, 
             update_ts)   
		SELECT isrcr.removaldate::date,
			isrcr.returndate::Date,  
			'2931', 
			'2909', 
			(select p.cjamspid from person p where p.personid = isrcr.personid ), 
			'254614',
			isrcr.insertedby,
			isrcr.updatedby, 
			'N',
			0,
			case when isrcr.servicecaseid is not null then --'yes' else 'no' end 
				(select servicecasenumber::int8
					from servicecase 
				 where servicecaseid = isrcr.servicecaseid 
				 order by insertedon 
				 desc limit 1
				 )
			else 
				(select CASE WHEN substring(servicerequestnumber,1,2) = 'CW' THEN 
							substring(servicerequestnumber,3) 
						ELSE 
							servicerequestnumber 
						END::int8 
				from intakeservicerequest  
				where intakeserviceid = isrcr.intakeserviceid 
				order by insertedon desc 
				limit 1
				)
			 end as a,
			 null,
			 null,
			 null,
			 null,
			 now(),
			 now()
 		FROM cjams.intakeservreqchildremoval isrcr 
		where isrcr.intakeservreqchildremovalid = '4f6b34aa-47b6-4713-b34d-b384a69637c9'; 