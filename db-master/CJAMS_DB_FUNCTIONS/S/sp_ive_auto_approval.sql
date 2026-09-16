DROP FUNCTION IF EXISTS cjams.sp_ive_auto_approval(	character varying );

CREATE OR REPLACE FUNCTION cjams.sp_ive_auto_approval(	as_user_id character varying, 
														OUT al_sqlcode integer, 
														OUT as_mess character varying
													  )
 RETURNS record
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------
-- SQL Stored Procedure
-- Author: Vineet Tirodkar
-- Date Created: 03/04/2024
-- To auto approve IV-E determination requests (CIDM-8472)

-- Revision(s)
-- 
------------------------------------------------------------------------
Declare sqlcode int default 0;

Declare vl_eligibility_id Bigint;
Declare vl_client_id Bigint;
Declare vl_eligibility_period_id Bigint;
Declare vl_removal_id Bigint;

Declare vs_status_cd character varying;
Declare vs_supervisor_name character varying;
Declare vs_approvalid character varying;
Declare vs_sqnm_sw character varying;
Declare vs_tosecurityusersid character varying;

Declare vu_iveautoapprovalsid uuid;
Declare vu_routingid uuid;

Declare v_inputjson json;
		
cur_ive_record record;
cur_ive_REFCURSOR REFCURSOR;

BEGIN

	if as_user_id is NULL then
		as_user_id := 'ive_fix';
	end if;
	
	OPEN cur_ive_REFCURSOR FOR
		select ived.iveautoapprovalsid,
			ce.client_id,
			ce.eligibility_id,
			ep.eligibility_period_id,
			ep.status_cd, 
			ep.approvalid,
			-- ep.approvalstatus,
			-- ep.approvedby,
			-- ep.approvedon,
			ro.routingid, 
			ro.tosecurityusersid,
			(up.firstname || ' ' || up.lastname) as supervisor_name,
			ep.sqnm_sw,
			ce.removal_id
		from ive_auto_approvals ived,
			tb_client_eligibility ce,
			tb_eligibility_period ep,
			routing ro,
			userprofile up
		where ived.eligibility_period_id = ep.eligibility_period_id
			and ce.eligibility_id = ep.eligibility_id
			and ep.approvalid = ro.objectid
			and ro.tosecurityusersid = up.securityusersid
			and ived.activeflag = 1
			and coalesce(ived.auto_approval_process_sw, 'N') = 'N' 
			and ce.delete_sw = 'N'
			and ep.delete_sw = 'N'
			and ep.approvalstatus = 'PENDING'
			and ro.eventcode = 'PLTR'
			and ro.routingstatustypeid = 71 -- Review
			and ro.activeflag = 1
		order by ce.client_id,
			ce.eligibility_id
		;  
	loop
	fetch cur_ive_REFCURSOR into cur_ive_record;
		exit when not found;

		-- Reset
		vu_iveautoapprovalsid := NULL;
		vl_client_id := NULL;
		vl_eligibility_id := NULL;
		vl_eligibility_period_id := NULL;
		vs_status_cd := NULL;
		vs_approvalid := NULL;
		vu_routingid := NULL;
		vs_tosecurityusersid := NULL;
		vs_supervisor_name := NULL;
		vs_sqnm_sw := NULL;
		vl_removal_id := NULL;
		al_sqlcode := 0 ;
		
		vu_iveautoapprovalsid := cur_ive_record.iveautoapprovalsid;
		vl_eligibility_id := cur_ive_record.eligibility_id;
		vl_client_id := cur_ive_record.client_id;
		vl_eligibility_period_id := cur_ive_record.eligibility_period_id;
		vs_status_cd := cur_ive_record.status_cd;
		vs_approvalid := cur_ive_record.approvalid;
		vu_routingid := cur_ive_record.routingid;
		vs_tosecurityusersid := cur_ive_record.tosecurityusersid;
		vs_supervisor_name := cur_ive_record.supervisor_name ;
		vs_sqnm_sw := cur_ive_record.sqnm_sw;
		vl_removal_id := cur_ive_record.removal_id ;
		
		RAISE NOTICE 'vl_client_id >> %',vl_client_id;	
		RAISE NOTICE 'vl_eligibility_id >> %',vl_eligibility_id;
		RAISE NOTICE 'vl_eligibility_period_id >> %',vl_eligibility_period_id;	
		
		-- Update tb_eligibility_period
		update tb_eligibility_period
		set approvalstatus = 'APPROVED',
			approvedby = vs_supervisor_name,
			approvedon = now(),
			update_ts = now(),
			update_user_id = as_user_id
		where eligibility_period_id = vl_eligibility_period_id
			and delete_sw = 'N' ;
		
		al_sqlcode := SQLCODE;
		IF al_sqlcode < 0 THEN
			as_mess := 'Error in updating tb_eligibility_period - eligibility_period_id # ' || vl_eligibility_period_id ;
			al_sqlcode := -1;
			-- ROLLBACK;
			-- exit;
		END IF ;
		
		if al_sqlcode = 0 then
			-- Update routing
			update routing
			set routingstatustypeid = 72,-- Approved
				updatedby = vs_tosecurityusersid,
				updatedon = now()
			where routingid = vu_routingid
				and activeflag = 1 ;
			
			al_sqlcode := SQLCODE;
			IF al_sqlcode < 0 THEN
				as_mess := 'Error in updating routing - routingid # ' || vu_routingid ;
				al_sqlcode := -1;
				-- ROLLBACK;
				-- exit;
			END IF ;
		end if;	
		
		
		if al_sqlcode = 0 then
		-- Update fostercare audit for approval information
			update tb_ive_fostercare_audit
			set supervisorname = vs_supervisor_name,
				supervisorsubmissiondate = now(),
				updatedby = as_user_id,
				updatedon = now()				
			where eligibility_period_id = vl_eligibility_period_id ;	
			
			al_sqlcode := SQLCODE;
			IF al_sqlcode < 0 THEN
				as_mess := 'Error in updating fostercare audit - eligibility_period_id # ' || vl_eligibility_period_id ;
				al_sqlcode := -1;
				-- ROLLBACK;
				-- exit;
			END IF ;
		end if;	
		
		if al_sqlcode = 0 then
			-- Update tb_client_eligibility
			update tb_client_eligibility		
			set eligibility_status_cd = btrim(vs_status_cd),
				update_user_id = as_user_id,
				update_ts = now()
			where eligibility_id = vl_eligibility_id
				and delete_sw = 'N' ;
		
			al_sqlcode := SQLCODE;
			IF al_sqlcode < 0 THEN
				as_mess := 'Error in updating tb_client_eligibility - eligibility_id # ' || vl_eligibility_id ;
				al_sqlcode := -1;
				-- ROLLBACK;
				-- exit;
			END IF ;
		end if; 
		
		if al_sqlcode = 0 then 
		
			-- Generate the API Payload for CSMS Referral request
			
			select row_to_json(a) 
				into v_inputjson 
			from (
				select tce.client_id as "iveCaseNumber",
					(case when vs_sqnm_sw is not null then 'APPROVED' else 'PENDING' end) as "iveCaseStatus",
					(SELECT CASE WHEN btrim(tce.ELIGIBILITY_STATUS_CD) IN ('2913','3597','3598') THEN 'F' else 'S' END) as "iveCaseType",
					(select tep.approvedon 
						from tb_eligibility_period tep 
					where tce.eligibility_id = tep.eligibility_id 
					order by update_ts desc 
					limit 1)::date as "iveApprovalDate",
					(case when tce.start_dt::date is not null then tce.start_dt::date 
					when isrcr.removaldate::date is not null then isrcr.removaldate::date
					else '0001-01-01' end) as "effectiveDate",
					(case when tce.end_dt::date is not null then tce.end_dt 
					when isrcr.exitdate::date is not null then isrcr.exitdate::date        
					else '0001-01-01' end) as "iveGrantEndDate",
					(case when  -- v_ive_eligibility 
						(SELECT inputjson->> 'iveCaseType' 
							FROM ivecsesoutbounddata ivb 
						where ivb.clientid = tce.client_id 
							and ivb.removalid = tce.removal_id 
							and ivb.activeflag = 1
						)	
						<>  -- v_eligibility_check 
						(select (CASE WHEN btrim(tce.ELIGIBILITY_STATUS_CD) IN ('2913','3597','3598') THEN 
									'F' 
								else 
									'S' 
								END ) 
						from tb_client_eligibility tce 
						where tce.client_id = tce.client_id 
							and tce.removal_id = tce.removal_id
						limit 1
						)	
						and -- v_count 
						(select count(*) 
							from ivecsesoutbounddata ivb 
						where ivb.clientid = tce.client_id
							and ivb.removalid = tce.removal_id
							and ivb.csmsreferralid is not null
						)
						<> 0 then 
						'UPDT-E'
					when -- v_agencyDetails 
						(SELECT inputjson->'children' -> 0 -> 'fosterCareDetails' -> 'providerid' 
							FROM ivecsesoutbounddata ivb 
						where ivb.clientid = tce.client_id
							and ivb.removalid = tce.removal_id
							and ivb.activeflag = 1 
						)::character varying
						<> -- v_validate_agency 
						(select tp.altproviderid 
							from placement tp 
								join intakeservreqchildremoval isrcr2 
									on isrcr2.intakeservreqchildremovalid = tp.intakeservreqchildremovalid 
						where tp.placementtypekey = 'PRPL'
							and isrcr2.removalid::bigint= tce.removal_id
							AND tp.activeflag = 1 
						order by tp.updatedon desc 
						limit 1)::character varying
						and -- v_count 
						(select count(*) 
							from ivecsesoutbounddata ivb 
						where ivb.clientid = tce.client_id 
							and ivb.removalid = tce.removal_id
							and ivb.csmsreferralid is not null
						)
						<> 0 then 
						'UPDT-P'
					when (select ivb.csmsreferralid 
							from ivecsesoutbounddata ivb
						  where ivb.clientid = tce.client_id 
							and ivb.removalid = tce.removal_id
						  order by ivb.csmsreferralid 
						  limit 1) is not null then 
						'UPDT' 
					else 
						'NAPP' 
					end) "ivdRecordType",
					(case when (select fam.fund_allocation_date from tb_fund_allocation_master fam                                                                      
						inner  join tb_payment_detail tpd on tpd.payment_detail_id= fam.payment_detail_id and tpd.delete_sw ='N'               
						inner  join tb_payment_header tph on tph.payment_id= tpd.payment_id and tph.delete_sw='N'                              
						inner  join person P on p.cjamspid=tpd.client_id                                                                      
						where tpd.client_id= tce.client_id and fam.delete_sw='N'  order by fam.update_ts desc limit 1)::date is not null then (select fam.fund_allocation_date from tb_fund_allocation_master fam                                                                      
						inner  join tb_payment_detail tpd on tpd.payment_detail_id= fam.payment_detail_id and tpd.delete_sw ='N'               
						inner  join tb_payment_header tph on tph.payment_id= tpd.payment_id and tph.delete_sw='N'                              
						inner  join person P on p.cjamspid=tpd.client_id                                                                      
					where tpd.client_id= tce.client_id and fam.delete_sw='N'  order by fam.update_ts desc limit 1):: date else '0001-01-01' end
					) as "iveGrantDate",
					(select fam.funding_amount_no from tb_fund_allocation_master fam                                                                      
						inner  join tb_payment_detail tpd on tpd.payment_detail_id= fam.payment_detail_id and tpd.delete_sw ='N'               
						inner  join tb_payment_header tph on tph.payment_id= tpd.payment_id and tph.delete_sw='N'                              
						inner  join person P on p.cjamspid=tpd.client_id                                                                      
					where tpd.client_id= tce.client_id and fam.delete_sw='N'  order by fam.update_ts desc limit 1
					) as "iveGrantAmount",
					'N' as "parentalRightsTerminationInd",
					'N' as "courtOrderInd",
					null as "courtOrderType",
					null as "familyViolenceIndicator",
					(case when -- v_count 
						(select count(*) 
							from ivecsesoutbounddata ivb 
						where ivb.clientid = tce.client_id 
							and ivb.removalid = tce.removal_id 
							and ivb.csmsreferralid is not null
						)	
						> 0 then 
						(select ivb.csmsreferralid 
							from ivecsesoutbounddata ivb 
						where ivb.clientid = tce.client_id 
							and ivb.removalid = tce.removal_id
						order by ivb.csmsreferralid 
						limit 1) 
					else 
						null 
					end) as "referralId",
					now():: date as "referralDate",
					null as "referralWorkerCaseNotes",
					(select icc.countycode 
						from ivecsescountycodes icc 
					where icc.description 
					in (select c.countyname  
						from caseassignment ca 
							join servicecase sc on ca.objectid = sc.servicecaseid 
							join intakeservreqchildremoval isrcr on isrcr.servicecaseid = sc.servicecaseid  
							join intakeservicerequestactor isra on isra.intakeservicerequestactorid = isrcr.intakeservicerequestactorid
							join person p on p.personid = isra.personid 
							join county c on c.countyid = ca.toldssid and c.activeflag =1
						where p.cjamspid::bigint = tce.client_id 
						order by ca.updatedon desc 
						limit 1
						)
					) as "referralJurisd", 
					(select up.fullname 
						from userprofile up 
					where up.securityusersid =  vs_tosecurityusersid 
					limit 1
					)  as "referralWorkerName",
					(select icc.fipscode 
						from ivecsescountycodes icc 
					where icc.description in (select c.countyname from caseassignment ca 
						join servicecase sc on ca.objectid = sc.servicecaseid 
						join intakeservreqchildremoval isrcr on isrcr.servicecaseid = sc.servicecaseid  
						join intakeservicerequestactor isra on isra.intakeservicerequestactorid = isrcr.intakeservicerequestactorid
						join person p on p.personid = isra.personid 
						join county c on c.countyid = ca.toldssid and c.activeflag =1
					where p.cjamspid::bigint = tce.client_id 
					order by ca.updatedon desc 
					limit 1)) as "referralWorkerCounty",
					(select up.email 
						from userprofile up 
					where up.securityusersid = vs_tosecurityusersid 
					limit 1
					)  as "referralWorkerEmail",
					(select NULLIF(regexp_replace(upn.phonenumber, '\D','','g'), '') 
					from userprofilephonenumber upn 
					where upn.securityusersid = vs_tosecurityusersid 
					limit 1
					) as "referralWorkerPhone",
					-- Children Details 
					(SELECT  json_agg(a)  FROM  (SELECT 
						p.cisclientid:: numeric as "childIrn",
						TRIM(p.firstname) as "firstName",
						TRIM(p.lastname)  as "lastName",
						TRIM(p.middlename) as "middleName",
						p.suffix  as "suffixName",
						p.maidenname as "maidenName",
						(CASE WHEN p.racetypekey LIKE '%WH%' THEN 'WH'
						WHEN  p.racetypekey LIKE '%AI%' THEN 'AI'
						WHEN  p.racetypekey LIKE '%AN%' THEN 'AN'
						WHEN  p.racetypekey LIKE '%BA%' THEN 'BA'
						WHEN  p.racetypekey LIKE '%AS%' THEN 'AS'
						WHEN  p.racetypekey LIKE '%PI%' THEN 'PI'
						ELSE 'UN'
						END) as race,
						p.gendertypekey as gender,
						p.dob:: date as "dateOfBirth",
						p.ssnno as ssn,
						'RE' as "childMbrType",
						-- healthInsuranceDetails
						(select row_to_json(c) from(
						select pis.medicalinsuranceprovider as "insuranceCarrierName", 'CHILD' as "isInsuranceCoveredBy",pis.policynumber as "insurancePolicyNumber",pis.groupnumber as "insuranceGroupNumber",tpv.description_tx as "insCoveredBy",
						pis.effectivedate:: date as "effectiveDate", pis.expirationdate as "expirationDate",pis.ismedicaidmedicare ,'' as "isInsProvidedByEmployer",'' as "insProvidedByEmployerId", '' as "otherProviderName"
						from personhealthinsurance pis
						left join tb_picklist_values tpv on tpv.picklist_value_cd = pis.patientpolicyholderrelation and tpv.picklist_type_id = 172 
						where pis.personid = p.personid order by pis.updatedon desc limit 1
						) c ) as "healthInsuranceDetails",
						'N' as "paternityEstablishedInd",
						'' as "medicalCoverageInd",
						-- fosterCare Agency Details
						(select row_to_json(d) from
							(select  (CASE WHEN (tbp.provider_nm is null OR btrim(tbp.provider_nm)='') 
								THEN CONCAT(tbp.provider_first_nm,' ',tbp.provider_last_nm)::character varying ELSE tbp.provider_nm END) as "agencyName",
								tp.altproviderid as "providerid",
								placementtypekey as "agencyPlacementCd",
								'' as "agencyPhoneNum",
								'' as "agencyFax",
								(select row_to_json(b) from(
								select tpa.adr_street_tx as "addressLine1",
								tpa.adr_street_nm as "addressLine2" ,tpa.adr_city_nm as city ,tpa.adr_state_cd as state,tpa.adr_zip5_no::varchar as "zipCode",'USA' as country,
								'' as "smartyStreetValidatedInd",
								null as "addrVerificationDt",
								'N' as "isInternationalAddr",
								tpa.adr_county_cd as "county",
								'0001-01-01' as "lastAddrDt",
								'' as "addrExist"            
								) b ) as "agencyAddress"
							from placement tp 
								join tb_services tbs on tbs.service_id = tp.service_id 
								join tb_provider tbp on tbp.provider_id = tp.altproviderid
								join tb_provider_addresses  tpa on tpa.parent_key_id = tbp.provider_id::character varying and tpa.adr_type_cd in ('3357', '3358') and tpa.delete_sw = 'N' AND tpa.adr_default_sw = 'Y'
								join intakeservreqchildremoval isrcr2 on isrcr2.intakeservreqchildremovalid = tp.intakeservreqchildremovalid and isrcr.activeflag = 1
							where tp.placementtypekey = 'PRPL' and isrcr2.removalid::bigint= isrcr.removalid AND tp.activeflag = 1 order by isrcr2.updatedon desc limit 1
							) d 
						) as "fosterCareDetails",
						(select personidentifiervalue mdm_id 
							from personidentifier pf where pf.personid=p.personid and pf.personidentifiertypekey='MDM_ID' LIMIT 1
						) as "mdmId",
						'' as "childOnCrtord",
						null as "tprInitDate",
						(select email from personemail p2 where p2.personid = p.personid and p2.activeflag = 1 limit 1),
						(select row_to_json(b) from
							(select pa.address as "addressLine1",
								pa.address2 as "addressLine2" ,pa.city ,pa.state,pa.zipcode::varchar as "zipCode",(select c.statecountycode from county c where c.countyid:: character varying = pa.county limit 1) as county,pa.country, 'N' as "smartyStreetValidatedInd", 'N' as "isInternationalAddr",'0001-01-01' as "lastAddrDt", null as "addrVerificationDt"  from personaddress pa where pa.personid = p.personid and pa.currentlocationflag = 1 order by pa.updatedon desc limit 1
							) b 
						) as "resAddress",
						(select row_to_json(b) from
							(select pa.address as "addressLine1",
								pa.address2 as "addressLine2" ,pa.city ,pa.state,pa.zipcode::varchar as "zipCode",(select c.statecountycode from county c where c.countyid:: character varying = pa.county limit 1) as county,pa.country, 'N' as "smartyStreetValidatedInd", 'N' as "isInternationalAddr",'0001-01-01' as "lastAddrDt" , null as "addrVerificationDt" from personaddress pa where pa.personid = p.personid and pa.currentlocationflag = 1 order by pa.updatedon desc limit 1
							) b 
						) as "mailingAddress"
						) a 
					)::json  AS  children,
					-- Parent Info
					(case when -- v_parentinfocheck 
						(select count(ar.*) 
						FROM actorrelationship ar
							join person per on per.personid = ar.person1id --and per.dateofdeath is null
						WHERE ar.person2id = (select personid from person where cjamspid = tce.client_id )::uuid
							AND ar.activeflag = 1
							AND ar.relationshiptypekey IN ('BGFTHR','ADPFTHR','BGMTHR','ADPMTHR')
						)
						> 0 then 
							(SELECT json_agg(d) FROM (
							(select per.cjamspid as clientid, 
							per.personid ,
							peri.personidentifiervalue as "mdmId",
							per.cisclientid::numeric as "ncpIrn",
							TRIM(per.firstname) as "firstName",
							TRIM(per.lastname)  as "lastName",
							TRIM(per.middlename) as "middleName",
							per.suffix  as "suffixName",
							per.maidenname as "maidenName",
							(CASE WHEN per.racetypekey LIKE '%WH%' THEN 'WH'
							WHEN  per.racetypekey LIKE '%AI%' THEN 'AI'
							WHEN  per.racetypekey LIKE '%AN%' THEN 'AN'
							WHEN  per.racetypekey LIKE '%BA%' THEN 'BA'
							WHEN  per.racetypekey LIKE '%AS%' THEN 'AS'
							WHEN  per.racetypekey LIKE '%PI%' THEN 'PI'
							ELSE 'UN'
							END) as race,
							per.gendertypekey as gender,
							per.dob:: date as "dateOfBirth",
							per.ssnno as ssn,
							'AP' as "ncpMbrType",
							'' as "ncpRelationshipCode",
							'' as "ncpLegalEstablishedInd",
							'0001-01-01' as "ncpLegalEstablishedDate",
							'' as "ncpBirthHospital",
							'' as "ncpBirthCity",
							'' as "ncpBirthState",
							'' as "ncpDeathDate",
							'' as "ncpMaritalStatus",
							'' as "ncpMarriageDate",
							'' as "ncpMarriageTermDate",
							'' as "ncpMarriageTermCity",
							'' as "healthInsuranceInd",
							(select email from personemail p2 where p2.personid = per.personid and p2.activeflag = 1 limit 1),
							null as "lastKnownAddressType",
							(select row_to_json(b) from(
							select pa.address as "addressLine1",
							pa.address2 as "addressLine2" ,pa.city ,pa.state,pa.zipcode::varchar as "zipCode",(select c.statecountycode from county c where c.countyid:: character varying = pa.county limit 1) as county ,pa.country, 'N' as "smartyStreetValidatedInd", 'N' as "isInternationalAddr", '0001-01-01' as "lastAddrDt" from personaddress pa where pa.personid = per.personid and pa.activeflag = 1 and pa.currentlocationflag = 1 order by pa.updatedon desc limit 1
							) b ) as "lastKnownAddress",
							(select row_to_json(b) from (
							select pe.employername as "employerName",
							pe.mobile as "phoneNum",
							pe.startdate as "startDate",
							pe.enddate as "endDate",
							(select row_to_json(b) from(
							select p2.address1 as "addressLine1",p2.address2 as "addressLine2",
							p2.cityname ,p2.statetypekey ,p2.zip5no:: varchar as "zipCode",p2.countytypekey ,p2.country,
							'' as "smartyStreetValidatedInd",
							null as "addrVerificationDt",
							'N' as "isInternationalAddr",
							'0001-01-01' as "lastAddrDt",
							'' as "addrExist"
							from personemployment p2  where p2.personid = per.personid and p2.activeflag = 1 order by p2.updatedon desc limit 1
							) b ) as "employerAddress"
							from personemployment pe 
							where pe.personid = per.personid and pe.activeflag = 1 order by pe.updatedon desc limit 1
							) as b) as "lastKnownEmployerDetails",
							(select row_to_json(b) from(
							select ps.startdate as "militaryStartDt", ps.enddate as "militaryEndDt",ps.branchkey as "militaryBranch" from personmilitaryservices ps
							where ps.personid = per.personid and ps.activeflag = 1 order by ps.updatedon desc limit 1
							) b ) as "militaryServiceDetails",
							(select row_to_json(c) from(
							select pis.medicalinsuranceprovider as "insuranceCarrierName", pis.policynumber as "insurancePolicyNumber",pis.groupnumber as "insuranceGroupNumber",tpv.description_tx as "insCoveredBy",
							pis.effectivedate:: date as "effectiveDate", pis.expirationdate as "expirationDate",pis.ismedicaidmedicare ,'' as "isInsProvidedByEmployer",'' as "insProvidedByEmployerId", '' as "otherProviderName"
							from personhealthinsurance pis
							left join tb_picklist_values tpv on tpv.picklist_value_cd = pis.patientpolicyholderrelation and tpv.picklist_type_id = 172 
							where pis.personid = per.personid and pis.activeflag = 1 order by pis.updatedon desc limit 1
							) c ) as "healthInsuranceDetails"
							from actorrelationship ar 
							join person per on per.personid = ar.person1id --and per.dateofdeath is null
							left join personidentifier peri on peri.personid = ar.person1id and peri.personidentifiertypekey = 'MDM_ID' and peri.activeflag = 1 
							left join personphonenumber perpn on perpn.personid = ar.person1id and perpn.activeflag = 1 and perpn.personphonetypekey = 'P'
							where ar.person2id = p.personid ::uuid and ar.activeflag = 1 and ar.relationshiptypekey in ('BGMTHR', 'ADPMTHR') order by ar.insertedon desc limit 1)
							UNION ALL
							(select per.cjamspid as clientid, 
							per.personid ,
							peri.personidentifiervalue as "mdmId",
							per.cisclientid::numeric as "ncpIrn",
							TRIM(per.firstname) as "firstName",
							TRIM(per.lastname)  as "lastName",
							TRIM(per.middlename) as "middleName",
							per.suffix  as "suffixName",
							per.maidenname as "maidenName",
							(CASE WHEN per.racetypekey LIKE '%WH%' THEN 'WH'
							WHEN  per.racetypekey LIKE '%AI%' THEN 'AI'
							WHEN  per.racetypekey LIKE '%AN%' THEN 'AN'
							WHEN  per.racetypekey LIKE '%BA%' THEN 'BA'
							WHEN  per.racetypekey LIKE '%AS%' THEN 'AS'
							WHEN  per.racetypekey LIKE '%PI%' THEN 'PI'
							ELSE 'UN'
							END) as race,
							per.gendertypekey as gender,
							per.dob:: date as "dateOfBirth",
							per.ssnno as ssn,
							'AP' as "ncpMbrType",
							'' as "ncpRelationshipCode",
							'' as "ncpLegalEstablishedInd",
							'0001-01-01' as "ncpLegalEstablishedDate",
							'' as "ncpBirthHospital",
							'' as "ncpBirthCity",
							'' as "ncpBirthState",
							'' as "ncpDeathDate",
							'' as "ncpMaritalStatus",
							'' as "ncpMarriageDate",
							'' as "ncpMarriageTermDate",
							'' as "ncpMarriageTermCity",
							'' as "healthInsuranceInd",
							(select email from personemail p2 where p2.personid = per.personid and p2.activeflag = 1 limit 1),
							null as "lastKnownAddressType",
							(select row_to_json(b) from(
							select pa.address as "addressLine1",
							pa.address2 as "addressLine2" ,pa.city ,pa.state,pa.zipcode::varchar as "zipCode",(select c.statecountycode from county c where c.countyid:: character varying = pa.county limit 1) as county ,pa.country, 'N' as "smartyStreetValidatedInd", 'N' as "isInternationalAddr", '0001-01-01' as "lastAddrDt" from personaddress pa where pa.personid = per.personid and pa.activeflag = 1 and pa.currentlocationflag = 1 order by pa.updatedon desc limit 1
							) b ) as "lastKnownAddress",
							(select row_to_json(b) from (
							select pe.employername as "employerName",
							pe.mobile as "phoneNum",
							pe.startdate as "startDate",
							pe.enddate as "endDate",
							(select row_to_json(b) from(
							select p2.address1 as "addressLine1",p2.address2 as "addressLine2",
							p2.cityname ,p2.statetypekey ,p2.zip5no::varchar as "zipCode",p2.countytypekey ,p2.country,
							'' as "smartyStreetValidatedInd",
							null as "addrVerificationDt",
							'N' as "isInternationalAddr",
							'0001-01-01' as "lastAddrDt",
							'' as "addrExist"
							from personemployment p2  where p2.personid = per.personid and p2.activeflag = 1 order by p2.updatedon desc limit 1
							) b ) as "employerAddress"
							from personemployment pe 
							where pe.personid = per.personid and pe.activeflag = 1 order by pe.updatedon desc limit 1
							) as b) as "lastKnownEmployerDetails",
							(select row_to_json(b) from(
							select ps.startdate as "militaryStartDt", ps.enddate as "militaryEndDt",ps.branchkey as "militaryBranch" from personmilitaryservices ps
							where ps.personid = per.personid and ps.activeflag = 1 order by ps.updatedon desc limit 1
							) b ) as "militaryServiceDetails",
							(select row_to_json(c) from(
							select pis.medicalinsuranceprovider as "insuranceCarrierName", pis.policynumber as "insurancePolicyNumber",pis.groupnumber as "insuranceGroupNumber",tpv.description_tx as "insCoveredBy",
							pis.effectivedate:: date as "effectiveDate", pis.expirationdate as "expirationDate",pis.ismedicaidmedicare ,'' as "isInsProvidedByEmployer",'' as "insProvidedByEmployerId", '' as "otherProviderName"
							from personhealthinsurance pis
							left join tb_picklist_values tpv on tpv.picklist_value_cd = pis.patientpolicyholderrelation and tpv.picklist_type_id = 172 
							where pis.personid = per.personid and pis.activeflag = 1 order by pis.updatedon desc limit 1
							) c ) as "healthInsuranceDetails"
							from actorrelationship ar 
							join person per on per.personid = ar.person1id --and per.dateofdeath is null
							left join personidentifier peri on peri.personid = ar.person1id and peri.personidentifiertypekey = 'MDM_ID' and peri.activeflag = 1 
							left join personphonenumber perpn on perpn.personid = ar.person1id and perpn.activeflag = 1 and perpn.personphonetypekey = 'P'
							where ar.person2id = p.personid ::uuid and ar.activeflag = 1 and ar.relationshiptypekey in ('BGFTHR','ADPFTHR') order by ar.insertedon desc limit 1)
							) d ) 
					else 
						(SELECT json_agg(d) FROM (
						select 0 as clientid, 
						'unknown' as personid ,
						'MDT-0' as "mdmId",
						0 as "ncpIrn",
						'unknown' as "firstName",
						'unknown' as "lastName",
						'unknown' as "middleName",
						null  as "suffixName",
						null as "maidenName",
						'UN' as race,
						'O' as gender,
						'9999-12-12' as "dateOfBirth",
						'0' as ssn,
						'AP' as "ncpMbrType",
						'' as "ncpRelationshipCode",
						'' as "ncpLegalEstablishedInd",
						'9999-12-12' as "ncpLegalEstablishedDate",
						'' as "ncpBirthHospital",
						'' as "ncpBirthCity",
						'' as "ncpBirthState",
						'' as "ncpDeathDate",
						'' as "ncpMaritalStatus",
						'' as "ncpMarriageDate",
						'' as "ncpMarriageTermDate",
						'' as "ncpMarriageTermCity",
						'' as "healthInsuranceInd",
						null as "email",
						null as "lastKnownAddressType",
						null as "lastKnownAddress",
						null  as "lastKnownEmployerDetails",
						null as "militaryServiceDetails",
						null as "healthInsuranceDetails"
						) d  )
					end) as "nonCustodialParents"
				from tb_client_eligibility tce 
					inner join person p on p.cjamspid = tce.client_id and activeflag = 1
					INNER JOIN intakeservreqchildremoval isrcr ON isrcr.removalid = tce.removal_id 
						AND isrcr.activeflag=1 --AND isrcr.exitdate is null
					INNER JOIN placement pl on (( pl.intakeservreqchildremovalid = isrcr.intakeservreqchildremovalid 
						and pl.placementtypekey = 'PRPL') or (pl.placementtypekey = 'LA' and pl.personid = p.personid ))
				where tce.client_id = vl_client_id
					and tce.removal_id = vl_removal_id
					and btrim(tce.eligibility_type_cd) IN ('2931')
					and tce.delete_sw = 'N'
			) a
			limit 1 ;
			
			update cjams.ive_auto_approvals
			set auto_approval_process_sw = 'Y',
				auto_approval_date = now(),
				csmsrefpayload = v_inputjson,
				updatedby = as_user_id,
				updatedon = now(),
				comments = 'Auto approval request was successfully updated.'
			where iveautoapprovalsid = vu_iveautoapprovalsid ;
		else
			update cjams.ive_auto_approvals
			set -- auto_approval_process_sw = 'N',
				updatedby = as_user_id,
				updatedon = now(),
				comments = as_mess
			where iveautoapprovalsid = vu_iveautoapprovalsid ;
			
			-- ROLLBACK;
			-- exit;
		end if;
		
	END LOOP;	
	
	close cur_ive_REFCURSOR;
	
	
	-- Check & update the status for user approved IV-E determinations
	update cjams.ive_auto_approvals
	set auto_approval_process_sw = 'X',
		csmsref_process_sw = 'X',
		updatedby = as_user_id,
		updatedon = now(),
		comments = 'This IV-E determination was approved by the user, no auto approval is required.'
	where eligibility_period_id 
		in (	select ep.eligibility_period_id
				from ive_auto_approvals ived,
					tb_client_eligibility ce,
					tb_eligibility_period ep,
					routing ro,
					userprofile up
				where ived.eligibility_period_id = ep.eligibility_period_id
					and ce.eligibility_id = ep.eligibility_id
					and ep.approvalid = ro.objectid
					and ro.tosecurityusersid = up.securityusersid
					and ived.activeflag = 1
					and coalesce(ived.auto_approval_process_sw, 'N') = 'N' 
					and ce.delete_sw = 'N'
					and ep.delete_sw = 'N'
					and ep.approvalstatus = 'APPROVED'
					and ro.eventcode = 'PLTR'
					and ro.routingstatustypeid = 72 -- Approved
					and ro.activeflag = 1 
			);  
	
	al_sqlcode := 0;
	as_mess :=  'success' ;
		
END;

$function$
;

