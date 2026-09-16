DROP FUNCTION IF EXISTS cjams.approvepublicproviderapplication(insertedtlsobj json);
CREATE OR REPLACE FUNCTION cjams.approvepublicproviderapplication(insertedtlsobj json)
 RETURNS text
 LANGUAGE plpgsql
AS $function$ 

declare
v_referralId text;
v_applicantId text;
v_providerId text;
returnStatus text;
v_securityuserid text;
v_statuscode text;
v_categorycd text;
householdRelation text;
householdEmail text;
householdDob text;	
householdPhone text;	
householdBackgroundStatus text;	
householdSsn text;
householdClearance text;	
householdFirstNm text;		
householdMiddleNm text;	
householdLastNm text;
response json;
v_counter json;
serviceCategory text;	
serviceCost text;					
serviceDescription text;						
serviceId text; 						
servicePaidBy text; 						
serviceUnit text;					
serviceClassification text;						
serviceStartDate text;						
serviceEndDate text;						
serviceStatus text;
res json;
v_service json;
v_characteristic json;
responseChar json;
pickListTypeId	text;
picklistValueCd	text;					
ValueDesc text;
householdPrefix text;
householdSuffix text;

-- provider table values
v_payToAffiliateCd TEXT;

----- provider approval
v_approvalStatusCd text;
v_approvalTypeCd text;
v_approvalReasonCd text;
v_recommendCd text;
v_providerApprovalId uuid; -- uuid ?
v_haApprovalStatusCd text;
v_nextrecondate timestamp without time zone;

----- prov approval person
v_approvalPersonId uuid;
v_personTypeKey text;

----- provider background check
v_providerBackgroundCheckId uuid;

----- Placement specifications
placementSpecification json; -- Try using this!!
approvedPlacementCapacity numeric;
v_householdmember character varying;
v_configrecord character varying;
v_oldprgram character varying;
v_oldprgramtype character varying;
v_prgram character varying;
v_prgram_type character varying;
v_updateplacementstructures character varying;
v_sendplacementnotification character varying;
v_provisionally timestamp;
v_rejectstatus character varying;
v_provproviderid character varying;
v_applicationstatus character varying;


BEGIN

v_referralId := insertedtlsobj->>'referral_id';
v_applicantId := insertedtlsobj->>'applicant_id';
v_securityUserId := insertedtlsobj->>'securityuserid';
v_providerId := insertedtlsobj->>'provider_id';
v_applicationstatus := insertedtlsobj->>'application_status';
v_statuscode :='1791';
v_categorycd := '1783';
v_payToAffiliateCd := '3366';

------ provider approval
v_approvalTypeCd := '3577'; -- Regular Home Approval  -*- these are the type of approval type selected eg kinship, etc -*- picklist_type_id = 367
v_approvalStatusCd := '3579';  -- Approved -*- change as the application progresses eg Home Assessment Completed, Application Signed, etc -*- picklist_type_id = 368
v_recommendCd := '3661';  -- This home should be Approved -*- recommendations etc -*- picklist_type_id = 380
v_approvalReasonCd := '4995'; -- New Provider -*- reason for approving this one eg Significant Change in Household, Re-Opening Provider, etc -*- picklist_type_id = 976
v_haApprovalStatusCd := '3047'; -- Approved -*- what is HA ? -*- picklist_type_id = 279

----- UUIDs used for inserting data records
v_providerApprovalId := gen_random_uuid();
v_approvalPersonId := gen_random_uuid();
v_providerBackgroundCheckId := gen_random_uuid();

RAISE NOTICE '%','11111111111111111111111111111111111111111111111111111';
raise notice 'v_providerId%',v_providerId;

IF LENGTH(v_providerId) > 1
then


select provisionstrtdate into v_provisionally from tb_public_provider_applicant where provisionstrtdate is not null  and applicant_id=v_applicantId;
select providerid into v_configrecord from providerapprovetypeconfig where applicantid=v_applicantId;--for resourcehome restricted applicant flow
select application_status into v_rejectstatus from tb_public_provider_applicant where applicant_id=v_applicantId  and lower(application_status) like '%reject%';
SELECT prgram,provider_program_type into v_prgram,v_prgram_type	FROM tb_public_provider_applicant pr WHERE pr.applicant_id = v_applicantId;
--if there is a entry in providerapprovetypeconfig then it is change request not new provider request then follow this
if ((v_configrecord is not null) and (v_provisionally is null))then 
returnStatus:=v_configrecord;
--new change request program type
SELECT prgram,provider_program_type into v_prgram,v_prgram_type	FROM tb_public_provider_applicant pr WHERE pr.applicant_id = v_applicantId;
--updated placementcapacity
SELECT capacity into approvedPlacementCapacity FROM publicproviderhomeplacementspecification WHERE object_id=v_applicantId;
--update placement structures based on programtype
select updateplacementstructures into v_updateplacementstructures from updateplacementstructures(v_applicantId,v_prgram,v_prgram_type,v_securityuserid,approvedPlacementCapacity);
--get the old applicant id
select applicant_id into v_applicantId from providerapprovalphaserecord where provider_id=v_configrecord;
--get the old program type to send notification to the case worker with provider under placement
SELECT prgram,provider_program_type into v_oldprgram,v_oldprgramtype FROM tb_public_provider_applicant pr WHERE pr.applicant_id = v_applicantId;
select sendplacementnotification into v_sendplacementnotification from sendplacementnotification(v_configrecord,v_securityUserId,v_oldprgramtype,v_prgram_type);
--this is for re-open flow of a closed provider,and updating the program type for change request
update tb_provider set provider_status_cd='1791' where provider_id=v_configrecord::int; 
update providerinfoconfig set programtype=v_prgram_type where providerid=v_configrecord;

----reject flow
elsif (v_applicationstatus = 'Rejected') then 
raise notice 'Rejected%','rejected';
select provider_id  into v_provproviderid from providerapprovalphaserecord where applicant_id=v_applicantId;
raise notice 'v_provproviderid%',v_provproviderid;
if (v_provproviderid is null or v_provproviderid='') then 

select providerid into v_provproviderid from providerapprovetypeconfig where applicantid=v_applicantId;--program type change request table
end if;
raise notice 'v_provproviderid%',v_provproviderid;
raise notice 'v_provisionally%',v_provisionally;
if(v_provisionally is not null) then 
raise notice 'publicproviderstatusmanagement%','publicproviderstatusmanagement';
INSERT INTO cjams.publicproviderstatusmanagement
( object_id, narrative, provider_status, create_ts, create_user_id, delete_sw, active_flag, approval_status, dirty_status)
VALUES(v_provproviderid, 'Provisionally Rejected', 'On-Hold', now(), v_securityUserId, 'N', 1, 'Requested', true);
INSERT INTO cjams.publicproviderstatusmanagement
( object_id, narrative, provider_status, create_ts, create_user_id, delete_sw, active_flag, approval_status, dirty_status)
VALUES(v_provproviderid, 'Provisionally Rejected', 'On-Hold', now(), v_securityUserId, 'N', 1, 'Approved', true);
update tb_provider set provider_status_cd='1792' where provider_id=v_provproviderid::int;
end if;
returnStatus:=v_provproviderid;
--this flow is for provisionally approve provider, getting approved after the provision period is completed
elsif ((v_provisionally is not null) and v_applicationstatus = 'Approved') then 

select provider_id  into v_provproviderid from providerapprovalphaserecord where applicant_id=v_applicantId;

if (v_provproviderid is null or v_provproviderid='') then 

select providerid into v_provproviderid from providerapprovetypeconfig where applicantid=v_applicantId;--program type change request table
end if;
returnStatus:=v_provproviderid;
--previously provisionaly flow, getting rejected

returnStatus:=v_provproviderid;
--Normal flow if it is under initiate request or provisionally approved
else
--Inserting backgroundcheck info for provider

--update providerapprovalphaserecord with provider id
update providerapprovalphaserecord set
provider_id=v_providerId, is_application_accepted=true where applicant_id=v_applicantId;
select updateplacementstructures into v_updateplacementstructures from 
updateplacementstructures(v_applicantId,v_prgram,v_prgram_type,v_securityuserid,approvedPlacementCapacity);

raise notice 'provider id insert%',v_providerId;
raise notice 'v_applicantId id insert pubprovapphouseholdbgchecks%',v_applicantId;
insert into pubprovapphouseholdbgchecks( household_member_id, submission_data, criminal_history_check_data, personid, objectid)
select household_member_id,submission_data,criminal_history_check_data,personid,v_providerId from pubprovapphouseholdbgchecks where objectid=v_applicantId;

if length(v_applicantId)>1 then
select updateinquiryhousehold into  v_householdmember from updateinquiryhousehold(v_applicantId,v_providerId,v_securityUserId);
end if;


-- Get placement specification capacity that was approved - to be inserted into multiple tables (chessie model)
SELECT 
	capacity into approvedPlacementCapacity 
FROM 
	publicproviderhomeplacementspecification 
WHERE 
	object_id=v_applicantId;

-- Insert all the application placement specification into Provider relevant table
-- Currently making entry to publicproviderhomeplacementspecification with object_id = provider_id
-- But, need to check with Placement/Finance/DM if needed in tb_prov_accomodation
INSERT INTO publicproviderhomeplacementspecification
	(object_id, min_age_yr, max_age_yr, min_age_months, max_age_months, capacity, gender)
SELECT
	(v_providerId)::int, pphps.min_age_yr, pphps.max_age_yr, pphps.min_age_months, pphps.max_age_months, pphps.capacity, pphps.gender
FROM
	publicproviderhomeplacementspecification pphps
WHERE	
	pphps.object_id = v_applicantId;


-- Insert data in tb_provider with the details from tb_public_provider_applicant
INSERT INTO tb_provider
	(provider_id, provider_category_cd, provider_status_cd, pay_to_affiliate_cd, create_ts, create_user_id, update_ts,
	update_user_id, provider_first_nm , provider_last_nm , provider_middle_nm, tax_id_no , dob_dt, co_dob_dt , co_first_nm ,
	co_last_nm , co_ssn_no , provider_nm, vacancy_no,county_cd_tx,adr_work_phone_tx)
SELECT 
	(v_providerId)::int, v_categorycd, v_statuscode, v_payToAffiliateCd, now()::date, v_securityuserid, now()::date,
	v_securityuserid, pr.individual_applicant_first_nm , pr.individual_applicant_last_nm , pr.individual_applicant_middle_nm ,
	pr.individual_applicant_ssn , pr.individual_applicant_dob , pr.co_applicant_dob , pr.co_applicant_first_nm , 
	pr.co_applicant_last_nm , pr.co_applicant_ssn , '', approvedPlacementCapacity,jurisdiction,individual_applicant_cell_nm
FROM 
	tb_public_provider_applicant pr 
WHERE 
	pr.applicant_id = v_applicantId;
	
----------

	
if(v_providerId is not null  ) then

update providerinfoconfig set activeflag=0 where providerid =v_providerId;

insert into providerinfoconfig (providerid,"program",programtype,insertedby)

SELECT 
	(v_providerId)::int, prgram,provider_program_type,v_securityuserid
	
FROM 
	tb_public_provider_applicant pr 
WHERE 
	pr.applicant_id = v_applicantId;

SELECT 
	 prgram,provider_program_type into v_prgram,v_prgram_type
	
FROM 
	tb_public_provider_applicant pr 
WHERE 
	pr.applicant_id = v_applicantId;


--select updateplacementstructures into v_updateplacementstructures from 
--updateplacementstructures(v_applicantId,v_prgram,v_prgram_type,v_securityuserid,null);


end if;
	
------------	

-- Insert addresses

INSERT INTO tb_provider_addresses
	(parent_key_id, adr_type_cd, adr_format_cd, create_ts, create_user_id, update_ts, update_user_id, adr_street_no, adr_box_no, adr_pre_dir_cd, adr_street_nm, adr_street_suffix_cd, adr_post_dir_cd, adr_unit_type_cd, adr_unit_no_tx, adr_city_nm, adr_county_cd, adr_state_cd, adr_zip5_no, adr_zip4_no, adr_direction_tx, adr_foreign_tx, adr_foreign_state_tx, adr_country_tx, adr_postal_code_tx, adr_default_sw, adr_start_dt, adr_end_dt, delete_sw, adr_street_tx, adr_county_cd_tx)
SELECT
	v_providerId, '3358', 'S', now(), v_securityuserid, now(), v_securityuserid, adr_street_no, adr_box_no, adr_pre_dir_cd, adr_street_nm, adr_street_suffix_cd, adr_post_dir_cd, adr_unit_type_cd, adr_unit_no_tx, adr_city_nm, adr_county_cd, adr_state_cd, adr_zip5_no, adr_zip4_no, adr_direction_tx, adr_foreign_tx, adr_foreign_state_tx, adr_country_tx, adr_postal_code_tx, 'Y', adr_start_dt, adr_end_dt, 'N', adr_street_tx, adr_county_cd_tx
FROM
	tb_provider_applicant_addresses tpaa, tb_provider_address_mapping tpam
WHERE 
	tpam.object_id = v_applicantId and tpam.address_type = 'Individual Applicant Address' and tpam.address_id = tpaa.address_id;


-- Insert into the tb_provider_approval -- this is like the private provider licensing table
-- TODO: All the other fields
SELECT CURRENT_DATE + INTERVAL '365 day' INTO v_nextrecondate;

INSERT INTO tb_provider_approval
	( provider_id, approval_type_cd, approval_status_cd, recommend_cd, approved_beds_no, approval_dt,
	  effective_dt, next_recon_dt, ha_approval_status_cd, ha_approval_dt, approval_reason_cd,
	  create_ts, create_user_id, update_ts, update_user_id, delete_sw, active_sw, providerapprovalid )
VALUES
	( (v_providerId)::int, v_approvalTypeCd, v_approvalStatusCd, v_recommendCd, approvedPlacementCapacity, now()::date,
	  now()::date, v_nextrecondate, v_haApprovalStatusCd, now()::date, v_approvalReasonCd,
	  now()::date, v_securityuserid, now()::date, v_securityuserid, 'N'::bpchar,'Y'::bpchar, v_providerApprovalId );

-- Insert into tb_provider_picklist

INSERT INTO tb_provider_picklist
( provider_id, program_id, picklist_type_id, picklist_value_cd, create_user_id, update_user_id, delete_sw, value_desc, create_ts, update_ts)
VALUES( (v_providerId)::int, NULL, 155, v_categorycd, v_securityuserid, v_securityuserid, 'N', NULL, now(), now());


--  Insert household with provider id

select json_agg(x) from (SELECT *  FROM tb_public_provider_applicant_household where object_id=v_applicantId) as X  into response;

raise notice '%s',  response;
 
for v_counter in select * from json_array_elements(response)
loop
raise notice '%s',  v_counter;
 	
		householdRelation := v_counter ->> 'household_member_relation';
		householdEmail := v_counter ->> 'household_member_email';
		householdDob := v_counter ->> 'household_member_dob';		
		householdPhone := v_counter ->> 'household_member_phone';		
		householdBackgroundStatus := v_counter ->> 'household_member_background_status';		
		householdSsn := v_counter ->> 'household_member_ssn';		
		householdClearance := v_counter ->> 'household_member_clearance_status';		
		householdFirstNm := v_counter ->> 'household_member_first_name';		
		householdMiddleNm := v_counter ->> 'household_member_middle_name';		
		householdLastNm := v_counter ->> 'household_member_last_name';	
		householdPrefix := v_counter ->> 'household_member_prefix';				
		householdSuffix := v_counter ->> 'household_member_suffix';				

	insert into tb_public_provider_applicant_household
	(object_id, household_member_relation,household_member_email,household_member_dob, 
	household_member_phone, household_member_background_status,household_member_ssn,create_ts, create_user_id,update_ts, update_user_id, delete_sw,
	household_member_clearance_status,household_member_first_name,household_member_middle_name,household_member_last_name,household_member_prefix,household_member_suffix)
	values( (v_providerId)::varchar,  householdRelation,householdEmail,householdDob::date, householdPhone::numeric, householdBackgroundStatus::bool,householdSsn::numeric,
	now(), v_securityuserid,now(), v_securityuserid, 'N'::bpchar, householdClearance::bool,householdFirstNm,householdMiddleNm,householdLastNm,householdPrefix,householdSuffix);
END LOOP;
	
--insert services
	
select json_agg(x) from (SELECT *  FROM tb_provider_applicant_services where applicant_id=v_applicantId) as X  into res;

raise notice '%s',  res;
 
for v_service in select * from json_array_elements(res)
loop
	raise notice '%s',  v_service;
	 	
			serviceCategory := v_service ->> 'service_category';	
			serviceCost := v_service ->> 'service_cost';						
			serviceDescription := v_service ->> 'service_description';						
			serviceId := v_service ->> 'service_id';						
			servicePaidBy := v_service ->> 'service_paid_by';						
			serviceUnit := v_service ->> 'service_unit';						
			serviceClassification := v_service ->> 'service_classification';						
			serviceStartDate := v_service ->> 'start_dt';						
			serviceEndDate := v_service ->> 'end_dt';						
			serviceStatus := v_service ->> 'service_status';
	insert into tb_provider_services
	(provider_id,service_category,service_cost, service_description,service_id,service_paid_by,service_unit,
	service_classification,start_dt, end_dt, service_status, create_ts,create_user_id,update_ts,update_user_id)
	
	values((v_providerId)::int,serviceCategory,serviceCost::int, serviceDescription,serviceId::int,servicePaidBy,serviceUnit,
	serviceClassification,serviceStartDate::date, serviceEndDate::date, serviceStatus, now(),v_securityuserid,now(),v_securityuserid);
END LOOP;
	

--insert characteristics
select json_agg(x) from (SELECT *  FROM tb_applicant_child_characteristics where applicant_id=v_applicantId) as X  into responseChar;

raise notice '%s',  responseChar;
 
for v_characteristic in select * from json_array_elements(responseChar)
loop
	raise notice '%s',  v_characteristic;
	 	
			pickListTypeId := v_characteristic ->> 'picklist_type_id';	
			picklistValueCd := v_characteristic ->> 'picklist_value_cd';						
			ValueDesc := v_characteristic ->> 'value_desc';						
			
	insert into tb_applicant_child_characteristics 
	(applicant_id,picklist_type_id,picklist_value_cd, value_desc, create_ts,create_user_id,update_ts,update_user_id)
	
	values((v_providerId)::varchar,pickListTypeId::int,picklistValueCd, ValueDesc, now(),v_securityuserid,now(),v_securityuserid);
END LOOP;


	returnStatus:= v_providerId; 
 end if;
ELSE
	returnStatus:= 'Failure';

END IF;

RETURN returnStatus;
                                                      
END;

$function$
