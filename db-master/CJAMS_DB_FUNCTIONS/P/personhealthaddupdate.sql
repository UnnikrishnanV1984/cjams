drop FUNCTION if exists cjams.personhealthaddupdate(uuid, json, character varying,  integer);
CREATE OR REPLACE FUNCTION cjams.personhealthaddupdate(person_id uuid, health json, insertedby character varying, isnew integer)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$ 
------------------------------------------------------------------------------------------------------------
-- Revision(s) 
--09/05/2024 Sushma Bade - CIDM-9378 CRISP - person immunization screen
--07/11/2024 Sushma Bade -- CIDM-8809 updating the same record instead of deleting it for person immunization UI updates
-- 05/29/2024 Sushma Bade -- CIDM-8809 adding records in history table for person immunization
-- 07/08/2024 Kapila Mandhadi -- CIDM-8666- changes on adding addidtional question when user selects a female or Transgender: Identifies as Male 
-- 06/21/2023 Manasa Kasula -- CDM-29425 Changes related to person health document delete 
-- 01/17/2023 Mukesh R -- CDM-26917_Entering_Immunization
--12/02/2022 Smitha S -- adding new fields for CIDM-6157
-- 10/05/2021 Vineet Tirodkar -- Modifications to update the Audit columns for all Inserts/Updates (B-113057)
-- 02/25/2022 Chandra Ramasamy -- Adding two new fileds for lap test & Speciality other reason(B-124086)
-- 06/29/2022 Pratap p -- Adding new fileds for AFCARS B-130716 
---07/20/2022 Shamili Kallu- Adding new fileds for AFCARS B-130716 
--02/17/2023 Smitha S -adding new fields for CIDM-6692
-- 03/31/2023 Vijaya Laxmi Devunoori - CIDM-6926 : Added two new fields: 
--		personexamination.isannualhealthvisit and personexamination.issemiannualdentalvisit
-- 05/31/2024 Charan sai Bodapti - CIDM-8894 : Added four new fields: compliantcomments,dateofrefill,
-- changeofdate,otherspecifyduration,pecifyfrequencyhour,specifyduration (B-186263)
--08/23/2024-Umasankar Raavi --CIDM-9160- Added new columns to the function (hospitalization_discharge_recommendation_others, actual_placement_after_discharge_others,Actual_Placement_After_Discharge )
-- 01/24/2024 - Veera Nadimpalli - Health Tab user story changes  - CIDM-10057
-- 05/07/2025 prasanna sai kommineni - CIDM-10469 healthcare decision-maker record -UPDATED for to return the psychotropic id
-- 05/08/2026--Umasankar Raavi--CIDM-11294 -- Added casenumber to display in Health Passport Calendar
---7/24/2026 --Smitha Somasekharan -CIDM-11406 - Added parentid for refill records

------------------------------------------------------------------------------------------------------------	
declare v_person_id uuid;
	v_health json;
	v_insertedby character varying;
	v_updatedby character varying;
	v_isnew integer;
	response character varying;
	v_chronicinfojson json;
	v_chronicinfo json;
	v_birthhealthbirthjson json;
	v_birthhealthunderfivejson json;
	v_allergiesinfojson json;
	v_allergiesinfo json;
	v_behaviourinfojson json;
	v_behaviourinfo json;
	v_birthhealthinfojson json;
	v_birthhealthinfo json;
	v_substanceabusejson json;
	v_substanceabuse json;
	v_healthinsuranceinfojson json;
	v_healthinsuranceinfo json;
	v_reproductivehealthinfojson json;
	v_immunizationjson json;
	v_immunizationid uuid;
	v_reproductivehealthinfo json;
	v_familyhistoryinfojson json;
	v_familyhistoryinfo json;
	v_hospitalizationinfojson json;
	v_hospitalizationinfo json;
	v_personExaminationinfojson json;
	v_personExaminationinfo json;
	v_personExaminationappointmentjson json;
	v_personExaminationappointment json;
	v_personExaminationPhysicianinfo json;
	v_providerinfojson json;
	v_providerinfo json;
	v_providerinfophysician json;
	v_providerinfodentist json;
	v_medicalconditioninfojson json;
	v_medicalconditioninfo json;
	v_medicalpsychotropicinfojson json;
	v_medicalpsychotropicinfo json;
	v_mobilityspeechinfojson json;
	v_mobilityspeechinfo json;
	v_feedinginfojson json;
	v_feedinginfo json;
	v_sleepinginfojson json;
	v_sleepinginfo   json;
	v_eliminationinfojson json;
	v_eliminationinfo json;
	v_immunization json;
	v_personexaminationid uuid;
	v_behaviourhealthid uuid;
	v_status character varying;
	v_updatedocumentproperties character varying;
	v_parentexaminationid uuid;
	v_personbehavioralhealthid uuid;
	v_birthhealthinfoid uuid;
	v_clientunder5yearsinfoid uuid;
	v_personfmlymdclhstryid uuid;
	v_hospitalizationid uuid;
	v_personhealthinsuranceid uuid;
	v_personsexualinfoid uuid;
	v_personabusesubstanceid uuid;
	v_personphycisianinfoid uuid;
	v_personmedicalconditionid uuid;
	v_personhlthmobilityspeechid uuid;
	v_personhlthfeedingid uuid;
	v_personmedicpshychotropicid uuid;
	flag record;

begin
	v_person_id := person_id;
	v_health := health;
	v_chronicinfojson := v_health ->> 'personChronic';
	v_allergiesinfojson := v_health ->> 'personAllergies';
	v_behaviourinfojson := v_health ->> 'personBehaviour';
	v_birthhealthinfojson := v_health ->> 'personBirth';
	v_birthhealthinfojson := v_health ->> 'personBirth';
	v_substanceabusejson := v_health ->> 'personHealthSubstanceAbuse';
	v_familyhistoryinfojson := v_health ->> 'personfamilyHistroy';
	v_hospitalizationinfojson := v_health ->> 'personHospitalizationHistory';
	v_healthinsuranceinfojson := (v_health -> 'insuranceInfo')::json;
	v_reproductivehealthinfojson := v_health ->> 'reproductiveHealthInfo';
	v_personExaminationinfojson := v_health ->> 'personExamination';
	v_personExaminationappointmentjson :=  v_personExaminationinfojson -> 'appointment';
	v_providerinfojson := v_health ->> 'personProviderHistory';
	select  json_array_elements((v_health -> 'personProviderHistory')::json) -> 'provider_info' into v_providerinfophysician;
	select  json_array_elements((v_health -> 'personProviderHistory')::json) -> 'Dental_info' into v_providerinfodentist;
	v_medicalconditioninfojson := v_health ->> 'medicalConditions';
	v_medicalpsychotropicinfojson := v_health ->> 'personmedicalPsychotropic';
	v_mobilityspeechinfojson := v_health ->> 'mobilitySpeechInfo';
	v_feedinginfojson := v_health ->> 'feedingInfo';
	v_sleepinginfojson := v_health ->> 'sleepingInfo';
	v_eliminationinfojson := v_health -> 'personElimination';
	v_immunizationjson := v_health ->> 'personImmunization';
	v_insertedby := insertedby;
	v_behaviourhealthid := gen_random_uuid();
	v_isnew := isnew;

	response := 'sucess';
	-- Creating Temp Tables --
	-- Add / Update --
	-- raise notice 'v_allergiesinfojson%',v_chronicinfojson;
	if isnew = 1 then
		-- Chronic Save Starts
		for v_chronicinfo in select
			*
		from
			json_array_elements(v_chronicinfojson) loop 
		insert
		into
			clientchronicinfo ( clientchronicinfoid,
			personid,
			chronicinfoflag,
			chronichighriskflag,
			physicalproblem,
			mentalproblem,
			physicalproblemtx,
			mentalproblemtx,
			chroniccommentstx,
			activeflag,
			insertedby,
			insertedon,
			updatedby,
			updatedon )
		values 
			( 	gen_random_uuid(),
				v_person_id,
				case
					when (v_chronicinfo ->> 'noknownchronic') = 'true' then 1
					else 0
				end,
				case
					when (v_chronicinfo ->> 'highriskmentaldisease') = 'true' then 1
					else 0
				end,
				v_chronicinfo -> 'physicalkey',
				v_chronicinfo -> 'mentalkey',
				v_chronicinfo ->> 'physicalcomments',
				v_chronicinfo ->> 'mentalcomments',
				v_chronicinfo ->> 'comments',
				1,
				v_insertedby::uuid,
				now(),
				v_insertedby::uuid,
				now()
			);
		end loop;
		-- Chronic Save Ends
	
		if (v_allergiesinfojson is not null) then 
			for v_allergiesinfo in select
				*
			from
				json_array_elements(v_allergiesinfojson) loop insert
			into
				personallergiesinfo ( personallergiesinfoid,
				personid,
				allergy,
				specialneed,
				hygine,
				phobia,
				medicationallergy,
				allergycomments,
				insertedon,
				insertedby,
				activeflag,
				adversecomments,
				specialneedcomments,
				hygienecomments,
				phobiacomments,
				updatedby, 
				updatedon	
				)
			values
				(	gen_random_uuid(),
					v_person_id,
					v_allergiesinfo -> 'allergieskey',
					v_allergiesinfo -> 'specialkey',
					v_allergiesinfo -> 'hygienekey',
					v_allergiesinfo -> 'phobiakey',
					v_allergiesinfo ->> 'medicationcomments',
					v_allergiesinfo ->> 'comments',
					now(),
					v_insertedby::uuid,
					1,
					v_allergiesinfo ->> 'allergiessymptoms',
					v_allergiesinfo ->> 'specialcomments',
					v_allergiesinfo ->> 'hygienecomments',
					v_allergiesinfo ->> 'phobiacomments',
					v_insertedby::uuid,
					now()					
				);
			end loop;
		end if;

		if (v_immunizationjson is not null) then 
			
			v_immunization := v_immunizationjson ->> 'personImmunization';
			v_immunizationid := v_immunizationjson ->> 'personimmunizationid';
			
			raise notice 'v_immunizationjson%',v_immunizationjson;

			if (v_immunizationid is not null) then

			UPDATE personimmunization
			SET immunizationdate = (v_immunizationjson ->> 'immunizationdate')::timestamp,
				"comments" = v_immunizationjson ->> 'comments',
				updatedby = v_insertedby, updatedon = now()
			WHERE personimmunizationid = v_immunizationid;
			
			else

			v_immunizationid := gen_random_uuid();

			INSERT INTO personimmunization
				( 	personimmunizationid, personid, uploadpath, immunizationdate, "comments",
					personimmunizationconfigid, insertedby, insertedon, activeflag, updatedby, updatedon
				)
			VALUES
				(	v_immunizationid, v_person_id, 
					null,
					(v_immunizationjson ->> 'immunizationdate')::timestamp,
					v_immunizationjson ->> 'comments',
					(v_immunizationjson ->> 'personimmunizationconfigid')::uuid,
					v_insertedby,
					now(),
					1,
					v_insertedby,
					now()
				);
			
			end if;
			select * into v_updatedocumentproperties from cjams.updatedocumentproperties(v_person_id, v_immunizationjson -> 'uploadpath',v_immunizationid::varchar,'personimmunization', null,v_insertedby);
		
		--generate audit data and insert record in history table
		select * into flag from cjams.generate_audit_data('personimmunization',v_immunizationid);

		end if;

		if (v_behaviourinfojson is not null) then 
			v_personbehavioralhealthid := gen_random_uuid();
			for v_behaviourinfo in select
				*
			from
				json_array_elements(v_behaviourinfojson) loop INSERT 
			INTO cjams.personbehavioralhealth
				(	personbehavioralhealthid, parentbehaviouralhealthid, personid, uploadpath, clinicianname, currentdiagnoses, 
					phone, address1, address2, reportname, city, state, county, zip, activeflag, insertedby, insertedon, 
					reportpath, isbehavioralhealth, typeofservice, dateofevaluation, evaluationby, nodiagnosisreason,
					email, phobiakey, phobiacomments, updatedby, updatedon 
				)
			VALUES(	v_personbehavioralhealthid, v_behaviourhealthid, v_person_id,
				null,
				v_behaviourinfo  ->> 'clinicianname',
				v_behaviourinfo  ->> 'currentdiagnosis',
				v_behaviourinfo  ->> 'phonenumber',
				v_behaviourinfo  ->> 'address1',
				v_behaviourinfo  ->> 'address2',
				v_behaviourinfo  ->> 'reportname',
				v_behaviourinfo  ->> 'city',
				v_behaviourinfo  ->> 'state',
				v_behaviourinfo  ->> 'county',
				v_behaviourinfo  ->> 'zipcode',
				1,
				v_insertedby,
				now(),
				v_behaviourinfo  ->> 'reportpath',
				(v_behaviourinfo  ->> 'isbehaviouraldiagnosis')::bool,
				v_behaviourinfo  -> 'typeofservice',
				(v_behaviourinfo  ->> 'dateofevaluation')::timestamp,
				v_behaviourinfo  ->> 'evaluationby',
				v_behaviourinfo  ->> 'nodiagnosisreason',
				v_behaviourinfo  ->> 'email',
				v_behaviourinfo  -> 'phobiakey',
				v_behaviourinfo  ->> 'phobiacomments',
				v_insertedby,
				now()
				);

				select * into v_updatedocumentproperties from cjams.updatedocumentproperties(v_person_id, v_behaviourinfo -> 'uploadpath',v_personbehavioralhealthid::varchar,'personbehavioralhealth', null,v_insertedby);
			
			end loop;
		end if;

		if (v_birthhealthinfojson is not null) then 

			v_birthhealthbirthjson := v_birthhealthinfojson ->> 'birth';
			v_birthhealthunderfivejson := v_birthhealthinfojson ->> 'underfive';
			update birthhealthinfo 
			set activeflag = 0, 
				updatedby = v_insertedby, 
				updatedon = now()
			where personid = v_person_id;
			
			update clientunder5yearsinfo 
			set activeflag = 0, 
				updatedby = v_insertedby, 
				updatedon = now() 
			where personid=v_person_id;
			
			insert into birthhealthinfo
				(	personid,
					uploadpath,
					mothersusepregnant,
					mothersusepregnantspecify,
					mentalcondition,
					mentalconditionspecify,
					diseasescondition,
					diseasesconditionspecify,
					birthdefects,
					"comments",
					insertedby,
					insertedon,
					updatedby, 
					updatedon
				)
			values
				(	v_person_id,
					null,
					v_birthhealthbirthjson -> 'mothersusepregnant',
					v_birthhealthbirthjson ->> 'mothersusepregnantspecify',
					v_birthhealthbirthjson -> 'mentalcondition',
					v_birthhealthbirthjson ->> 'mentalconditionspecify',
					v_birthhealthbirthjson -> 'diseasescondition',
					v_birthhealthbirthjson ->> 'diseasesconditionspecify',
					v_birthhealthbirthjson ->> 'birthdefects',
					v_birthhealthbirthjson ->> 'comments',
					v_insertedby,
					now(),
					v_insertedby,
					now()				
				) returning birthhealthinfoid into v_birthhealthinfoid;

			select * into v_updatedocumentproperties from cjams.updatedocumentproperties(v_person_id, v_birthhealthbirthjson -> 'uploadpath',v_birthhealthinfoid::varchar,'birthhealthinfo', null,v_insertedby);
				
			insert into clientunder5yearsinfo 
				(	personid, uploadpath, prenatalcaretypekey, prenatalproblemspecify, gestation, parentcare,
					deliverytypekey, hospitalname, address1, address2, phone, email, cityname, statetypekey, county,
					zip5no, deliverycomplicationnotes, complicationsspecify, comments, hospitalcomments, parity,
					complications, speciality, whenbegun, insertedby, insertedon, updatedby, updatedon
				) 
			values 
				(	v_person_id,	
					null,
					v_birthhealthunderfivejson ->> 'prenatalproblem',
					v_birthhealthunderfivejson ->> 'prenatalproblemspecify',
					v_birthhealthunderfivejson -> 'gestation',
					v_birthhealthunderfivejson ->> 'parentcare',
					v_birthhealthunderfivejson ->> 'deliverytype',
					v_birthhealthunderfivejson ->> 'childbornin',
					v_birthhealthunderfivejson ->> 'address1',
					v_birthhealthunderfivejson ->> 'address2',
					v_birthhealthunderfivejson ->> 'phone',
					v_birthhealthunderfivejson ->> 'email',
					v_birthhealthunderfivejson ->> 'city',
					v_birthhealthunderfivejson ->> 'state',
					v_birthhealthunderfivejson ->> 'county',
					(v_birthhealthunderfivejson ->> 'zip5no')::numeric,
					v_birthhealthunderfivejson ->> 'deliverycomplicationnotes',
					v_birthhealthunderfivejson ->> 'complicationsspecify',
					v_birthhealthunderfivejson ->> 'comments',
					v_birthhealthunderfivejson ->> 'hospitalcomments',
					v_birthhealthunderfivejson ->> 'parity',
					v_birthhealthunderfivejson -> 'complications',
					v_birthhealthunderfivejson ->> 'speciality',
					v_birthhealthunderfivejson ->> 'whenbegun',
					v_insertedby,
					now(),
					v_insertedby,
					now()
				) returning clientunder5yearsinfoid into v_clientunder5yearsinfoid;

				select * into v_updatedocumentproperties from cjams.updatedocumentproperties(v_person_id, v_birthhealthunderfivejson -> 'uploadpath',v_clientunder5yearsinfoid::varchar,'clientunder5yearsinfo', null,v_insertedby);
			
				--end loop;
		end if;
	
		if (v_familyhistoryinfojson is not null) then 
			for v_familyhistoryinfo in select
				*
			from
				json_array_elements(v_familyhistoryinfojson) loop insert
			into
				personfmlymdclhstry ( personid ,
				uploadpath,
				famhistclient,
				famhistrelationtype,
				majorhistoryproblem,
				deathcausetype,
				"comments",
				insertedby,
				-- User who created this record
				insertedon,
				-- Record created date and time
				updatedby, 
				updatedon
				)
			values
				(	v_person_id,
					null,
					v_familyhistoryinfo ->> 'clientlist',
					v_familyhistoryinfo ->> 'Relationship',
					v_familyhistoryinfo ->> 'major_health_problems',
					v_familyhistoryinfo ->> 'cause_of_death',
					v_familyhistoryinfo ->> 'comments',
					v_insertedby::uuid,
					now(),
					v_insertedby::uuid,
					now()
				) returning personfmlymdclhstryid into v_personfmlymdclhstryid ;

			select * into v_updatedocumentproperties from cjams.updatedocumentproperties(v_person_id, v_familyhistoryinfo -> 'uploadpath',v_personfmlymdclhstryid::varchar,'personfmlymdclhstry', null,v_insertedby);
			
			end loop;
		end if;

		if (v_hospitalizationinfojson is not null) then 
			for v_hospitalizationinfo in select
				*
			from
				json_array_elements(v_hospitalizationinfojson) loop insert
			into
				personhospitalization ( personid ,
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
					hospital_roomphoneno
				)
			values
				(	v_person_id,
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
					v_hospitalizationinfo ->> 'hospital_roomphoneno'
				) returning hospitalizationid into v_hospitalizationid ;

				response = v_hospitalizationid::character varying;
				
				select * into flag from cjams.generate_audit_data('personhospitalization',v_hospitalizationid);

				select * into v_updatedocumentproperties from cjams.updatedocumentproperties(v_person_id, v_hospitalizationinfo -> 'uploadpath',v_hospitalizationid::varchar,'personhospitalization', null,v_insertedby);
			
			end loop;
		end if;

		if (v_healthinsuranceinfojson is not null) then 
			for v_healthinsuranceinfo in select
				*
			from
				json_array_elements(v_healthinsuranceinfojson) loop insert
			into
				personhealthinsurance ( personid,
				uploadpath,
				isinsuranceavailable,
				insurancetype,
				policyholdername,
				medicalinsuranceprovider,
				patientpolicyholderrelation,
				providertype,
				providerphone,
				policynumber,
				managedcareorganization,
				groupnumber,
				effectivedate,
				expirationdate,
				address1,
				address2,
				city,
				state,
				county,
				zip,
				activeflag,
				ismedicaidmedicare,
				insertedby,
				insertedon,
				updatedby,
				updatedon,
				medicarenumber,
				caresmatypekey,
				medicaidstartdate,
				medicaidenddate,
				providedbynotes
				 )
			values
				(	v_person_id,
					null,
					true,
					v_healthinsuranceinfo ->> 'insurancetype',
					v_healthinsuranceinfo ->> 'policyholdername',
					v_healthinsuranceinfo ->> 'medicalinsuranceprovider',
					v_healthinsuranceinfo ->> 'patientpolicyholderrelation',
					v_healthinsuranceinfo ->> 'providertype',
					v_healthinsuranceinfo ->> 'providerphone',
					v_healthinsuranceinfo ->> 'policynumber',
					v_healthinsuranceinfo ->> 'managedcareorganization',
					v_healthinsuranceinfo ->> 'groupnumber',
					(v_healthinsuranceinfo ->> 'startdate')::timestamp without time zone,
					(v_healthinsuranceinfo ->> 'enddate')::timestamp without time zone,
					v_healthinsuranceinfo ->> 'address1',
					v_healthinsuranceinfo ->> 'address2',
					v_healthinsuranceinfo ->> 'city',
					v_healthinsuranceinfo ->> 'state',
					v_healthinsuranceinfo ->> 'county',
					v_healthinsuranceinfo ->> 'zip',
					1,
					(v_healthinsuranceinfo ->> 'ismedicaidmedicare')::boolean,
					v_insertedby,
					now(),
					v_insertedby,
					now(),
					v_healthinsuranceinfo ->> 'medicarenumber',
					v_healthinsuranceinfo ->> 'caresmatypekey',
					(v_healthinsuranceinfo ->> 'medicaidstartdate')::timestamp without time zone,
					(v_healthinsuranceinfo ->> 'medicaidenddate')::timestamp without time zone,
					v_healthinsuranceinfo ->> 'providedbynotes'
				) returning personhealthinsuranceid into v_personhealthinsuranceid;

				select * into v_updatedocumentproperties from cjams.updatedocumentproperties(v_person_id, v_healthinsuranceinfo -> 'uploadpath',v_personhealthinsuranceid::varchar,'personhealthinsurance', null,v_insertedby);
			
			end loop;
		end if;

		if (v_reproductivehealthinfojson is not null) then 
			for v_reproductivehealthinfo in select
				*
			from
				json_array_elements(v_reproductivehealthinfojson) loop insert
			into
				personsexualinfo ( personsexualinfoid,
				personid,
				uploadpath,
				sexualactiveflag,
				ispregnant,
				childrenno,
				pregnancyno,
				sextransdis,
				std_treatment_startdate,				
				std_treatment_enddate,
				birthcontrol,
				stdspecify,
				bcspecify,
				sicomments,
				insertedby,
				insertedon,
				updatedby,
				updatedon,
				genderidentity,
				genderidentityspecify,
				birthcontroldate,
				sexualorientationcomments,
				specify,
				sexualorientationkey,
				pregnancyduedate,
				ispregnancyduedateunknown,
				currentlyparenting,
				notparentingreason,
				isfatheredachild,
				currentlyparentingother,
				notparentingotherreason,
				isgivenbirth
				)
			values
				(	gen_random_uuid(),
					v_person_id,
					null,
					case v_reproductivehealthinfo ->> 'sexualactiveflag' when 'Yes' THEN 1 WHEN 'No' THEN 0 ELSE 2 END,
					--		(v_reproductivehealthinfo ->> 'sexualactiveflag')::integer,
					(v_reproductivehealthinfo ->> 'ispregnant')::boolean,
					(v_reproductivehealthinfo ->> 'childrenno')::integer,
					(v_reproductivehealthinfo ->> 'pregnancyno')::integer,
					v_reproductivehealthinfo ->> 'sextransdis',
					case when(v_reproductivehealthinfo ->> 'std_treatment_startdate') is null then null else
					to_date(v_reproductivehealthinfo ->> 'std_treatment_startdate' ,'MM/DD/YYYY') end,
					case when(v_reproductivehealthinfo ->> 'std_treatment_enddate') is null then null else
					to_date(v_reproductivehealthinfo ->> 'std_treatment_enddate' ,'MM/DD/YYYY') end,
					v_reproductivehealthinfo ->> 'birthcontrol',
					v_reproductivehealthinfo ->> 'stdspecify',
					v_reproductivehealthinfo ->> 'bcspecify',
					v_reproductivehealthinfo ->> 'sicomments',
					v_insertedby,
					now(),
					v_insertedby,
					now() ,
					v_reproductivehealthinfo ->> 'genderidentity',
					v_reproductivehealthinfo ->> 'genderidentityspecify',
					case when(v_reproductivehealthinfo ->> 'birthcontroldate') is null then null else
					to_date(v_reproductivehealthinfo ->> 'birthcontroldate' ,'MM/DD/YYYY') end,
					v_reproductivehealthinfo ->> 'sexualorientationcomments',
					v_reproductivehealthinfo ->> 'specify',
					v_reproductivehealthinfo ->> 'sexualorientationkey',
					(v_reproductivehealthinfo ->> 'pregnancyduedate')::timestamp ,
					(v_reproductivehealthinfo ->> 'ispregnancyduedateunknown')::boolean,
					(v_reproductivehealthinfo ->> 'currentlyparenting')::boolean,
					(v_reproductivehealthinfo ->> 'notparentingreason')::character varying,
					(v_reproductivehealthinfo ->> 'isfatheredachild')::boolean,
					(v_reproductivehealthinfo ->> 'currentlyparentingother')::boolean,
					(v_reproductivehealthinfo ->> 'notparentingotherreason')::text,
					(v_reproductivehealthinfo ->> 'isgivenbirth')::boolean
				) returning personsexualinfoid into v_personsexualinfoid;

				select * into v_updatedocumentproperties from cjams.updatedocumentproperties(v_person_id, v_reproductivehealthinfo -> 'uploadpath',v_personsexualinfoid::varchar,'personsexualinfo', null,v_insertedby);
	 
				if((v_reproductivehealthinfo ->> 'servicecaseid') is not null 
					and ((v_reproductivehealthinfo ->> 'pregnancyduedate')::timestamp) is not null 
					and date((v_reproductivehealthinfo ->> 'pregnancyduedate')::timestamp) < date(now()) ) then 
		
					with person_person_info as (
						select concat(firstname, ' ', lastname) as name, cjamspid 
							from person 
						where personid = v_person_id
					)
					SELECT send_notification INTO v_status 
					FROM send_notification
						(	v_insertedby
							, v_insertedby
							, v_insertedby
							, 'System'
							, 'High'
							, concat('Case ', (v_reproductivehealthinfo ->> 'servicecaseid')::character varying, ', Due Date has been passed for the client ', (select name from person_person_info), '(', (select cjamspid from person_person_info), '), Please update the "Currenlty Pregnant" statu. Also add the new born to the case as a client as applicable')
							, concat('Case ', (v_reproductivehealthinfo ->> 'servicecaseid')::character varying, ', Due Date has been passed for the client ', (select name from person_person_info), '(', (select cjamspid from person_person_info), '), Please update the "Currenlty Pregnant" statu. Also add the new born to the case as a client as applicable')
							, (v_reproductivehealthinfo ->> 'servicecaseid')::character varying
						);                                                                              
		
				end if;
			end loop;
		end if;

		if (v_personExaminationinfojson is not null) then 
			for v_personExaminationinfo in select
				*
			from
				json_array_elements(v_personExaminationinfojson) loop 
				--raise notice 'v_personExaminationinfo%',v_personExaminationinfo ->> 'appointment';
				v_personExaminationappointmentjson := v_personExaminationinfo ->> 'appointment';
				v_personExaminationPhysicianinfo := v_personExaminationinfo ->> 'physician';
				raise notice 'v_personExaminationinfo%',v_personExaminationinfo;
				raise notice 'providerinfoflag%',v_personExaminationinfo ->> 'providerinfoflag';
				v_parentexaminationid := gen_random_uuid();
				v_personexaminationid := gen_random_uuid();
				raise notice 'v_personexaminationid%',v_personexaminationid;
				for v_personExaminationappointment in select
					*
				from
					json_array_elements(v_personExaminationappointmentjson) loop 
					--raise notice 'v_personExaminationappointment%',v_personExaminationappointment;
				insert
				into
				cjams.personexamination (
					personexaminationid,
					parentexaminationid,
					appoinmentdate,
					nextappointmentdate,
					starttime,
					endtime,
					examinationtypekey,
					casenumber,
					labtesttypekey,
					specialityexamtypekey,
					appointkeptflag,
					hivconsentflag,
					physicianspeciality,
					affiliateorg,
					physicianname,
					recommendations,
					comments,
					address1,
					address2,
					cityname,
					statetypekey,
					countytypekey,
					zip5no,
					workphone,
					email,
					personid,
					insertedon,
					insertedby,
					nextappointmentreason,
					authformcompletion,
					notcompletedauthform,
					provcaremissed,
					otherreason,
					notkeptreason,
					uploadpath,
					providerinfoflag,
					followupneeded,
					medicalreferrals,
					covidimpacted, 
					exposedtocovid, 
					covidtestconducted, 
					typeoftest, 
					covidtestresults, 
					covidtestdate,
					updatedby, 
					updatedon,
					timeframe,
					labtestother,
					specialityexamother,
					physicianfaxnumber,
					isannualhealthvisit,
					issemiannualdentalvisit
					)
				values
					(	v_personexaminationid,
						v_parentexaminationid,
						(v_personExaminationappointment ->> 'apptDate')::timestamp,
						(v_personExaminationappointment ->> 'nextApptDate')::timestamp,
						v_personExaminationappointment ->> 'starttime',
						v_personExaminationappointment ->> 'endtime',
						v_personExaminationappointment ->> 'natureofexamkey',
						v_personExaminationappointment ->> 'casenumber',
						(v_personExaminationappointment ->> 'labtestkey')::json,
						v_personExaminationappointment ->> 'specialityexamkey',
						(v_personExaminationappointment ->> 'apptkept')::int,
						case
							when (v_personExaminationappointment ->> 'hivtestreceived') = 'true' then 1			
							else 0
						end,
						v_personExaminationPhysicianinfo ->> 'speciality',
						v_personExaminationPhysicianinfo ->> 'affilication',
						v_personExaminationPhysicianinfo ->> 'physicianname',
						v_personExaminationPhysicianinfo ->> 'recommendations',
						v_personExaminationPhysicianinfo ->> 'comments',
						v_personExaminationPhysicianinfo ->> 'address1',
						v_personExaminationPhysicianinfo ->> 'address2',
						v_personExaminationPhysicianinfo ->> 'city',
						v_personExaminationPhysicianinfo ->> 'state',
						v_personExaminationPhysicianinfo ->> 'county',
						( v_personExaminationPhysicianinfo ->> 'zip')::numeric,
						v_personExaminationPhysicianinfo ->> 'phone',
						v_personExaminationPhysicianinfo ->> 'email',
						v_person_id,
						now(),
						v_insertedby::uuid,
						v_personExaminationappointment ->> 'nextappointmentreason',
						v_personExaminationappointment ->> 'authformcompletion',
						v_personExaminationappointment ->> 'notcompletedauthform',
						v_personExaminationappointment ->> 'provcaremissed',
						v_personExaminationappointment ->> 'otherreason',
						v_personExaminationappointment ->> 'notkeptreason',
						null,
						case
							when (v_personExaminationinfo ->> 'providerinfoflag') = 'true' then 1
							else 0
						end,
						v_personExaminationPhysicianinfo ->> 'followupneeded',
						v_personExaminationPhysicianinfo ->> 'medicalreferrals', 
						CASE WHEN (v_personExaminationinfo ->> 'covidimpacted') = 'true' THEN true ELSE false END, 
						v_personExaminationinfo ->> 'exposedtocovid', 
						v_personExaminationinfo ->> 'covidtestconducted', 
						v_personExaminationinfo ->> 'typeoftest', 
						v_personExaminationinfo ->> 'covidtestresults', 
						(v_personExaminationinfo ->> 'covidtestdate')::date,
						v_insertedby::uuid,
						now(),
						v_personExaminationappointment ->> 'timeframe',
						v_personExaminationappointment ->> 'labtestother',
						v_personExaminationappointment ->> 'specialityexamother',
						v_personExaminationPhysicianinfo ->> 'physicianfaxnumber',
						(v_personExaminationappointment ->> 'isannualhealthvisit') :: boolean,
						(v_personExaminationappointment ->> 'issemiannualdentalvisit') :: boolean					
					);

					select * into v_updatedocumentproperties from cjams.updatedocumentproperties(v_person_id, v_personExaminationinfo -> 'uploadpath',v_personexaminationid::varchar,'personexamination',null,v_insertedby);
			
				end loop;
			end loop;
		end if;

		if (v_substanceabusejson is not null) then 
			for v_substanceabuse in select
				*
			from
				json_array_elements(v_substanceabusejson) loop 
			INSERT INTO personabusesubstance
				(	parentabusesubstanceid,
					personid, 
					uploadpath,
					isusetobacco, 
					isusedrugoralcohol, 
					isusedrug,
					isusealcohol, 
					drugfrequencydetails, 
					drugageatfirstuse,
					alcoholfrequencydetails,
					alcoholageatfirstuse,
					drugoralcoholproblems, 
					ischildhassextraffichistory,
					issextraffichistoryreported,
					sextraffichistoryreportedon,
					ischildhassextraffic,
					issextrafficreported,
					sextrafficreportedon,
					nochangesinsextraffic,
					activeflag, 
					insertedby, 
					insertedon,
					tobaccoageatfirstuse, 
					tobaccofrequencydetails,
					updatedby, 
					updatedon
				)
			VALUES
				(	v_behaviourhealthid,
					v_person_id,
					null,
					( v_substanceabuse  ->> 'isusetobacco')::bool,
					( v_substanceabuse  ->> 'isusedrugoralcohol')::bool,
					(v_substanceabuse  ->> 'isusedrug')::bool,
					(v_substanceabuse  ->> 'isusealcohol')::bool,
					v_substanceabuse  ->> 'drugfrequencydetails',
					v_substanceabuse  ->> 'drugageatfirstuse',
					v_substanceabuse  ->> 'alcoholfrequencydetails',
					v_substanceabuse  ->> 'alcoholageatfirstuse',
					v_substanceabuse  ->> 'drugoralcoholproblems',
					( v_substanceabuse  ->> 'ischildhassextraffichistory')::bool,
					( v_substanceabuse  ->> 'issextraffichistoryreported')::bool,
					( v_substanceabuse  ->> 'sextraffichistoryreportedon')::date,
					( v_substanceabuse  ->> 'ischildhassextraffic')::bool,
					( v_substanceabuse  ->> 'issextrafficreported')::bool,
					( v_substanceabuse  ->> 'sextrafficreportedon')::date,
					( v_substanceabuse  ->> 'nochangesinsextraffic')::bool,
					1,
					v_insertedby::uuid,
					now(),
					v_substanceabuse  ->> 'tobaccoageatfirstuse',
					v_substanceabuse  ->> 'tobaccofrequencydetails',
					v_insertedby::uuid,
					now()
				) returning personabusesubstanceid into v_personabusesubstanceid;

				select * into v_updatedocumentproperties from cjams.updatedocumentproperties(v_person_id, v_substanceabuse -> 'uploadpath',v_personabusesubstanceid::varchar,'personabusesubstance', null,v_insertedby);
	 
			end loop;
		end if;
		
		if (v_medicalpsychotropicinfojson is not null) then 
			for v_medicalpsychotropicinfo in select
				*
			from
				json_array_elements(v_medicalpsychotropicinfojson) loop 
			INSERT INTO personmedicpshychotropic
				(	personid, isprescribedmedication, prescriptionreasontypekey, medicationname, medicationtype, 
					prescribedduration, prescribedreason, medicationeffectivedate, medicationexpirationdate, dosage, 
					frequency, lastdosetakendate, medicationcomments,informationsourcetypekey, effectivedate,
					startdate, enddate, expirationdate, compliant, reportedby, monitoring, prescribingdoctor,
					updatedby, updatedon, activeflag, insertedby, insertedon,ismedicationpsychotropic,classification,diagnosis,uploadedFiles,targetedsymptoms,targetedother,renewal,informedconsent,otherreason
					,datemedicationstarted,isprescribercheck,compliantcomments,dateofrefill,changeofdate,specifyfrequencyhour,specifyduration,otherspecifyduration
					,diagnosisfromsecond,diagnosisotherfromsecond,psychosocialinterventions,additionalpsychosocialinterventions ,otheradditionalpsychosocialinterventions,prescribercontactinfo
					,prescriberemail,prescriberdegree,otherprescriberdegree,prescriberspecialty,otherprescriberspecialty,settingmedicationprescribed,secondaryreviewcompleted, pshychotropicid,
					personmedicpshychotropicparentid
				)
			VALUES
				(	v_person_id,
					( v_medicalpsychotropicinfo  ->> 'isprescribedmedication')::bool,
					( v_medicalpsychotropicinfo  ->> 'prescriptionreasontypekey'),
					v_medicalpsychotropicinfo  ->> 'medicationname',
					v_medicalpsychotropicinfo  ->> 'medicationtype',
					v_medicalpsychotropicinfo  ->> 'prescribedduration',
					v_medicalpsychotropicinfo  ->> 'prescribedreason',
					( v_medicalpsychotropicinfo  ->> 'medicationeffectivedate')::timestamp,
					( v_medicalpsychotropicinfo  ->> 'medicationexpirationdate')::timestamp,
					v_medicalpsychotropicinfo  ->> 'dosage',
					v_medicalpsychotropicinfo  ->> 'frequency',
					( v_medicalpsychotropicinfo  ->> 'lastdosetakendate')::timestamp,
					v_medicalpsychotropicinfo  ->> 'medicationcomments',
					v_medicalpsychotropicinfo  ->> 'informationsourcetypekey',
					now(), 
					( v_medicalpsychotropicinfo  ->> 'startdate')::timestamp,
					( v_medicalpsychotropicinfo  ->> 'enddate')::timestamp,
					( v_medicalpsychotropicinfo  ->> 'expirationdate')::timestamp,
					( v_medicalpsychotropicinfo  ->> 'compliant')::int,
					v_medicalpsychotropicinfo  ->> 'reportedby',
					v_medicalpsychotropicinfo  ->> 'monitoring',
					v_medicalpsychotropicinfo  ->> 'prescribingdoctor',
					v_insertedby::uuid,
					now(),
					1,
					v_insertedby::uuid,
					now(),
					(v_medicalpsychotropicinfo  ->> 'ismedicationpsychotropic')::bool,
					v_medicalpsychotropicinfo  ->> 'classification',
					v_medicalpsychotropicinfo  ->> 'diagnosis',
					null,
					v_medicalpsychotropicinfo  ->> 'targetedsymptoms',
					v_medicalpsychotropicinfo ->> 'targetedother',
					(v_medicalpsychotropicinfo  ->> 'renewal')::bool,
					v_medicalpsychotropicinfo   ->> 'informedconsent',
					v_medicalpsychotropicinfo   ->> 'otherreason',
					( v_medicalpsychotropicinfo  ->> 'datemedicationstarted')::timestamp,
					(v_medicalpsychotropicinfo  ->> 'isprescribercheck')::bool,
					v_medicalpsychotropicinfo  ->> 'compliantcomments',
					(v_medicalpsychotropicinfo  ->> 'dateofrefill')::date,
					(v_medicalpsychotropicinfo  ->> 'changeofdate')::date,
					v_medicalpsychotropicinfo  ->> 'specifyfrequencyhour',  
					v_medicalpsychotropicinfo  ->> 'specifyduration',
					v_medicalpsychotropicinfo  ->> 'otherspecifyduration',
					v_medicalpsychotropicinfo  ->> 'diagnosisfromsecond',
					v_medicalpsychotropicinfo  ->> 'diagnosisotherfromsecond',
					v_medicalpsychotropicinfo  ->> 'psychosocialinterventions',
					v_medicalpsychotropicinfo  ->> 'additionalpsychosocialinterventions',
					v_medicalpsychotropicinfo  ->> 'otheradditionalpsychosocialinterventions',
					v_medicalpsychotropicinfo  ->> 'prescribercontactinfo',
					v_medicalpsychotropicinfo  ->> 'prescriberemail',
					v_medicalpsychotropicinfo  ->> 'prescriberdegree',
					v_medicalpsychotropicinfo  ->> 'otherprescriberdegree',
					v_medicalpsychotropicinfo  ->> 'prescriberspecialty',
					v_medicalpsychotropicinfo  ->> 'otherprescriberspecialty',
					v_medicalpsychotropicinfo  ->> 'settingmedicationprescribed',
					(v_medicalpsychotropicinfo  ->> 'secondaryreviewcompleted')::bool,
					(v_medicalpsychotropicinfo  ->> 'pshychotropicid'),
					NULLIF(v_medicalpsychotropicinfo ->> 'personmedicpshychotropicparentid', '')::uuid
				) returning personmedicpshychotropicid into v_personmedicpshychotropicid;
				response = v_personmedicpshychotropicid::character varying;
				select * into v_updatedocumentproperties from cjams.updatedocumentproperties(v_person_id, (v_medicalpsychotropicinfo ->> 'uploadedFiles')::json,v_personmedicpshychotropicid::varchar,'personmedicpshychotropic', null,v_insertedby);
			end loop;
		end if;

		if(v_providerinfophysician is not null) then 
			for v_providerinfo in select
				*
			from
				json_array_elements(v_providerinfophysician) loop insert
			into
				personphycisianinfo ( isphysician,
				isdentist,
				personid ,
				uploadpath,
				isprimaryphycisian,
				name,
				physician_speciality,
				facility,
				address1,
				address2,
				phone,
				email,
				city,
				state,
				countyid,
				zip,
				physician_child_lang_check,
				translation_service_available,
				startdate,
				enddate,
				otherspeciality,
				degreetype,
				insertedby ,
				-- User who created this record
				insertedon,
				-- Record created date and time
				updatedby, 
				updatedon
				)
			values
				(	true,
					false,
					v_person_id,
					null,
					(v_providerinfo ->>'is_primary_care_physician')::boolean,
					v_providerinfo ->>'physician_name',
					v_providerinfo ->>'physician_speciality',
					v_providerinfo ->>'physician_facility',
					v_providerinfo ->>'address1',
					v_providerinfo ->>'address2',
					v_providerinfo ->>'physician_phone',
					v_providerinfo ->>'physician_email',
					v_providerinfo ->>'city',
					v_providerinfo ->>'state',
					( select countyid
						from county
					  where countyname = v_providerinfo ->>'county'),
					v_providerinfo ->>'zipcode',
					(v_providerinfo ->>'physician_child_lang_check')::boolean,
					(v_providerinfo ->>'translation_service_available')::boolean,
					(v_providerinfo ->>'start_Date')::timestamp,
					(v_providerinfo ->>'End_Date')::timestamp,
					v_providerinfo ->>'otherspeciality',
					v_providerinfo ->>'degreetype',
					v_insertedby::uuid,
					now(),
					v_insertedby::uuid,
					now()
				) returning personphycisianinfoid into v_personphycisianinfoid;

				select * into v_updatedocumentproperties from cjams.updatedocumentproperties(v_person_id, v_providerinfo -> 'uploadpath',v_personphycisianinfoid::varchar,'personphycisianinfo', null,v_insertedby);
			end loop;
		end if;

		if(v_providerinfodentist is not null) then 
			for v_providerinfo in select
				*
			from
				json_array_elements(v_providerinfodentist) loop insert
			into
				personphycisianinfo ( isphysician,
				isdentist,
				isprimaryphycisian,
				personid ,
				uploadpath,
				name,
				dental_speciality,
				facility,
				address1,
				address2,
				phone,
				email,
				city,
				state,
				countyid,
				zip,
				dentist_child_lang_check,
				translation_service_available,
				startdate,
				enddate,
				insertedby ,
				-- User who created this record
				insertedon,
				-- Record created date and time
				updatedby, 
				updatedon
				)
			values
				(	false,
					true,
					false,
					v_person_id,
					null,
					v_providerinfo ->>'dentist_name',
					v_providerinfo ->>'dentist_speciality',
					v_providerinfo ->>'dentist_facility',
					v_providerinfo ->>'dentist_address1',
					v_providerinfo ->>'dentist_address2',
					v_providerinfo ->>'dentist_phone',
					v_providerinfo ->>'dentist_email',
					v_providerinfo ->>'dentist_city',
					v_providerinfo ->>'dentist_state',
					(select countyid
						from county
					where countyname = v_providerinfo ->>'dentist_county'),
					v_providerinfo ->>'dentist_zipcode',
					(v_providerinfo ->>'dentist_child_lang_check')::boolean,
					(v_providerinfo ->>'translation_service_available')::boolean,
					(v_providerinfo ->>'start_Date')::timestamp,
					(v_providerinfo ->>'End_Date')::timestamp,
					v_insertedby::uuid,
					now(),
					v_insertedby::uuid,
					now()
				) returning personphycisianinfoid into v_personphycisianinfoid;

				select * into v_updatedocumentproperties from cjams.updatedocumentproperties(v_person_id, v_providerinfo -> 'uploadpath',v_personphycisianinfoid::varchar,'personphycisianinfo', null,v_insertedby);
			
			end loop;
		end if;

		if (v_medicalconditioninfojson is not null) then 
			for v_medicalconditioninfo in select
				*
			from
				json_array_elements(v_medicalconditioninfojson) loop 
			insert
			into
				personmedicalcondition ( personid ,
				uploadpath,
				medicalcondition,
				medicalcondition_icd10_desc,
				medicalcondition_icd10_key_id,
				begindate ,
				enddate ,
				recordedby,
				notes ,
				ischronic,
				allergies_adverse_reactions,
				medication_client_allergies,
				severitysymptomkey,
				ismedfragile,
				insertedby ,
				-- User who created this record
				insertedon,
				-- Record created date and time
				updatedby, 
				updatedon
				)
			values
				(	v_person_id,
					null,
					v_medicalconditioninfo -> 'medical_condition' ,
					v_medicalconditioninfo -> 'medicalcondition_icd10_desc' ,
					v_medicalconditioninfo -> 'medicalcondition_icd10_key_id' ,
					(v_medicalconditioninfo ->>'start_Date')::timestamp,
					(v_medicalconditioninfo ->>'End_Date')::timestamp,
					v_medicalconditioninfo ->> 'recordedby',
					v_medicalconditioninfo ->> 'notes',
					(v_medicalconditioninfo ->> 'ischronic')::boolean,
					v_medicalconditioninfo ->> 'allergies_adverse_reactions',
					v_medicalconditioninfo ->> 'medication_client_allergies',
					v_medicalconditioninfo ->> 'severitysymptomkey',
					(v_medicalconditioninfo ->> 'ismedfragile')::boolean,
					v_insertedby::uuid,
					now(),
					v_insertedby::uuid,
					now()					
				) returning personmedicalconditionid into v_personmedicalconditionid;

				select * into v_updatedocumentproperties from cjams.updatedocumentproperties(v_person_id, v_medicalconditioninfo -> 'uploadpath',v_personmedicalconditionid::varchar,'personmedicalcondition', null,v_insertedby);
			
			end loop;
		end if;

		if (v_mobilityspeechinfojson is not null) then
			for v_mobilityspeechinfo in select
				*
			from
				json_array_elements(v_mobilityspeechinfojson) loop insert
			into
				personhlthmobilityspeech ( personid ,
				uploadpath,
				providedname,
				relationship,
				ishousehold,
				iscollateral,
				ismbltyspchknown,
				mblty,
				speech,
				satupage,
				walkedage,
				talkedage,	
				comments,
				insertedby,
				insertedon,
				updatedby, 
				updatedon
				)
			values
				(	v_person_id,
					null,
					v_mobilityspeechinfo ->> 'provided_name' ,
					(v_mobilityspeechinfo ->>'relationship'),
					(v_mobilityspeechinfo ->>'ishousehold')::boolean ,
					(v_mobilityspeechinfo ->> 'iscollateral')::boolean,
					(v_mobilityspeechinfo ->> 'ismbltyspchknown')::boolean,
					v_mobilityspeechinfo -> 'Mobility' ,
					v_mobilityspeechinfo -> 'Speech' ,
					(v_mobilityspeechinfo ->> 'satupage')  ,
					(v_mobilityspeechinfo ->> 'walkedage') ,
					(v_mobilityspeechinfo ->> 'talkedage') ,
					v_mobilityspeechinfo ->> 'comments',
					v_insertedby::uuid,
					now(),
					v_insertedby::uuid,
					now()
				) returning personhlthmobilityspeechid into v_personhlthmobilityspeechid;

				select * into v_updatedocumentproperties from cjams.updatedocumentproperties(v_person_id, v_mobilityspeechinfo -> 'uploadpath',v_personhlthmobilityspeechid::varchar,'personhlthmobilityspeech', null,v_insertedby);
			
			end loop;
		end if;

		if (v_feedinginfojson is not null) then 
			for v_feedinginfo in select
				*
			from
				json_array_elements(v_feedinginfojson) loop insert
			into
				personhlthfeeding ( personid ,
				providedname,
				relationship ,
				ishousehold ,
				iscollateral ,
				isfeedinginfoknown ,
				diettype ,
				eatertype ,
				liquids ,
				solidfood ,
				feeding_position ,
				otherneeds ,
				typeofformula ,
				amountperfeeding ,
				schedule ,	       	
				comments,
				insertedby ,
				insertedon,
				uploadpath,
				updatedby, 
				updatedon
				)
			values
				(	v_person_id,
					v_feedinginfo ->> 'provided_name' ,
					(v_feedinginfo ->>'relationship'),
					(v_feedinginfo ->>'ishousehold')::boolean ,
					(v_feedinginfo ->> 'iscollateral')::boolean,
					coalesce(((v_feedinginfo ->> 'isfeedinginfoknown')::boolean),null),
					v_feedinginfo ->'diettype',
					v_feedinginfo ->'eatertype',
					v_feedinginfo ->'liquids',
					v_feedinginfo ->'solidfood',
					v_feedinginfo ->'feeding_position',
					v_feedinginfo ->'otherneeds',
					v_feedinginfo ->>'typeofformula',
					v_feedinginfo ->>'amountperfeeding',
					v_feedinginfo ->>'schedule',
					v_feedinginfo ->> 'comments',
					v_insertedby::uuid,
					now(),
					null,
					v_insertedby::uuid,
					now()
				) returning personhlthfeedingid into v_personhlthfeedingid;

				select * into v_updatedocumentproperties from cjams.updatedocumentproperties(v_person_id, v_feedinginfo -> 'uploadpath',v_personhlthfeedingid::varchar,'personhlthfeeding', null,v_insertedby);
			
			end loop;
		end if;

		if  (v_sleepinginfojson is not null) then
			for v_sleepinginfo in select
				*
			from
				json_array_elements(v_sleepinginfojson) loop insert
			into
				personhlthsleeping ( personid ,
				providedname,
				relationship ,
				ishousehold ,
				iscollateral ,
				issleepinginfoknown ,
				sleepingenvironment ,
				sleepingproblems ,
				sleepingposition ,
				sleepingschedule_naptime ,
				sleepingschedule_bedtime ,
				comments,
				insertedby,
				insertedon,
				otherspecify,
				updatedby, 
				updatedon
				)
			values
				(	v_person_id,
					v_sleepinginfo ->> 'provided_name' ,
					(v_sleepinginfo ->>'relationship'),
					(v_sleepinginfo ->>'ishousehold')::boolean ,
					(v_sleepinginfo ->> 'iscollateral')::boolean,
					(v_sleepinginfo ->> 'issleepinginfoknown')::boolean,
					v_sleepinginfo ->'sleepingenvironment',
					v_sleepinginfo ->'sleepingproblems',
					v_sleepinginfo ->'sleepingposition',
					(v_sleepinginfo ->>'sleepingschedule_naptime')::timestamp,
					(v_sleepinginfo ->>'sleepingschedule_bedtime') ::timestamp,
					v_sleepinginfo ->> 'comments',
					v_insertedby::uuid,
					now(),
					v_sleepinginfo ->> 'otherSpecify',
					v_insertedby::uuid,
					now()
				);
			end loop;
		end if;


		if (v_eliminationinfojson is not null) then 
			for v_eliminationinfo in select
				*
			from
				json_array_elements(v_eliminationinfojson) loop insert
			into
				personhlthelimination ( personid ,
				providedname,
				relationship ,
				ishousehold ,
				iscollateral ,
				iseliminationinfoknown,
				isspecialconsiderunknown,
				elimination_currentstatus,
				toilettrainingmethod,
				wordforBowelmovement,
				wordforUrination,
				comments,
				specialcomments,
				insertedby ,
				insertedon,
				otherspecify,
				updatedby, 
				updatedon
				)
			values
				(	v_person_id,
					v_eliminationinfo ->> 'infoprovidedname' ,
					(v_eliminationinfo ->>'relationship'),
					(v_eliminationinfo ->>'ishousehold')::boolean ,
					(v_eliminationinfo ->> 'iscollateral')::boolean,
					(v_eliminationinfo ->> 'eliminationinfounknown')::boolean,
					(v_eliminationinfo ->> 'considerunknown')::boolean,
					v_eliminationinfo ->'currentstatus',
					v_eliminationinfo ->'toilettraining',
					v_eliminationinfo ->>'bowelmovement',
					v_eliminationinfo ->>'urination',
					v_eliminationinfo ->> 'toiletcomments',
					v_eliminationinfo ->> 'specialcomments',
					v_insertedby::uuid,
					now(),
					v_eliminationinfo ->> 'otherSpecify',
					v_insertedby::uuid,
					now()
				);
			end loop;
		end if;

	elseif (isnew = 0) then
		-- Isnew = 0
		for v_chronicinfo in select
			*
		from
			json_array_elements(v_chronicinfojson) loop
		update clientchronicinfo cci
		set activeflag = 0,
			updatedby = v_insertedby::uuid, 
			updatedon = now()
		where cci.personid = v_person_id 
			and cci.clientchronicinfoid = (v_chronicinfo ->> 'clientchronicinfoid'):: uuid;


		insert
		into
			clientchronicinfo ( clientchronicinfoid,
			personid,
			chronicinfoflag,
			chronichighriskflag,
			physicalproblem,
			mentalproblem,
			physicalproblemtx,
			mentalproblemtx,
			chroniccommentstx,
			activeflag,
			insertedby,
			insertedon,
			updatedby,
			updatedon 
			)
		values 
			(	gen_random_uuid(),
				v_person_id,
				case
					when (v_chronicinfo ->> 'noknownchronic') = 'true' then 1
					else 0
				end,
				case
					when (v_chronicinfo ->> 'highriskmentaldisease') = 'true' then 1
					else 0
				end,
				v_chronicinfo -> 'physicalkey',
				v_chronicinfo -> 'mentalkey' ,
				v_chronicinfo ->> 'physicalcomments',
				v_chronicinfo ->> 'mentalcomments',
				v_chronicinfo ->> 'comments',
				1,
				v_insertedby::uuid,
				now(),
				v_insertedby::uuid,
				now() 
			);
		end loop;

		if (v_allergiesinfojson is not null) then 
			for v_allergiesinfo in select
				*
			from
				json_array_elements(v_allergiesinfojson) loop
			update personallergiesinfo pai
			set	activeflag = 0,
				updatedby = v_insertedby::uuid, 
				updatedon = now()
			where pai.personid = v_person_id 
				and pai.personallergiesinfoid = (v_allergiesinfo ->> 'personallergiesinfoid'):: uuid;

			insert into
				personallergiesinfo ( personid,
					providedbyclientid,
					providedbycollateralid,
					infoclienttypekey,
					allergy,
					specialneed,
					hygine,
					phobia,
					medicationallergy,
					allergycomments,
					insertedon,
					insertedby,
					activeflag,
					providedbynotes,
					providedbyrelationtypekey,
					expungementflag,
					clientmergeid,
					adversecomments,
					specialneedcomments,
					hygienecomments,
					phobiacomments,
					updatedby, 
					updatedon
				)
			values
				(	v_person_id,
					(v_allergiesinfo ->> 'providedbyclientid')::integer,
					(v_allergiesinfo ->> 'providedbycollateralid')::integer,
					v_allergiesinfo ->> 'infoclienttypekey',
					v_allergiesinfo -> 'allergy',
					v_allergiesinfo -> 'specialneed',
					v_allergiesinfo -> 'hygine',
					v_allergiesinfo -> 'phobia',
					v_allergiesinfo ->> 'medicationallergy',
					v_allergiesinfo ->> 'allergycomments',
					now(),
					v_insertedby::uuid,
					1,
					v_allergiesinfo ->> 'providedbynotes',
					v_allergiesinfo ->> 'providedbyrelationtypekey',
					( v_allergiesinfo ->> 'expungementflag')::integer,
					( v_allergiesinfo ->> 'clientmergeid')::uuid,
					v_allergiesinfo ->> 'adversecomments',
					v_allergiesinfo ->> 'specialneedcomments',
					v_allergiesinfo ->> 'hygienecomments',
					v_allergiesinfo ->> 'phobiacomments',
					v_insertedby::uuid,
					now() 
				);
			end loop;
		end if;

		if (v_behaviourinfojson is not null) then 
			for v_behaviourinfo in select
				*
			from
				json_array_elements(v_behaviourinfojson) loop 
			update personbehavioralhealth 
			set	activeflag = 0,
				updatedby = v_insertedby::uuid, 
				updatedon = now()
			where personid = v_person_id 
				and personbehavioralhealthid = (v_behaviourinfo ->> 'personbehavioralhealthid')::uuid ;
	
			INSERT INTO cjams.personbehavioralhealth
				(	parentbehaviouralhealthid, personid, uploadpath, clinicianname, currentdiagnoses, phone, address1, 
					address2, reportname, city, state, county, zip, activeflag, insertedby, insertedon, reportpath, 
					isbehavioralhealth, typeofservice, dateofevaluation, evaluationby, nodiagnosisreason, email,
					phobiakey, phobiacomments, updatedby, updatedon
				)
			VALUES
				(	v_behaviourhealthid, v_person_id,
					null,
					v_behaviourinfo  ->> 'clinicianname',
					v_behaviourinfo  ->> 'currentdiagnosis',
					v_behaviourinfo  ->> 'phonenumber',
					v_behaviourinfo  ->> 'address1',
					v_behaviourinfo  ->> 'address2',
					v_behaviourinfo  ->> 'reportname',
					v_behaviourinfo  ->> 'city',
					v_behaviourinfo  ->> 'state',
					v_behaviourinfo  ->> 'county',
					v_behaviourinfo  ->> 'zipcode',
					1,
					v_insertedby,
					now(),
					v_behaviourinfo  ->> 'reportpath',
					(v_behaviourinfo  ->> 'isbehaviouraldiagnosis')::bool,
					v_behaviourinfo  -> 'typeofservice',
					(v_behaviourinfo  ->> 'dateofevaluation')::timestamp,
					v_behaviourinfo  ->> 'evaluationby',
					v_behaviourinfo  ->> 'nodiagnosisreason',
					v_behaviourinfo  ->> 'email',
					v_behaviourinfo  -> 'phobiakey',
					v_behaviourinfo  ->> 'phobiacomments',
					v_insertedby,
					now()
				) returning personbehavioralhealthid into v_personbehavioralhealthid;

				select * into v_updatedocumentproperties from cjams.updatedocumentproperties(v_person_id, v_behaviourinfo -> 'uploadpath',v_personbehavioralhealthid::varchar,'personbehavioralhealth', null,v_insertedby);
			end loop;
		end if;

		if (v_birthhealthinfojson is not null) then 
			update birthhealthinfo bhi
			set activeflag = 0,
				updatedby = v_insertedby::uuid, 
				updatedon = now()
			where bhi.personid = v_person_id;

			--for v_birthhealthinfo in select
			--	*
			--from
			--	json_array_elements(v_birthhealthinfojson) loop
	
			v_birthhealthbirthjson := v_birthhealthinfojson ->> 'birth';
			v_birthhealthunderfivejson := v_birthhealthinfojson ->> 'underfive';
			raise notice 'v_birthhealthbirthjson%',v_birthhealthbirthjson;
			raise notice 'v_birthhealthunderfivejson%',v_birthhealthunderfivejson;
	
			insert 
			into
				birthhealthinfo ( personid,
				mothersusepregnant,
				mothersusepregnantspecify,
				mentalcondition,
				mentalconditionspecify,
				diseasescondition,
				diseasesconditionspecify,
				birthdefects,
				"comments",
				insertedby,
				insertedon,
				updatedby, 
				updatedon
				)
			values
				(	v_person_id,
					v_birthhealthbirthjson -> 'mothersusepregnant',
					v_birthhealthbirthjson ->> 'mothersusepregnantspecify',
					v_birthhealthbirthjson -> 'mentalcondition',
					v_birthhealthbirthjson ->> 'mentalconditionspecify',
					v_birthhealthbirthjson -> 'diseasescondition',
					v_birthhealthbirthjson ->> 'diseasesconditionspecify',
					v_birthhealthbirthjson ->> 'birthdefects',
					v_birthhealthbirthjson ->> 'comments',
					v_insertedby,
					now(),
					v_insertedby,
					now()
				);
		
			insert into clientunder5yearsinfo 
				(	personid, uploadpath, prenatalcaretypekey, prenatalproblemspecify, gestation, parentcare, 
					deliverytypekey, hospitalname, address1, address2, phone, email, cityname, statetypekey, county,
					zip5no, deliverycomplicationnotes, complicationsspecify, comments, hospitalcomments, parity,
					complications, speciality, whenbegun, insertedby, insertedon, updatedby, updatedon
				) 
			values 
				(	v_person_id,	
					null,
					v_birthhealthunderfivejson ->> 'prenatalproblem',
					v_birthhealthunderfivejson ->> 'prenatalproblemspecify',
					v_birthhealthunderfivejson -> 'gestation',
					v_birthhealthunderfivejson -> 'parentcare',
					v_birthhealthunderfivejson ->> 'deliverytype',
					v_birthhealthunderfivejson ->> 'childbornin',
					v_birthhealthunderfivejson ->> 'address1',
					v_birthhealthunderfivejson ->> 'address2',
					v_birthhealthunderfivejson ->> 'phone',
					v_birthhealthunderfivejson ->> 'email',
					v_birthhealthunderfivejson ->> 'city',
					v_birthhealthunderfivejson ->> 'state',
					v_birthhealthunderfivejson ->> 'county',
					(v_birthhealthunderfivejson ->> 'zip5no')::numeric,
					v_birthhealthunderfivejson ->> 'deliverycomplicationnotes',
					v_birthhealthunderfivejson ->> 'complicationsspecify',
					v_birthhealthunderfivejson ->> 'comments',
					v_birthhealthunderfivejson ->> 'hospitalcomments',
					v_birthhealthunderfivejson ->> 'parity',
					v_birthhealthunderfivejson -> 'complications',
					v_birthhealthunderfivejson ->> 'speciality',
					v_birthhealthunderfivejson ->> 'whenbegun',
					v_insertedby,
					now(),
					v_insertedby,
					now()
				) returning clientunder5yearsinfoid into v_clientunder5yearsinfoid;

				select * into v_updatedocumentproperties from cjams.updatedocumentproperties(v_person_id, v_birthhealthunderfivejson -> 'uploadpath',v_clientunder5yearsinfoid::varchar,'clientunder5yearsinfo', null,v_insertedby);
			
		end if;

		if (v_substanceabusejson is not null) then 
			for v_substanceabuse in select
				*
			from
				json_array_elements(v_substanceabusejson) loop
			update personabusesubstance pas
			set activeflag = 0,
				updatedby = v_insertedby::uuid, 
				updatedon = now()
			where personid = v_person_id 
				and  pas.personabusesubstanceid = (v_substanceabuse ->> 'personabusesubstanceid'):: uuid;


			INSERT INTO personabusesubstance
				(	parentabusesubstanceid,
					personid, 
					isusetobacco, 
					isusedrugoralcohol, 
					isusedrug,
					isusealcohol, 
					drugfrequencydetails, 
					drugageatfirstuse,
					alcoholfrequencydetails,
					alcoholageatfirstuse,
					drugoralcoholproblems, 
					ischildhassextraffichistory,
					issextraffichistoryreported,
					sextraffichistoryreportedon,
					ischildhassextraffic,
					issextrafficreported,
					sextrafficreportedon,
					nochangesinsextraffic,
					activeflag, 
					insertedby, 
					insertedon,
					tobaccoageatfirstuse, 
					tobaccofrequencydetails,
					uploadpath,
					updatedby, 
					updatedon
				)
			VALUES
				( 
					v_behaviourhealthid,
					v_person_id,
					( v_substanceabuse  ->> 'isusetobacco')::bool,
					( v_substanceabuse  ->> 'isusedrugoralcohol')::bool,
					(v_substanceabuse  ->> 'isusedrug')::bool,
					(v_substanceabuse  ->> 'isusealcohol')::bool,
					v_substanceabuse  ->> 'drugfrequencydetails',
					v_substanceabuse  ->> 'drugageatfirstuse',
					v_substanceabuse  ->> 'alcoholfrequencydetails',
					v_substanceabuse  ->> 'alcoholageatfirstuse',
					v_substanceabuse  ->> 'drugoralcoholproblems',
					( v_substanceabuse  ->> 'ischildhassextraffichistory')::bool,
					( v_substanceabuse  ->> 'issextraffichistoryreported')::bool,
					( v_substanceabuse  ->> 'sextraffichistoryreportedon')::date,
					( v_substanceabuse  ->> 'ischildhassextraffic')::bool,
					( v_substanceabuse  ->> 'issextrafficreported')::bool,
					( v_substanceabuse  ->> 'sextrafficreportedon')::date,
					( v_substanceabuse  ->> 'nochangesinsextraffic')::bool,
					1,
					v_insertedby::uuid,
					now(),
					v_substanceabuse  ->> 'tobaccoageatfirstuse',
					v_substanceabuse  ->> 'tobaccofrequencydetails',
					null,
					v_insertedby::uuid,
					now()
				) returning personabusesubstanceid into v_personabusesubstanceid;

				select * into v_updatedocumentproperties from cjams.updatedocumentproperties(v_person_id, v_substanceabuse -> 'uploadpath',v_personabusesubstanceid::varchar,'personabusesubstance', null,v_insertedby);
	 
			end loop;
		end if;

		if (v_medicalpsychotropicinfojson is not null) then
			for v_medicalpsychotropicinfo in select
				*
			from
				json_array_elements(v_medicalpsychotropicinfojson) loop
			update personmedicpshychotropic 
			set	personid =v_person_id,
			isprescribedmedication=( v_medicalpsychotropicinfo  ->> 'isprescribedmedication')::bool,
			prescriptionreasontypekey=( v_medicalpsychotropicinfo  ->> 'prescriptionreasontypekey'),
			medicationname=v_medicalpsychotropicinfo  ->> 'medicationname',
			medicationtype=v_medicalpsychotropicinfo  ->> 'medicationtype',
			prescribedduration=v_medicalpsychotropicinfo  ->> 'prescribedduration',
			prescribedreason=v_medicalpsychotropicinfo  ->> 'prescribedreason',
			medicationeffectivedate=( v_medicalpsychotropicinfo  ->> 'medicationeffectivedate')::timestamp,
			medicationexpirationdate=( v_medicalpsychotropicinfo  ->> 'medicationexpirationdate')::timestamp,
			dosage=v_medicalpsychotropicinfo  ->> 'dosage',
			frequency=v_medicalpsychotropicinfo  ->> 'frequency',
			lastdosetakendate=( v_medicalpsychotropicinfo  ->> 'lastdosetakendate')::timestamp,
			medicationcomments=v_medicalpsychotropicinfo  ->> 'medicationcomments',
			informationsourcetypekey=v_medicalpsychotropicinfo  ->> 'informationsourcetypekey',
			effectivedate=now(),
			startdate=( v_medicalpsychotropicinfo  ->> 'startdate')::timestamp,
			enddate=( v_medicalpsychotropicinfo  ->> 'enddate')::timestamp,
			expirationdate=( v_medicalpsychotropicinfo  ->> 'expirationdate')::timestamp,
			compliant=( v_medicalpsychotropicinfo  ->> 'compliant')::int,
			reportedby=v_medicalpsychotropicinfo  ->> 'reportedby',
			monitoring=v_medicalpsychotropicinfo  ->> 'monitoring',
			prescribingdoctor=v_medicalpsychotropicinfo  ->> 'prescribingdoctor',
				updatedby = v_insertedby::uuid, 
				updatedon = now(),
				ismedicationpsychotropic=(v_medicalpsychotropicinfo  ->> 'ismedicationpsychotropic')::bool,
					classification = v_medicalpsychotropicinfo  ->> 'classification',
					diagnosis = v_medicalpsychotropicinfo  ->> 'diagnosis',
					uploadedFiles=null,
					targetedsymptoms=v_medicalpsychotropicinfo  ->> 'targetedsymptoms',
					targetedother=v_medicalpsychotropicinfo   ->> 'targetedother',
					renewal=(v_medicalpsychotropicinfo  ->> 'renewal')::bool,
					informedconsent=v_medicalpsychotropicinfo   ->> 'informedconsent',
					otherreason=v_medicalpsychotropicinfo   ->> 'otherreason',
					dateMedicationStarted=( v_medicalpsychotropicinfo  ->> 'datemedicationstarted')::timestamp,
					isPrescriberCheck=(v_medicalpsychotropicinfo  ->> 'isprescribercheck')::bool,
					compliantcomments=v_medicalpsychotropicinfo  ->> 'compliantcomments',
					dateofrefill=(v_medicalpsychotropicinfo  ->> 'dateofrefill')::date,
					changeofdate=(v_medicalpsychotropicinfo  ->> 'changeofdate')::date,
					specifyfrequencyhour=v_medicalpsychotropicinfo  ->> 'specifyfrequencyhour',
					specifyduration=v_medicalpsychotropicinfo  ->> 'specifyduration',
					otherspecifyduration=v_medicalpsychotropicinfo  ->> 'otherspecifyduration',
					diagnosisfromsecond=v_medicalpsychotropicinfo  ->> 'diagnosisfromsecond',
					diagnosisotherfromsecond=v_medicalpsychotropicinfo  ->> 'diagnosisotherfromsecond',
					psychosocialinterventions=v_medicalpsychotropicinfo  ->> 'psychosocialinterventions',
					additionalpsychosocialinterventions=v_medicalpsychotropicinfo  ->> 'additionalpsychosocialinterventions',
					otheradditionalpsychosocialinterventions=v_medicalpsychotropicinfo  ->> 'otheradditionalpsychosocialinterventions',
					prescribercontactinfo=v_medicalpsychotropicinfo  ->> 'prescribercontactinfo',
					prescriberemail=v_medicalpsychotropicinfo  ->> 'prescriberemail',
					prescriberdegree=v_medicalpsychotropicinfo  ->> 'prescriberdegree',
					otherprescriberdegree=v_medicalpsychotropicinfo  ->> 'otherprescriberdegree',
					prescriberspecialty=v_medicalpsychotropicinfo  ->> 'prescriberspecialty',
					otherprescriberspecialty=v_medicalpsychotropicinfo  ->> 'otherprescriberspecialty',
					settingmedicationprescribed=v_medicalpsychotropicinfo  ->> 'settingmedicationprescribed',
					secondaryreviewcompleted =(v_medicalpsychotropicinfo  ->> 'secondaryreviewcompleted')::bool,
					pshychotropicid =(v_medicalpsychotropicinfo  ->> 'pshychotropicid'),
					personmedicpshychotropicparentid = NULLIF(v_medicalpsychotropicinfo ->> 'personmedicpshychotropicparentid', '')::uuid
			where personid = v_person_id 
				and personmedicpshychotropicid = (v_medicalpsychotropicinfo ->> 'personmedicpshychotropicid')::uuid
returning personmedicpshychotropicid into v_personmedicpshychotropicid;

			update personmedicpshychotropic
			set medicationexpirationdate = (v_medicalpsychotropicinfo ->> 'medicationexpirationdate')::timestamp,
				expirationdate = (v_medicalpsychotropicinfo ->> 'expirationdate')::timestamp,
				updatedby = v_insertedby::uuid,
				updatedon = now()
			where personmedicpshychotropicparentid = v_personmedicpshychotropicid;

response = v_personmedicpshychotropicid::character varying;
				select * into v_updatedocumentproperties from cjams.updatedocumentproperties(v_person_id, (v_medicalpsychotropicinfo ->> 'uploadedFiles')::json,v_personmedicpshychotropicid::varchar,'personmedicpshychotropic', null,v_insertedby);
  
			end loop;
		end if;

		if (v_familyhistoryinfojson is not null) then 
			for v_familyhistoryinfo in select
				*
			from
				json_array_elements(v_familyhistoryinfojson) loop 
			update personfmlymdclhstry pfh
			set activeflag = 0,
				updatedby = v_insertedby::uuid, 
				updatedon = now()
			where pfh.personid = v_person_id 
				and pfh.personfmlymdclhstryid = (v_familyhistoryinfo ->> 'personfmlymdcl_hstryid'):: uuid ;	
	
			insert
			into
				personfmlymdclhstry ( personid ,
					famhistclient ,
					famhistrelationtype ,
					majorhistoryproblem ,
					deathcausetype ,
					"comments" ,
					uploadpath,
					updatedby,
					-- User who created this record
					updatedon,
					-- Record created date and time
					insertedby, 
					insertedon
				)
			values
				(	v_person_id,
					v_familyhistoryinfo ->> 'clientlist',
					v_familyhistoryinfo ->> 'Relationship',
					v_familyhistoryinfo ->> 'major_health_problems',
					v_familyhistoryinfo ->> 'cause_of_death',
					v_familyhistoryinfo ->> 'comments',
					null,
					v_insertedby::uuid,
					now(),
					v_insertedby::uuid,
					now()
				) returning personfmlymdclhstryid into v_personfmlymdclhstryid ;

			select * into v_updatedocumentproperties from cjams.updatedocumentproperties(v_person_id, v_familyhistoryinfo -> 'uploadpath',v_personfmlymdclhstryid::varchar,'personfmlymdclhstry', null,v_insertedby);
			
			end loop;
		end if;

		if (v_hospitalizationinfojson is not null) then 
			for v_hospitalizationinfo in select
				*
			from
				json_array_elements(v_hospitalizationinfojson) loop 
			UPDATE cjams.personhospitalization phsp
                  SET startdt=to_date(v_hospitalizationinfo ->> 'start_Date' , 'YYYY-MM-DD'), enddt=to_date(v_hospitalizationinfo ->> 'end_Date' , 'YYYY-MM-DD'),
				  starttime = v_hospitalizationinfo ->> 'starttime', endtime=v_hospitalizationinfo ->> 'endtime', diagnosistx=v_hospitalizationinfo ->> 'Reason_or_diagnosis',
				  updatedby = v_insertedby::uuid, updatedon=now(),
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
				  hospital_country=v_hospitalizationinfo ->> 'hospital_country', 
				  hospital_dischargerecommendation=v_hospitalizationinfo ->> 'Hospital_DischargeRecommendation',
				  Actual_Placement_After_Discharge =v_hospitalizationinfo ->>'Actual_Placement_After_Discharge',
				  hospital_reasonforovrstay=v_hospitalizationinfo ->> 'Hospital_ReasonForOvrStay', hospital_denialsbyproviders=v_hospitalizationinfo ->> 'Hospital_DenialsByProviders',
				  hospital_lengthofoverstay=v_hospitalizationinfo ->> 'Hospital_LengthOfOverstay', 
				  hospital_grouphome=v_hospitalizationinfo ->> 'Hospital_GroupHome', hospital_cityname=v_hospitalizationinfo ->> 'hospital_cityname',
				  hospital_statename=v_hospitalizationinfo ->> 'hospital_statename', hospital_zipcode1=v_hospitalizationinfo ->> 'hospital_zipcode1', 
				  hospitalization_reasonforhospitalization_others=v_hospitalizationinfo ->> 'hospitalization_reasonForHospitalization_others', 
				  durationdays=v_hospitalizationinfo ->> 'durationdays', medicalnecessitydays=v_hospitalizationinfo ->> 'medicalnecessitydays', hospital_room=v_hospitalizationinfo ->> 'hospital_room', 
				  hospital_roomphoneno=v_hospitalizationinfo ->> 'hospital_roomphoneno'
                  WHERE phsp.personid = v_person_id 
				  and phsp.hospitalizationid = (v_hospitalizationinfo ->> 'hospitalizationid'):: uuid;

				response = (v_hospitalizationinfo ->> 'hospitalizationid')::character varying;

				raise notice 'providerinfoflag 1903%', v_hospitalizationinfo ->> 'hospitalizationid';

				raise notice 'providerinfoflag 1905 %', v_person_id;

				select * into flag from cjams.generate_audit_data('personhospitalization', (v_hospitalizationinfo ->> 'hospitalizationid')::uuid);

				select * into v_updatedocumentproperties from cjams.updatedocumentproperties(v_person_id, v_hospitalizationinfo -> 'uploadpath',(v_hospitalizationinfo ->> 'hospitalizationid')::varchar,'personhospitalization', null,v_insertedby);
			
			end loop;
		end if;

		if (v_healthinsuranceinfojson is not null) then 
			for v_healthinsuranceinfo in select
				*
			from
				json_array_elements(v_healthinsuranceinfojson) loop
			update personhealthinsurance phi
			set	activeflag = 0,
				updatedby = v_insertedby::uuid, 
				updatedon = now()
			where phi.personid = v_person_id 
				and phi.personhealthinsuranceid = ( v_healthinsuranceinfo ->> 'personhealthinsuranceid'):: uuid;

			insert
			into
				personhealthinsurance ( personid,
					isinsuranceavailable,
					insurancetype,
					policyholdername,
					medicalinsuranceprovider,
					patientpolicyholderrelation,
					providertype,
					providerphone,
					policynumber,
					managedcareorganization,
					groupnumber,
					effectivedate,
					expirationdate,
					address1,
					address2,
					city,
					state,
					county,
					zip,
					uploadpath,
					activeflag,
					ismedicaidmedicare,
					insertedby,
					insertedon,
					updatedby,
					updatedon,
					medicarenumber,
					caresmatypekey,
					medicaidstartdate,
					medicaidenddate,
					providedbynotes
				)
			values
				(	v_person_id,
					true,
					v_healthinsuranceinfo ->> 'insurancetype',
					v_healthinsuranceinfo ->> 'policyholdername',
					v_healthinsuranceinfo ->> 'medicalinsuranceprovider',
					v_healthinsuranceinfo ->> 'patientpolicyholderrelation',
					v_healthinsuranceinfo ->> 'providertype',
					v_healthinsuranceinfo ->> 'providerphone',
					v_healthinsuranceinfo ->> 'policynumber',
					v_healthinsuranceinfo ->> 'managedcareorganization',
					v_healthinsuranceinfo ->> 'groupnumber',
					(v_healthinsuranceinfo ->> 'startdate')::timestamp without time zone,
					(v_healthinsuranceinfo ->> 'enddate')::timestamp without time zone,
					v_healthinsuranceinfo ->> 'address1',
					v_healthinsuranceinfo ->> 'address2',
					v_healthinsuranceinfo ->> 'city',
					v_healthinsuranceinfo ->> 'state',
					v_healthinsuranceinfo ->> 'county',
					v_healthinsuranceinfo ->> 'zip',
					null,
					1,
					(v_healthinsuranceinfo ->> 'ismedicaidmedicare')::boolean,
					v_insertedby,
					now(),
					v_insertedby,
					now(),
					v_healthinsuranceinfo ->> 'medicarenumber',
					v_healthinsuranceinfo ->> 'caresmatypekey',
					(v_healthinsuranceinfo ->> 'medicaidstartdate')::timestamp without time zone,
					(v_healthinsuranceinfo ->> 'medicaidenddate')::timestamp without time zone, 
					v_healthinsuranceinfo ->> 'providedbynotes'
				) returning personhealthinsuranceid into v_personhealthinsuranceid;

				select * into v_updatedocumentproperties from cjams.updatedocumentproperties(v_person_id, v_healthinsuranceinfo -> 'uploadpath',v_personhealthinsuranceid::varchar,'personhealthinsurance', null,v_insertedby);
			
			end loop;
		end if;

		if (v_reproductivehealthinfojson is not null) then 
			for v_reproductivehealthinfo in select
				*
			from
				json_array_elements(v_reproductivehealthinfojson) loop
			update personsexualinfo psi
			set	activeflag = 0,
				updatedby = v_insertedby::uuid, 
				updatedon = now()
			where psi.personid = v_person_id 
				and psi.personsexualinfoid = (v_reproductivehealthinfo ->> 'personsexualinfoid')::uuid ;
	
			insert
			into
				personsexualinfo ( personsexualinfoid,
					personid,
					uploadpath,
					sexualactiveflag,
					ispregnant,
					childrenno,
					pregnancyno,
					sextransdis,
					std_treatment_startdate,				
					std_treatment_enddate,
					birthcontrol,
					stdspecify,
					bcspecify,
					sicomments,
					insertedby,
					insertedon,
					updatedby,
					updatedon,
					genderidentity,
					genderidentityspecify,
					birthcontroldate,
					sexualorientationcomments,
					specify,
					sexualorientationkey,
					pregnancyduedate,
					ispregnancyduedateunknown,
					currentlyparenting,
					notparentingreason,
					isfatheredachild,
					currentlyparentingother,
					notparentingotherreason,
					isgivenbirth
				)
			values
				(	gen_random_uuid(),
					v_person_id,
					null,
					case v_reproductivehealthinfo ->> 'sexualactiveflag' when 'Yes' THEN 1 WHEN 'No' THEN 0 ELSE 2 END,
					--		(v_reproductivehealthinfo ->> 'sexualactiveflag')::integer,
					(v_reproductivehealthinfo ->> 'ispregnant')::boolean,
					(v_reproductivehealthinfo ->> 'childrenno')::integer,
					(v_reproductivehealthinfo ->> 'pregnancyno')::integer,
					v_reproductivehealthinfo ->> 'sextransdis',
					case when(v_reproductivehealthinfo ->> 'std_treatment_startdate') is null then null else
					to_date(v_reproductivehealthinfo ->> 'std_treatment_startdate' ,'MM/DD/YYYY') end,
					case when(v_reproductivehealthinfo ->> 'std_treatment_enddate') is null then null else
					to_date(v_reproductivehealthinfo ->> 'std_treatment_enddate' ,'MM/DD/YYYY') end,
					v_reproductivehealthinfo ->> 'birthcontrol',
					v_reproductivehealthinfo ->> 'stdspecify',
					v_reproductivehealthinfo ->> 'bcspecify',
					v_reproductivehealthinfo ->> 'sicomments',
					v_insertedby,
					now(),
					v_insertedby,
					now() ,
					v_reproductivehealthinfo ->> 'genderidentity',
					v_reproductivehealthinfo ->> 'genderidentityspecify',
					case when(v_reproductivehealthinfo ->> 'birthcontroldate') is null then null else
					to_date(v_reproductivehealthinfo ->> 'birthcontroldate' ,'MM/DD/YYYY') end,
					v_reproductivehealthinfo ->> 'sexualorientationcomments',
					v_reproductivehealthinfo ->> 'specify',
					v_reproductivehealthinfo ->> 'sexualorientationkey',
					(v_reproductivehealthinfo ->> 'pregnancyduedate')::timestamp ,
					(v_reproductivehealthinfo ->> 'ispregnancyduedateunknown')::boolean,
					(v_reproductivehealthinfo ->> 'currentlyparenting')::boolean,
					(v_reproductivehealthinfo ->> 'notparentingreason')::character varying,
					(v_reproductivehealthinfo ->> 'isfatheredachild')::boolean,
					(v_reproductivehealthinfo ->> 'currentlyparentingother')::boolean,
					(v_reproductivehealthinfo ->> 'notparentingotherreason')::text,
					(v_reproductivehealthinfo ->> 'isgivenbirth')::boolean
				) returning personsexualinfoid into v_personsexualinfoid;

				select * into v_updatedocumentproperties from cjams.updatedocumentproperties(v_person_id, v_reproductivehealthinfo -> 'uploadpath',v_personsexualinfoid::varchar,'personsexualinfo', null,v_insertedby);
	 
				if((v_reproductivehealthinfo ->> 'servicecaseid') is not null 
					and ((v_reproductivehealthinfo ->> 'pregnancyduedate')::timestamp) is not null 
						and date((v_reproductivehealthinfo ->> 'pregnancyduedate')::timestamp) < date(now()) ) then 
		
					with person_person_info as (
					select concat(firstname, ' ', lastname) as name, cjamspid 
						from person 
					where personid = v_person_id
					)
					SELECT send_notification INTO v_status 
						FROM send_notification
							(	v_insertedby
								, v_insertedby
								, v_insertedby
								, 'System'
								, 'High'
								, concat('Case ', (v_reproductivehealthinfo ->> 'servicecaseid')::character varying, ', Due Date has been passed for the client ', (select name from person_person_info), '(', (select cjamspid from person_person_info), '), Please update the "Currenlty Pregnant" statu. Also add the new born to the case as a client as applicable')
								, concat('Case ', (v_reproductivehealthinfo ->> 'servicecaseid')::character varying, ', Due Date has been passed for the client ', (select name from person_person_info), '(', (select cjamspid from person_person_info), '), Please update the "Currenlty Pregnant" statu. Also add the new born to the case as a client as applicable')
								, (v_reproductivehealthinfo ->> 'servicecaseid')::character varying
							);                                                                              
			
				end if;
			end loop;
		end if;

		if (v_personExaminationinfojson is not null) then 
			for v_personExaminationinfo in select
				*
			from
				json_array_elements(v_personExaminationinfojson) loop 
				--raise notice 'v_personExaminationinfo%',v_personExaminationinfo ->> 'appointment';
				v_personExaminationappointmentjson := v_personExaminationinfo ->> 'appointment';
				v_personExaminationPhysicianinfo := v_personExaminationinfo ->> 'physician';
				raise notice 'v_personExaminationinfo%',v_personExaminationinfo;
				raise notice 'providerinfoflag%',v_personExaminationinfo ->> 'providerinfoflag';
				v_personexaminationid := gen_random_uuid();
				v_parentexaminationid := gen_random_uuid();				
				for v_personExaminationappointment in select
					*
				from
					json_array_elements(v_personExaminationappointmentjson) loop 
					raise notice 'v_personExaminationinfo%',v_personExaminationinfo ->> 'personexaminationid';
					update personexamination pe
					set activeflag = 0,
						updatedby = v_insertedby::uuid, 
						updatedon = now()
					where pe.personid = v_person_id 
						and pe.personexaminationid=(v_personExaminationinfo ->> 'personexaminationid')::uuid;

					insert into cjams.personexamination ( 
						personexaminationid,
						parentexaminationid,
						appoinmentdate,
						starttime,
						endtime,
						nextappointmentdate,
						examinationtypekey,
						casenumber,
						labtesttypekey,
						specialityexamtypekey,
						appointkeptflag,
						hivconsentflag,
						physicianspeciality,
						affiliateorg,
						physicianname,
						recommendations,
						comments,
						address1,
						address2,
						cityname,
						statetypekey,
						countytypekey,
						zip5no,
						workphone,
						email,
						personid,
						insertedon,
						insertedby,
						nextappointmentreason,
						authformcompletion,
					    notcompletedauthform,
						provcaremissed,
						otherreason,
						notkeptreason,
						uploadpath,
						providerinfoflag,
						followupneeded,
						medicalreferrals,
						covidimpacted, 
						exposedtocovid, 
						covidtestconducted, 
						typeoftest, 
						covidtestresults, 
						covidtestdate,
						updatedby, 
						updatedon,
						timeframe,
						labtestother,
						specialityexamother,
						physicianfaxnumber,
						isannualhealthvisit,
						issemiannualdentalvisit
						)
					values
						(	v_personexaminationid,
							v_parentexaminationid,
							(v_personExaminationappointment ->> 'apptDate')::timestamp,
							v_personExaminationappointment ->> 'starttime',
							v_personExaminationappointment ->> 'endtime',
							(v_personExaminationappointment ->> 'nextApptDate')::timestamp,
							v_personExaminationappointment ->> 'natureofexamkey',
							v_personExaminationappointment ->> 'casenumber',
							(v_personExaminationappointment ->> 'labtestkey')::json,
							v_personExaminationappointment ->> 'specialityexamkey',
							(v_personExaminationappointment ->> 'apptkept')::int,
							case
							when (v_personExaminationappointment ->> 'hivtestreceived')::boolean = true then 1
							else 0
							end,
							v_personExaminationPhysicianinfo ->> 'speciality',
							v_personExaminationPhysicianinfo ->> 'affilication',
							v_personExaminationPhysicianinfo ->> 'physicianname',
							v_personExaminationPhysicianinfo ->> 'recommendations',
							v_personExaminationPhysicianinfo ->> 'comments',
							v_personExaminationPhysicianinfo ->> 'address1',
							v_personExaminationPhysicianinfo ->> 'address2',
							v_personExaminationPhysicianinfo ->> 'city',
							v_personExaminationPhysicianinfo ->> 'state',
							v_personExaminationPhysicianinfo ->> 'county',
							( v_personExaminationPhysicianinfo ->> 'zip')::numeric,
							v_personExaminationPhysicianinfo ->> 'phone',
							v_personExaminationPhysicianinfo ->> 'email',
							v_person_id,
							now(),
							v_insertedby::uuid,
							v_personExaminationappointment ->> 'nextappointmentreason',
							v_personExaminationappointment ->> 'authformcompletion',
					        v_personExaminationappointment ->> 'notcompletedauthform',
							v_personExaminationappointment ->> 'provcaremissed',
							v_personExaminationappointment ->> 'otherreason',
							v_personExaminationappointment ->> 'notkeptreason',
							null,
							case
							when (v_personExaminationinfo ->> 'providerinfoflag') = 'true' then 1
							else 0
							end,		 
							v_personExaminationPhysicianinfo ->> 'followupneeded',
							v_personExaminationPhysicianinfo ->> 'medicalreferrals',
							CASE WHEN (v_personExaminationinfo ->> 'covidimpacted') = 'true' THEN true ELSE false END, 
							v_personExaminationinfo ->> 'exposedtocovid', 
							v_personExaminationinfo ->> 'covidtestconducted', 
							v_personExaminationinfo ->> 'typeoftest', 
							v_personExaminationinfo ->> 'covidtestresults', 
							(v_personExaminationinfo ->> 'covidtestdate')::date,
							v_insertedby::uuid,
							now(),
							v_personExaminationappointment ->> 'timeframe',
							v_personExaminationappointment ->> 'labtestother',
							v_personExaminationappointment ->> 'specialityexamother',
							v_personExaminationPhysicianinfo ->> 'physicianfaxnumber',
							(v_personExaminationappointment ->> 'isannualhealthvisit') :: boolean,
							(v_personExaminationappointment ->> 'issemiannualdentalvisit') :: boolean
						);	

					select * into v_updatedocumentproperties from cjams.updatedocumentproperties(v_person_id, v_personExaminationinfo -> 'uploadpath',v_personexaminationid::varchar,'personexamination', (v_personExaminationinfo ->> 'personexaminationid')::varchar,v_insertedby);
				

				end loop;
			end loop;
		end if;

		if(v_providerinfophysician is not null) then 
			for v_providerinfo in select
				*
			from
				json_array_elements(v_providerinfophysician) loop 
			update personphycisianinfo phsp
			set activeflag = 0,
				updatedby = v_insertedby::uuid, 
				updatedon = now()
			where phsp.isphysician = true
				and phsp.personid = v_person_id 
				and phsp.personphycisianinfoid =  (v_providerinfo ->> 'personphycisianinfo_id')::uuid;

			insert
			into
				personphycisianinfo ( isphysician,
				isdentist,
				personid ,
				uploadpath,
				isprimaryphycisian,
				name,
				physician_speciality,
				facility,
				address1,
				address2,
				phone,
				email,
				city,
				state,
				countyid,
				zip,
				physician_child_lang_check,
				translation_service_available,
				startdate,
				enddate,
				otherspeciality,
				degreetype,
				updatedby,
				-- User who created this record
				updatedon,
				-- Record created date and time
				insertedby, 
				insertedon
				)
			values
				(	true,
					false,
					v_person_id,
					null,
					(v_providerinfo ->>'is_primary_care_physician')::boolean,
					v_providerinfo ->>'physician_name',
					v_providerinfo ->>'physician_speciality',
					v_providerinfo ->>'physician_facility',
					v_providerinfo ->>'address1',
					v_providerinfo ->>'address2',
					v_providerinfo ->>'physician_phone',
					v_providerinfo ->>'physician_email',
					v_providerinfo ->>'city',
					v_providerinfo ->>'state',
					( select countyid
					from county
					where countyname = v_providerinfo ->>'county'),
					v_providerinfo ->>'zipcode',
					(v_providerinfo ->>'physician_child_lang_check')::boolean,
					(v_providerinfo ->>'translation_service_available')::boolean,
					(v_providerinfo ->>'start_Date')::timestamp,
					(v_providerinfo ->>'End_Date')::timestamp,
					v_providerinfo ->>'otherspeciality',
					v_providerinfo ->>'degreetype',
					v_insertedby::uuid,
					now(),
					v_insertedby::uuid,
					now()
				) returning personphycisianinfoid into v_personphycisianinfoid;

				select * into v_updatedocumentproperties from cjams.updatedocumentproperties(v_person_id, v_providerinfo -> 'uploadpath',v_personphycisianinfoid::varchar,'personphycisianinfo', null,v_insertedby);
			
			end loop;
		end if;
		
		if(v_providerinfodentist is not null) then 
			for v_providerinfo in select
				*
			from
				json_array_elements(v_providerinfodentist) loop
			update personphycisianinfo phsp
			set activeflag = 0,
				updatedby = v_insertedby::uuid, 
				updatedon = now()
			where phsp.isdentist = true
				and phsp.personid = v_person_id 
				and phsp.personphycisianinfoid = (v_providerinfo ->> 'personphycisianinfoid')::uuid;

			insert
			into
				personphycisianinfo ( isphysician,
				isdentist,
				isprimaryphycisian,
				personid ,
				uploadpath,
				name,
				dental_speciality,
				facility,
				address1,
				address2,
				phone,
				email,
				city,
				state,
				countyid,
				zip,
				dentist_child_lang_check,
				translation_service_available,
				startdate,
				enddate,
				insertedby,
				-- User who created this record
				insertedon,
				-- Record created date and time
				updatedby, 
				updatedon
				)
			values
				(	false,
					true,
					false,
					v_person_id,
					null ,
					v_providerinfo ->>'dentist_name',
					v_providerinfo ->>'dentist_speciality',
					v_providerinfo ->>'dentist_facility',
					v_providerinfo ->>'dentist_address1',
					v_providerinfo ->>'dentist_address2',
					v_providerinfo ->>'dentist_phone',
					v_providerinfo ->>'dentist_email',
					v_providerinfo ->>'dentist_city',
					v_providerinfo ->>'dentist_state',
					( select countyid
						from county
					where countyname = v_providerinfo ->>'dentist_county'),
					v_providerinfo ->>'dentist_zipcode',
					(v_providerinfo ->>'dentist_child_lang_check')::boolean,
					(v_providerinfo ->>'translation_service_available')::boolean,
					(v_providerinfo ->>'start_Date')::timestamp,
					(v_providerinfo ->>'End_Date')::timestamp,
					v_insertedby::uuid,
					now(),
					v_insertedby::uuid,
					now()
				) returning personphycisianinfoid into v_personphycisianinfoid;

				select * into v_updatedocumentproperties from cjams.updatedocumentproperties(v_person_id, v_providerinfo -> 'uploadpath',v_personphycisianinfoid::varchar,'personphycisianinfo', null,v_insertedby);
			
			end loop;
		end if;

		if (v_medicalconditioninfojson is not null) then 
			for v_medicalconditioninfo in select
				*
			from
				json_array_elements(v_medicalconditioninfojson) loop 	
				/*
				update personmedicalcondition phsp
				set activeflag = 0,
					updatedby = v_insertedby::uuid, 
					updatedon = now()
				where phsp.personid = v_person_id 
					and phsp.personmedicalconditionid = (v_medicalconditioninfo ->> 'personmedicalconditionid')::uuid; 
				*/
			
				update personmedicalcondition 
				set uploadpath =null ,
					medicalcondition = v_medicalconditioninfo -> 'medical_condition',
					medicalcondition_icd10_desc = v_medicalconditioninfo -> 'medicalcondition_icd10_desc',
					medicalcondition_icd10_key_id = v_medicalconditioninfo -> 'medicalcondition_icd10_key_id',
					begindate = (v_medicalconditioninfo ->>'start_Date')::timestamp ,
					enddate = (v_medicalconditioninfo ->>'End_Date')::timestamp,
					recordedby = v_medicalconditioninfo ->> 'recordedby',
					notes = v_medicalconditioninfo ->> 'notes',
					ischronic = (v_medicalconditioninfo ->> 'ischronic')::boolean,
					allergies_adverse_reactions = v_medicalconditioninfo ->> 'allergies_adverse_reactions',
					medication_client_allergies = v_medicalconditioninfo ->> 'medication_client_allergies',
					severitysymptomkey = v_medicalconditioninfo ->> 'severitysymptomkey',
					updatedby = v_insertedby::uuid,
					ismedfragile = (v_medicalconditioninfo ->> 'ismedfragile')::boolean,
					-- User who created this record
					updatedon = now()
					-- Record created date and time
				where personmedicalconditionid = (v_medicalconditioninfo ->>'personmedicalconditionid')::uuid;

				select * into v_updatedocumentproperties from cjams.updatedocumentproperties(v_person_id, v_medicalconditioninfo -> 'uploadpath',(v_medicalconditioninfo ->>'personmedicalconditionid')::varchar,'personmedicalcondition', null,v_insertedby);
			
			end loop;
		end if;

		if (v_immunizationjson is not null) then 
			--for v_birthhealthinfo in select
			--	*
			--from
			--	json_array_elements(v_birthhealthinfojson) loop
	
			v_immunization := v_immunizationjson ->> 'personImmunization';
			v_immunizationid := v_immunizationjson ->> 'personimmunizationid';
			raise notice 'v_immunizationjson%',v_immunizationjson;
			
			if (v_immunizationid is not null) then

			UPDATE personimmunization
			SET immunizationdate = (v_immunizationjson ->> 'immunizationdate')::timestamp,
				"comments" = v_immunizationjson ->> 'comments',
				updatedby = v_insertedby, updatedon = now()
			WHERE personimmunizationid = v_immunizationid;
			
			else

			v_immunizationid := gen_random_uuid();
			
			INSERT INTO personimmunization
				( 	personimmunizationid, personid, uploadpath, immunizationdate, "comments",
					personimmunizationconfigid, insertedby, insertedon, activeflag, updatedby, updatedon
				)
			VALUES
				(	v_immunizationid, v_person_id, 
					null,
					(v_immunizationjson ->> 'immunizationdate')::timestamp,
					v_immunizationjson ->> 'comments',
					(v_immunizationjson ->> 'personimmunizationconfigid')::uuid,
					v_insertedby,
					now(),
					1,
					v_insertedby,
					now()
				);
			end if;
			select * into v_updatedocumentproperties from cjams.updatedocumentproperties(v_person_id, v_immunizationjson -> 'uploadpath',v_immunizationid::varchar,'personimmunization', null,v_insertedby);
			
			--end loop;

		--generate audit data and insert record in history table
		select * into flag from cjams.generate_audit_data('personimmunization',v_immunizationid);
		
		end if;

		if  (v_mobilityspeechinfojson is not null) then 
			for v_mobilityspeechinfo in select
				*
			from
				json_array_elements(v_mobilityspeechinfojson) loop
			update personhlthmobilityspeech phms
			set activeflag = 0,
				updatedby = v_insertedby::uuid, 
				updatedon = now() 
			where phms.personid = v_person_id 
				and phms.personhlthmobilityspeechid = (v_mobilityspeechinfo ->> 'personhlthmobilityspeechid')::uuid ;

			insert
			into
				personhlthmobilityspeech ( personid ,
				uploadpath,
				providedname  ,
				relationship ,
				ishousehold ,
				iscollateral ,
				ismbltyspchknown ,
				mblty,
				speech,
				satupage,
				walkedage,
				talkedage,	
				comments,
				updatedby,
				updatedon,
				insertedby, 
				insertedon
				)
			values
				(	v_person_id,
					null ,
					v_mobilityspeechinfo ->> 'provided_name' ,
					(v_mobilityspeechinfo ->>'relationship'),
					(v_mobilityspeechinfo ->>'ishousehold')::boolean ,
					(v_mobilityspeechinfo ->> 'iscollateral')::boolean,
					(v_mobilityspeechinfo ->> 'ismbltyspchknown')::boolean,
					v_mobilityspeechinfo -> 'Mobility' ,
					v_mobilityspeechinfo -> 'Speech' ,
					(v_mobilityspeechinfo ->> 'satupage'),
					(v_mobilityspeechinfo ->> 'walkedage') ,
					(v_mobilityspeechinfo ->> 'talkedage') ,
					v_mobilityspeechinfo ->> 'comments',
					v_insertedby::uuid,
					now(),
					v_insertedby::uuid,
					now()
				) returning personhlthmobilityspeechid into v_personhlthmobilityspeechid;

				select * into v_updatedocumentproperties from cjams.updatedocumentproperties(v_person_id, v_mobilityspeechinfo -> 'uploadpath',v_personhlthmobilityspeechid::varchar,'personhlthmobilityspeech', null,v_insertedby);
			
			end loop;
		end if;

		if  (v_feedinginfojson is not null) then 
			for v_feedinginfo in select
				*
			from
				json_array_elements(v_feedinginfojson) loop
	
			UPDATE personhlthfeeding
			SET providedname = v_feedinginfo ->> 'provided_name', 
				relationship = (v_feedinginfo ->>'relationship'), 
				ishousehold = (v_feedinginfo ->>'ishousehold')::boolean ,
				iscollateral = (v_feedinginfo ->> 'iscollateral')::boolean, 
				isfeedinginfoknown = coalesce(((v_feedinginfo ->> 'isfeedinginfoknown')::boolean),null),
				diettype = v_feedinginfo ->'diettype', eatertype=v_feedinginfo ->'eatertype', 
				liquids = v_feedinginfo ->'liquids', 
				solidfood = v_feedinginfo ->'solidfood', 
				feeding_position = v_feedinginfo ->'feeding_position', 
				otherneeds=v_feedinginfo ->'otherneeds', 
				typeofformula=v_feedinginfo ->>'typeofformula',
				amountperfeeding=v_feedinginfo ->>'amountperfeeding', 
				schedule=v_feedinginfo ->>'schedule', 
				updatedon = now(), 
				updatedby = v_insertedby::uuid,
				activeflag = 1, 
				"comments" = v_feedinginfo ->> 'comments', 
				uploadpath=null
			WHERE personid = v_person_id 
				and personhlthfeedingid = (v_feedinginfo ->> 'personhlthfeedingid')::uuid;

			select * into v_updatedocumentproperties from cjams.updatedocumentproperties(v_person_id, v_feedinginfo -> 'uploadpath',(v_feedinginfo ->> 'personhlthfeedingid')::varchar,'personhlthfeeding', null,v_insertedby);			

			end loop;
		end if;

		if (v_sleepinginfojson is not null) then 
			for v_sleepinginfo in select
				*
			from
				json_array_elements(v_sleepinginfojson) loop 
			update personhlthsleeping phs
			set activeflag = 0,
				updatedby = v_insertedby::uuid, 
				updatedon = now() 
			where phs.personid = v_person_id 
				and phs.personhlthsleepingid =(v_sleepinginfo ->> 'personhlthsleepingid')::uuid;
				
			insert
			into
				personhlthsleeping ( personid ,
				uploadpath,
				providedname,
				relationship ,
				ishousehold ,
				iscollateral ,
				issleepinginfoknown ,
				sleepingenvironment ,
				sleepingproblems ,
				sleepingposition ,
				sleepingschedule_naptime ,
				sleepingschedule_bedtime ,
				comments,
				updatedby ,
				updatedon,
				otherspecify,
				insertedby, 
				insertedon
				)
			values
				(	v_person_id,
					null ,
					v_sleepinginfo ->> 'provided_name' ,
					(v_sleepinginfo ->>'relationship'),
					(v_sleepinginfo ->>'ishousehold')::boolean ,
					(v_sleepinginfo ->> 'iscollateral')::boolean,
					(v_sleepinginfo ->> 'issleepinginfoknown')::boolean,
					v_sleepinginfo ->'sleepingenvironment',
					v_sleepinginfo ->'sleepingproblems',
					v_sleepinginfo ->'sleepingposition',      
					(v_sleepinginfo ->>'sleepingschedule_naptime')::timestamp,
					(v_sleepinginfo ->>'sleepingschedule_bedtime')::timestamp,
					v_sleepinginfo ->> 'comments',
					v_insertedby::uuid,
					now(),
					v_sleepinginfo ->> 'otherSpecify',
					v_insertedby::uuid,
					now()
				);
			end loop;
		end if;

		if  (v_eliminationinfojson is not null) then
			for v_eliminationinfo in select
				*
			from
				json_array_elements(v_eliminationinfojson) loop 
			update personhlthelimination phe
			set activeflag = 0,
				updatedby = v_insertedby::uuid, 
				updatedon = now() 
			where phe.personid = v_person_id 
				and phe.personhltheliminationid=(v_eliminationinfo ->> 'personhltheliminationid')::uuid;


			raise notice 'elimination%',v_eliminationinfo ->> 'personhltheliminationid';
			raise notice 'elimination%',v_person_id;
	
			insert
			into
				personhlthelimination ( personid ,
				providedname,
				relationship ,
				ishousehold ,
				iscollateral ,
				iseliminationinfoknown,
				isspecialconsiderunknown,
				elimination_currentstatus,
				toilettrainingmethod,
				wordforBowelmovement,
				wordforUrination,
				comments,
				specialcomments,
				insertedby ,
				insertedon,
				otherspecify,
				updatedby, 
				updatedon
				)
			values
				(	v_person_id,
					v_eliminationinfo ->> 'infoprovidedname' ,
					(v_eliminationinfo ->>'relationship'),
					(v_eliminationinfo ->>'ishousehold')::boolean ,
					(v_eliminationinfo ->> 'iscollateral')::boolean,
					(v_eliminationinfo ->> 'eliminationinfounknown')::boolean,
					(v_eliminationinfo ->> 'considerunknown')::boolean,
					v_eliminationinfo ->'currentstatus',
					v_eliminationinfo ->'toilettraining',
					v_eliminationinfo ->>'bowelmovement',
					v_eliminationinfo ->>'urination',
					v_eliminationinfo ->> 'toiletcomments',
					v_eliminationinfo ->> 'specialcomments',
					v_insertedby::uuid,
					now(),
					v_eliminationinfo ->> 'otherSpecify',
					v_insertedby::uuid,
					now()
				);
			end loop;
		end if;

	elseif (isnew = 2) then 
		
		if (v_personExaminationinfojson is not null) then 
			for v_personExaminationinfo in select
				*
			from
				json_array_elements(v_personExaminationinfojson) loop 
				--raise notice 'v_personExaminationinfo%',v_personExaminationinfo ->> 'appointment';
				v_personExaminationappointmentjson := v_personExaminationinfo ->> 'appointment';
				v_personExaminationPhysicianinfo := v_personExaminationinfo ->> 'physician';
				raise notice 'v_personExaminationinfo%',v_personExaminationinfo;
				raise notice 'providerinfoflag%',v_personExaminationinfo ->> 'providerinfoflag';
				
			update personexamination pe
			set activeflag = 0,
				updatedby = v_insertedby::uuid, 
				updatedon = now() 
			where pe.personid = v_person_id 
				and pe.personexaminationid=(v_personExaminationinfo ->> 'personexaminationid')::uuid;
		end loop;
		end if;
		
		if (v_hospitalizationinfojson is not null) then 
			for v_hospitalizationinfo in select
				*
			from 
				json_array_elements(v_hospitalizationinfojson) loop 
			update personhospitalization phsp
			set activeflag = 0,
				updatedby = v_insertedby::uuid, 
				updatedon = now() 
			where phsp.personid = v_person_id 
				and phsp.hospitalizationid = (v_hospitalizationinfo ->> 'hospitalizationid'):: uuid;
	
			end loop;
		end if;

		if(v_providerinfophysician is not null) then 
			for v_providerinfo in select
				*
			from
				json_array_elements(v_providerinfophysician) loop 
				raise notice 'physicianid %',(v_providerinfo ->> 'personphycisianinfo_id');
	
			update personphycisianinfo phsp
			set activeflag = 0,
				updatedby = v_insertedby::uuid, 
				updatedon = now() 
			where phsp.isphysician = true
				and phsp.personid = v_person_id 
				and  phsp.personphycisianinfoid =  (v_providerinfo ->> 'personphycisianinfo_id'):: uuid;
	
			end loop;
		end if;

		if(v_providerinfodentist is not null) then 
			for v_providerinfo in select
				*
			from
				json_array_elements(v_providerinfodentist) loop
				raise notice 'physicianid %',(v_providerinfo ->> 'personphycisianinfo_id');
	 
			update personphycisianinfo phsp
			set activeflag = 0,
				updatedby = v_insertedby::uuid, 
				updatedon = now() 
			where phsp.isdentist = true
				and phsp.personid = v_person_id and phsp.personphycisianinfoid =  (v_providerinfo ->> 'personphycisianinfo_id')::uuid;

			end loop;
		end if;

		if (v_behaviourinfojson is not null) then 
			for v_behaviourinfo in select
				*
			from
				json_array_elements(v_behaviourinfojson) loop 
			update personbehavioralhealth 
			set activeflag = 0,
				updatedby = v_insertedby::uuid, 
				updatedon = now() 
			where personid = v_person_id 
				and personbehavioralhealthid = (v_behaviourinfo ->> 'personbehavioralhealthid')::uuid ;
			end loop;
		end if;

		if (v_birthhealthinfojson is not null) then 
			update birthhealthinfo bhi
			set	activeflag = 0,
				updatedby = v_insertedby::uuid, 
				updatedon = now() 
			where bhi.personid = v_person_id;

			--for v_birthhealthinfo in select
			--	*
			--from
			--	json_array_elements(v_birthhealthinfojson) loop
		end if;

		if (v_substanceabusejson is not null) then 
			for v_substanceabuse in select
				*
			from
				json_array_elements(v_substanceabusejson) loop
			update personabusesubstance pas
			set activeflag = 0,
				updatedby = v_insertedby::uuid, 
				updatedon = now() 
			where personid = v_person_id 
				and  pas.personabusesubstanceid = (v_substanceabuse ->> 'personabusesubstanceid'):: uuid;

			end loop;
		end if;

		if (v_medicalpsychotropicinfojson is not null) then
			for v_medicalpsychotropicinfo in select
				*
			from
				json_array_elements(v_medicalpsychotropicinfojson) loop
			update personmedicpshychotropic 
			set activeflag = 0,
				updatedby = v_insertedby::uuid, 
				updatedon = now() 
			where personid = v_person_id 
				and personmedicpshychotropicid = (v_medicalpsychotropicinfo ->> 'personmedicpshychotropicid'):: uuid;
			end loop;
		end if;

		if (v_familyhistoryinfojson is not null) then 
			for v_familyhistoryinfo in select
				*
			from
				json_array_elements(v_familyhistoryinfojson) loop 
			update personfmlymdclhstry pfh
			set activeflag = 0,
				updatedby = v_insertedby::uuid, 
				updatedon = now() 
			where pfh.personid = v_person_id 
				and pfh.personfmlymdclhstryid = (v_familyhistoryinfo ->> 'personfmlymdcl_hstryid'):: uuid ;	
	
			end loop;
		end if;
		
		if (v_healthinsuranceinfojson is not null) then 
			for v_healthinsuranceinfo in select
				*
			from
				json_array_elements(v_healthinsuranceinfojson) loop
			update personhealthinsurance phi
			set activeflag = 0,
				updatedby = v_insertedby::uuid, 
				updatedon = now() 
			where phi.personid = v_person_id 
				and phi.personhealthinsuranceid = ( v_healthinsuranceinfo ->> 'personhealthinsuranceid'):: uuid;

			end loop;
		end if;

		if (v_eliminationinfojson is not null) then
			for v_eliminationinfo in select
				*
			from
				json_array_elements(v_eliminationinfojson) loop 
			update personhlthelimination phe
			set	activeflag = 0,
				updatedby = v_insertedby::uuid, 
				updatedon = now() 
			where phe.personid = v_person_id 
				and phe.personhltheliminationid=(v_eliminationinfo ->> 'personhltheliminationid')::uuid;

			raise notice 'elimination%',v_eliminationinfo ->> 'personhltheliminationid';
			raise notice 'elimination%',v_person_id;
			end loop;
		end if;

		if (v_sleepinginfojson is not null) then 
			for v_sleepinginfo in select
				*
			from
				json_array_elements(v_sleepinginfojson) loop 
			update personhlthsleeping phs
			set	activeflag = 0,
				updatedby = v_insertedby::uuid, 
				updatedon = now() 
			where phs.personid = v_person_id 
				and phs.personhlthsleepingid =(v_sleepinginfo ->> 'personhlthsleepingid')::uuid;

			end loop;
		end if;
		
		if (v_behaviourinfojson is not null) then 
			for v_behaviourinfo in select
				*
			from
				json_array_elements(v_behaviourinfojson) loop 
				raise notice 'v_behaviourinfo %',(v_behaviourinfo ->> 'personbehavioralhealthid');
			update personbehavioralhealth 
			set	activeflag = 0,
				updatedby = v_insertedby::uuid, 
				updatedon = now() 
			where personid = v_person_id 
				and personbehavioralhealthid = (v_behaviourinfo ->> 'personbehavioralhealthid')::uuid ;
			end loop;
		end if;

		if (v_substanceabusejson is not null) then 
			for v_substanceabuse in select
				*
			from
				json_array_elements(v_substanceabusejson) loop
				raise notice 'v_behaviourinfo %',(v_substanceabuse ->> 'personabusesubstanceid');
			update personabusesubstance pas
			set activeflag = 0,
				updatedby = v_insertedby::uuid, 
				updatedon = now() 
			where personid = v_person_id 
				and  pas.personabusesubstanceid = (v_substanceabuse ->> 'personabusesubstanceid'):: uuid;
			end loop;
		end if;

		if (v_mobilityspeechinfojson is not null) then 
			for v_mobilityspeechinfo in select
				*
			from
				json_array_elements(v_mobilityspeechinfojson) loop
			update personhlthmobilityspeech phms
			set activeflag = 0,
				updatedby = v_insertedby::uuid, 
				updatedon = now() 
			where phms.personid = v_person_id 
				and phms.personhlthmobilityspeechid = (v_mobilityspeechinfo ->> 'personhlthmobilityspeechid')::uuid ;
			end loop;
		end if;

		if (v_reproductivehealthinfojson is not null) then 
			for v_reproductivehealthinfo in select
				*
			from
				json_array_elements(v_reproductivehealthinfojson) loop
			update personsexualinfo psi
			set activeflag = 0,
				updatedby = v_insertedby::uuid, 
				updatedon = now() 
			where psi.personid = v_person_id 
				and psi.personsexualinfoid = (v_reproductivehealthinfo ->> 'personsexualinfoid')::uuid ;
			end loop;
		end if;

		if (v_medicalconditioninfojson is not null) then 
			for v_medicalconditioninfo in select
				*
			from
				json_array_elements(v_medicalconditioninfojson) loop
			update personmedicalcondition phsp
			set activeflag = 0,
				updatedby = v_insertedby::uuid, 
				updatedon = now() 
			where phsp.personid = v_person_id 
				and phsp.personmedicalconditionid = (v_medicalconditioninfo ->> 'personmedicalconditionid')::uuid; 
	
			end loop;
		end if;

		if (v_feedinginfojson is not null) then 
			for v_feedinginfo in select
				*
			from
				json_array_elements(v_feedinginfojson) loop
			update personhlthfeeding phf
			set activeflag = 0,
				updatedby = v_insertedby::uuid, 
				updatedon = now() 
			where phf.personid = v_person_id 
				and phf.personhlthfeedingid = (v_feedinginfo ->> 'personhlthfeedingid')::uuid;

			end loop;
		end if;
	end if;
	-- End of Isnew
	return response;
end;


$function$
;