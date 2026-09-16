DROP FUNCTION IF EXISTS cjams.save_la_hospitalization(uuid, json, character varying,  integer);
CREATE OR REPLACE FUNCTION cjams.save_la_hospitalization(person_id uuid, healthpayload json , livingarrangementpayload json, livingid uuid, placementid uuid, insertedby character varying, isnew integer)
RETURNS character varying
 LANGUAGE plpgsql
AS $function$


--08/23/2024-Umasankar Raavi --CIDM-9160- Added new columns to the function (hospitalization_discharge_recommendation_others, actual_placement_after_discharge_others,Actual_Placement_After_Discharge )
--10/29/2024-Charan sai Bodapati--CIDM-9735- fixed migration data object id
--26/26/2025-Charan sai Bodapati--CIDM-10158- PersonHospitilization objectid fix
DECLARE 
        v_person_id uuid;
	    v_hospitalizationinfo json;
        v_livingarrangementjson json;
	    v_insertedby character varying;
	    v_updatedby character varying;
	    v_isnew integer;
	    response character varying;
        v_plcmentid uuid;
		v_livingarrangementid uuid;
		v_hospitalizationid uuid;
        flag record;
        v_updatedocumentproperties character varying;


BEGIN

        v_person_id := person_id;
	    v_hospitalizationinfo := healthpayload;
        v_livingarrangementjson := livingarrangementpayload;
        v_livingarrangementid := livingid;
        v_plcmentid := placementid;
        v_insertedby := insertedby;
	    v_isnew := isnew;
        response := 'sucess';
		v_hospitalizationid := v_hospitalizationinfo ->> 'hospitalizationid';
		if(v_livingarrangementid is null) then
				select la.livingid into v_livingarrangementid from livingarrangement la where la.placementid =v_plcmentid and activeflag =1;  
			end if;



        -- if(v_livingarrangementjson is not null) then

        --        v_plcmentid = gen_random_uuid();

        --      insert into placement (placementid, servicecaseid,intakeservreqchildremovalid,intakeservicerequestactorid,remarks, leastrestrictiveplacement, personid,startdatetime, enddatetime,placementtypekey,ischildplacedoutside,updatedby,insertedby, primaryrelationship) 
        --      values (v_plcmentid, (v_livingarrangementjson ->> 'servicecaseid')::uuid,(v_livingarrangementjson ->> 'intakeservreqchildremovalid')::uuid,(v_livingarrangementjson ->> 'intakeservicerequestactorid')::uuid,v_livingarrangementjson ->> 'remarks',v_livingarrangementjson ->> 'leastrestrictiveplacement',
        --      (v_livingarrangementjson ->> 'personid')::uuid,to_date(v_livingarrangementjson ->> 'startdate' , 'YYYY-MM-DD'), to_date(v_livingarrangementjson ->> 'enddate' , 'YYYY-MM-DD'),v_livingarrangementjson ->> 'placementtypekey',(v_livingarrangementjson ->> 'ischildplacedoutside')::boolean,v_insertedby::uuid, v_insertedby::uuid, v_livingarrangementjson ->> 'primaryrelationship');
            
        --      raise notice 'v_plcmentid%',v_plcmentid;

        --      v_livingarrangementid = gen_random_uuid();
        --      insert into livingarrangement (livingid, placementid ,livingarrangementtypekey, personid ,livingstartdate, livingenddate,primarycaregiver, secondarycaregiver, primaryrelationship, homephone, workphone, streetname, streettext ,cityname,countytypekey,statetypekey,
		-- 	 zip5no, country, whereabouts, tribalservicearea, insertedby,updatedby, objectid) 
        --      (select v_livingarrangementid,v_plcmentid,  v_livingarrangementjson ->> 'livingarrangementtypekey', (v_livingarrangementjson ->> 'personid')::uuid,to_date(v_livingarrangementjson ->> 'startdate' , 'YYYY-MM-DD'), to_date(v_livingarrangementjson ->> 'enddate' , 'YYYY-MM-DD'),
		-- 	 v_livingarrangementjson ->> 'primarycaregiver', v_livingarrangementjson ->> 'secondarycaregiver', v_livingarrangementjson ->> 'primaryrelationship', v_livingarrangementjson ->> 'contactphone', v_livingarrangementjson ->> 'workphone',
		-- 	 v_livingarrangementjson ->> 'add1', v_livingarrangementjson ->> 'add2', v_livingarrangementjson ->> 'cityname', v_livingarrangementjson ->> 'countytypekey', v_livingarrangementjson ->> 'statetypekey',(v_livingarrangementjson ->> 'zipcode')::int, v_livingarrangementjson ->> 'country', v_livingarrangementjson ->> 'whereabouts', v_livingarrangementjson ->> 'tribalservicearea', v_insertedby::uuid, v_insertedby::uuid, v_livingarrangementjson ->> 'hospitalizationid' );
            
		-- 	 raise notice 'v_livingarrangementid%',v_livingarrangementid;

        -- end if;

		
		if (v_hospitalizationinfo is not null ) then 
 

          if(v_hospitalizationid is null) then
 
           v_hospitalizationid = gen_random_uuid();
		   
		   update placementrevision pr set objectid = v_hospitalizationid, updatedon = now(), updatedby = v_insertedby where pr.placementid = v_plcmentid and pr.activeflag =1;

           	raise notice 'v_hospitalizationid%',v_hospitalizationid;
            insert into
				personhospitalization ( hospitalizationid, personid ,
					uploadpath,
					hospitalization_type,
					hospitalization_reason,
					hospitalization_discharge_recommendation_others,
                    actual_placement_after_discharge_others,
					startdt,
					enddt,
					starttime,
					endtime,
					diagnosistx,
					hospitalnm,
					hospital_address1,
					hospital_address2,
					hospital_phone,
					hospital_city,
					hospital_state,
					hospital_zipcode,
					insertedby,
					-- User who created this record
					insertedon,
					hasdischargeplan,
					dischargeplan,
					county,
					-- Record created date and time
					updatedby, 
					updatedon,
					hospital_erexamination,
                    hospital_erevaluation,
                    hospital_inpatientAdmission,
                    hospital_overstay,
                    hospital_transfer,
                    hospital_discharged,
                    hospital_examstartdate,
                    hospital_evaluatstartdate,
                    hospital_overstaydate,
                    hospital_transferdate,
                    hospital_inpatientadmissiondate,
                    hospital_dischargeddate,
                    hospital_dischargeplan,
                    reasoforfenialbyprovider,
                    hospital_dischargediagnoses,
                    hospital_transferredname,
                    hospital_unit,
                    hospital_roomnumber,
                    hospital_phonenumber,
                    hospital_addressline1,
                    hospital_addressline2,
                    hospital_cityname,
                    hospital_statename,
                    hospital_country,
                    hospital_zipcode1,
                    hospital_dischargerecommendation,
					Actual_Placement_After_Discharge,
                    hospital_reasonforovrstay,
                    hospital_denialsbyproviders,
                    hospital_lengthofoverstay,
                    hospital_grouphome,
					hospitalization_reasonForHospitalization_others,
					durationdays,
					medicalnecessitydays,
					hospital_room, 
					hospital_roomphoneno, 
                    objectid,
                    activeflag
				)
			values
				(	v_hospitalizationid, v_person_id,
					null,
					v_hospitalizationinfo ->> 'hospitalization_type',
					v_hospitalizationinfo ->> 'hospitalization_reason',
					v_hospitalizationinfo ->> 'hospitalization_discharge_recommendation_others',
					v_hospitalizationinfo ->> 'actual_placement_after_discharge_others',
					to_date(v_hospitalizationinfo ->> 'start_Date' , 'YYYY-MM-DD'),
					to_date(v_hospitalizationinfo ->> 'end_Date' , 'YYYY-MM-DD'),
					v_hospitalizationinfo ->> 'starttime',
					v_hospitalizationinfo ->> 'endtime',
					v_hospitalizationinfo ->> 'Reason_or_diagnosis',
					v_hospitalizationinfo ->> 'Hospital_name',
					v_hospitalizationinfo ->> 'Hospital_address1',
					v_hospitalizationinfo ->> 'Hospital_address2',
					v_hospitalizationinfo ->> 'Hospital_phone',
					v_hospitalizationinfo ->> 'Hospital_city',
					v_hospitalizationinfo ->> 'Hospital_state',
					v_hospitalizationinfo ->> 'Hospital_zipcode',
					v_insertedby::uuid,
					now(),
					(v_hospitalizationinfo ->> 'has_discharge_plan')::int,
					v_hospitalizationinfo ->> 'discharge_plan',
					v_hospitalizationinfo ->> 'county',
					v_insertedby::uuid,
					now(),
					(v_hospitalizationinfo ->> 'Hospital_ERexamination')::boolean,
					(v_hospitalizationinfo ->> 'Hospital_ERevaluation')::boolean,
					(v_hospitalizationinfo ->> 'Hospital_InpatientAdmission')::boolean,
					(v_hospitalizationinfo ->> 'Hospital_Overstay')::boolean,
					(v_hospitalizationinfo ->> 'Hospital_Transfer')::boolean,
					(v_hospitalizationinfo ->> 'Hospital_Discharged')::boolean,
					(v_hospitalizationinfo ->> 'Hospital_examStartDate')::timestamp,
					(v_hospitalizationinfo ->> 'Hospital_evaluatSartDate')::timestamp,
					(v_hospitalizationinfo ->> 'Hospital_OverstayDate')::timestamp,
					(v_hospitalizationinfo ->> 'Hospital_TransferDate')::timestamp,
					(v_hospitalizationinfo ->> 'Hospital_InpatientAdmissionDate')::timestamp,
					(v_hospitalizationinfo ->> 'Hospital_DischargedDate')::timestamp,
					v_hospitalizationinfo ->> 'Hospital_DischargePlan',
					v_hospitalizationinfo ->> 'ReasoForFenialByProvider',
					v_hospitalizationinfo ->> 'Hospital_DischargeDiagnoses',
					v_hospitalizationinfo ->> 'Hospital_TransferredName',
					v_hospitalizationinfo ->> 'Hospital_Unit',
					v_hospitalizationinfo ->> 'Hospital_RoomNumber',
					v_hospitalizationinfo ->> 'Hospital_PhoneNumber',
					v_hospitalizationinfo ->> 'hospital_addressline1',
					v_hospitalizationinfo ->> 'hospital_addressline2',
					v_hospitalizationinfo ->> 'hospital_cityname',
					v_hospitalizationinfo ->> 'hospital_statename',
					v_hospitalizationinfo ->> 'hospital_country',
					v_hospitalizationinfo ->> 'hospital_zipcode1',
					v_hospitalizationinfo ->> 'Hospital_DischargeRecommendation',
					v_hospitalizationinfo ->> 'Actual_Placement_After_Discharge',
					v_hospitalizationinfo ->> 'Hospital_ReasonForOvrStay',
					v_hospitalizationinfo ->> 'Hospital_DenialsByProviders',
					v_hospitalizationinfo ->> 'Hospital_LengthOfOverstay',
					v_hospitalizationinfo ->> 'Hospital_GroupHome',
					v_hospitalizationinfo ->> 'hospitalization_reasonForHospitalization_others',
					v_hospitalizationinfo ->> 'durationdays',
					v_hospitalizationinfo ->> 'medicalnecessitydays',
					v_hospitalizationinfo ->> 'hospital_room',
					v_hospitalizationinfo ->> 'hospital_roomphoneno',
                    v_livingarrangementid,
                    2
				) returning hospitalizationid into v_hospitalizationid ;


		else 

  
			update personhospitalization_history phsp
			set activeflag = 0,
				updatedby = v_insertedby::uuid, 
				updatedon = now()
			where phsp.personid = v_person_id 
				and phsp.hospitalizationid = (v_hospitalizationinfo ->> 'hospitalizationid'):: uuid and activeflag = 1;
	

				  UPDATE cjams.personhospitalization
                  SET startdt=to_date(v_hospitalizationinfo ->> 'start_Date' , 'YYYY-MM-DD'), enddt=to_date(v_hospitalizationinfo ->> 'end_Date' , 'YYYY-MM-DD'),
				  starttime = v_hospitalizationinfo ->> 'starttime', endtime=v_hospitalizationinfo ->> 'endtime', diagnosistx=v_hospitalizationinfo ->> 'Reason_or_diagnosis',
				  updatedby = v_insertedby::uuid, updatedon=now(), activeflag=2, 
				  hospitalnm = v_hospitalizationinfo ->> 'Hospital_name',
				  uploadpath=NULL, hospital_address1=v_hospitalizationinfo ->> 'Hospital_address1', hospital_address2=v_hospitalizationinfo ->> 'Hospital_address2', 
				  hospital_phone=v_hospitalizationinfo ->> 'Hospital_phone', hospital_city=v_hospitalizationinfo ->> 'Hospital_city',
				  hospitalization_type=v_hospitalizationinfo ->> 'hospitalization_type', hospitalization_reason=v_hospitalizationinfo ->> 'hospitalization_reason',
				  	hospitalization_discharge_recommendation_others =v_hospitalizationinfo ->>'hospitalization_discharge_recommendation_others', 				  
				  actual_placement_after_discharge_others =v_hospitalizationinfo ->>'actual_placement_after_discharge_others', 
				  hospital_state=v_hospitalizationinfo ->> 'Hospital_state', 
				  hospital_zipcode=v_hospitalizationinfo ->> 'Hospital_zipcode', hasdischargeplan=(v_hospitalizationinfo ->> 'has_discharge_plan')::int, dischargeplan=v_hospitalizationinfo ->> 'discharge_plan', 
				  county=v_hospitalizationinfo ->> 'county', 
				  hospital_erexamination=(v_hospitalizationinfo ->> 'Hospital_ERexamination')::boolean, hospital_erevaluation=(v_hospitalizationinfo ->> 'Hospital_ERevaluation')::boolean, hospital_inpatientadmission=(v_hospitalizationinfo ->> 'Hospital_InpatientAdmission')::boolean,
				  hospital_overstay=(v_hospitalizationinfo ->> 'Hospital_Overstay')::boolean, hospital_transfer=(v_hospitalizationinfo ->> 'Hospital_Transfer')::boolean,
                  hospital_discharged=(v_hospitalizationinfo ->> 'Hospital_Discharged')::boolean, hospital_examstartdate=(v_hospitalizationinfo ->> 'Hospital_examStartDate')::timestamp, 
				  hospital_evaluatstartdate=(v_hospitalizationinfo ->> 'Hospital_evaluatSartDate')::timestamp, hospital_overstaydate=(v_hospitalizationinfo ->> 'Hospital_OverstayDate')::timestamp,
				  hospital_transferdate=(v_hospitalizationinfo ->> 'Hospital_TransferDate')::timestamp, 
				  hospital_inpatientadmissiondate=(v_hospitalizationinfo ->> 'Hospital_InpatientAdmissionDate')::timestamp, hospital_dischargeddate=(v_hospitalizationinfo ->> 'Hospital_DischargedDate')::timestamp,
				  hospital_dischargeplan=v_hospitalizationinfo ->> 'Hospital_DischargePlan', reasoforfenialbyprovider=v_hospitalizationinfo ->> 'ReasoForFenialByProvider', hospital_dischargediagnoses=v_hospitalizationinfo ->> 'Hospital_DischargeDiagnoses', 
				  hospital_transferredname=v_hospitalizationinfo ->> 'Hospital_TransferredName', hospital_unit=v_hospitalizationinfo ->> 'Hospital_Unit', hospital_roomnumber=v_hospitalizationinfo ->> 'Hospital_RoomNumber', 
				  hospital_phonenumber=v_hospitalizationinfo ->> 'Hospital_PhoneNumber', hospital_addressline1=v_hospitalizationinfo ->> 'hospital_addressline1',
				  hospital_addressline2=v_hospitalizationinfo ->> 'hospital_addressline2', 
				  hospital_country=v_hospitalizationinfo ->> 'hospital_country', hospital_dischargerecommendation=v_hospitalizationinfo ->> 'Hospital_DischargeRecommendation',
				  Actual_Placement_After_Discharge=v_hospitalizationinfo ->> 'Actual_Placement_After_Discharge',
				  hospital_reasonforovrstay=v_hospitalizationinfo ->> 'Hospital_ReasonForOvrStay', hospital_denialsbyproviders=v_hospitalizationinfo ->> 'Hospital_DenialsByProviders',
				  hospital_lengthofoverstay=v_hospitalizationinfo ->> 'Hospital_LengthOfOverstay', 
				  hospital_grouphome=v_hospitalizationinfo ->> 'Hospital_GroupHome', hospital_cityname=v_hospitalizationinfo ->> 'hospital_cityname',
				  hospital_statename=v_hospitalizationinfo ->> 'hospital_statename', hospital_zipcode1=v_hospitalizationinfo ->> 'hospital_zipcode1', 
				  hospitalization_reasonforhospitalization_others=v_hospitalizationinfo ->> 'hospitalization_reasonForHospitalization_others', 
				  durationdays=v_hospitalizationinfo ->> 'durationdays', medicalnecessitydays=v_hospitalizationinfo ->> 'medicalnecessitydays', hospital_room=v_hospitalizationinfo ->> 'hospital_room', 
				  hospital_roomphoneno=v_hospitalizationinfo ->> 'hospital_roomphoneno', objectid = v_livingarrangementid
                  WHERE hospitalizationid = v_hospitalizationid;


				end if;


                		--generate audit data and insert record in history table
		        select * into flag from cjams.generate_audit_data('personhospitalization',v_hospitalizationid);

                if v_plcmentid is not null then 
                                 raise notice 'v_personExaminationinfo 193%',v_plcmentid;
                                 raise notice 'v_personExaminationinfo 194%',v_livingarrangementid;
								 raise notice 'v_hospitalizationid %',v_hospitalizationid;
                
                   update placementrevision pr set objectid = v_hospitalizationid, updatedon = now(), updatedby = v_insertedby where pr.placementid = v_plcmentid and pr.activeflag =1;
                end if;
				
                select * into v_updatedocumentproperties from cjams.updatedocumentproperties(v_person_id, v_hospitalizationinfo -> 'uploadpath',v_hospitalizationid::varchar,'personhospitalization', null,v_insertedby);
	  
	  
	    end if;

    return response;
end;

$function$;