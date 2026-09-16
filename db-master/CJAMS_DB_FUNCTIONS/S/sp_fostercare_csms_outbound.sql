DROP FUNCTION IF EXISTS cjams.sp_fostercare_csms_outbound(character varying, bigint, bigint, varchar);
CREATE OR REPLACE FUNCTION cjams.sp_fostercare_csms_outbound(userid character varying, clientid bigint, removalid bigint, reviewperiod character varying)
 RETURNS json
 LANGUAGE plpgsql
AS $function$ 

-------------------------------------------------
---05-03 - Veera Issue fix for NCP details
-- CSMS _referral Issue Fix
-- CIDM-6411 - Issue for Adoption Removal
-- CIDM-7109 - Zipcode issue fix
-- CIDM-7361 - Subquery issue fix Veera 06-22
-- CIDM-7507 - Veera Removed case assignment end check 
-- CIDM-7475 - Veera Trimming the spaces in Names
-- CIDM-7552 - Veera Parent default value fixes
-- CIDM-7694 - Missing Agency Name fix
-- CIDM-7683 -  County Issue fix
-- CIDM-7951 - Phone number issue fix
-- CIDM-8015 - Veera TO fix the null start date issue 
-- CIDM-8539 - Veera CSMS- Outbound Failure due SSN length - 03-11-2024
-- CIDM-8759 - Veera To pass NCP case numbers and To pass the removal exit code and Updated IVE Grant Amount- New Fields
-- CIDM-8759 - Anil Adding a new outputjson
-- CIDM-8759 - To pass Living Arrangment details
-- CIDM-8759 - Veera To stop sending updates CSMS based on given dates - 12/26
-- CIDM-10004 - Veera CSMS Referral Failures when Primary Care giver is Empty - 01/02/2025
-- CIDM-10140 - Veera CLOS Record type issue fix 
-- CIDM-11325 - Veera 04-15-2026 CISCLIENT ID empty issue fix
-- CIDM-11593 - Veera 07-20-2026 Worker phone number length issue fix
----------------------------------------------------

DECLARE
returnStatus text;
al_clientid bigint;
al_removalid bigint;
v_inputjson json;
v_oldjson json;
v_result json;
v_referral_createddt date;
v_csms_updt_startdt date;
v_stop_csms_updt boolean;
v_count INTEGER;
v_countupdate INTEGER;
v_parentinfocheck integer;
outputjson json;
al_reviewperiod varchar;
al_referralcounty varchar;
v_securityuserid varchar;
v_agencyDetails varchar;
v_validate_agency varchar;
v_ive_eligibility varchar;
v_eligibility_check varchar;

begin
al_clientid = clientid;
al_removalid = removalid;
al_reviewperiod = reviewperiod;
v_securityuserid = userid;
v_stop_csms_updt = false;

select count(*) into v_countupdate from ivecsesoutbounddata ivb where ivb.clientid = al_clientid and ivb.removalid = al_removalid and ivb.activeflag = 1;

select inputjson INTO v_oldjson from ivecsesoutbounddata ivb WHERE ivb.clientid = al_clientid AND ivb.removalid = al_removalid AND ivb.activeflag = 1;


select insertedon::date into v_referral_createddt from ivecsesoutbounddata icd where icd.clientid = al_clientid and icd.removalid = al_removalid and icd.csmsreferralid is not null order by icd.insertedon desc limit 1;

select settingvalue::date into v_csms_updt_startdt from settings where settingname = 'csms_updt_startdt';

RAISE  NOTICE  '  v_referral_createddt  %',v_referral_createddt;    

RAISE  NOTICE  '  v_csms_updt_startdt  %',v_csms_updt_startdt;    

select count(ar.*) into v_parentinfocheck
FROM actorrelationship ar
join person per ON        per.personid = ar.person1id --and per.dateofdeath is null
WHERE ar.person2id = (select personid from person where cjamspid = al_clientid) ::uuid
AND ar.activeflag = 1
AND ar.relationshiptypekey IN ('BGFTHR','ADPFTHR','BGMTHR','ADPMTHR');

select count(*) into v_count from ivecsesoutbounddata ivb where ivb.clientid = al_clientid and ivb.removalid = al_removalid and ivb.csmsreferralid is not null;


SELECT inputjson->'children' -> 0 -> 'fosterCareDetails' -> 'providerid' into v_agencyDetails FROM ivecsesoutbounddata ivb where ivb.clientid = al_clientid and ivb.removalid = al_removalid and ivb.activeflag = 1; 

select tp.altproviderid into v_validate_agency  from placement tp 
  join intakeservreqchildremoval isrcr2 on isrcr2.intakeservreqchildremovalid = tp.intakeservreqchildremovalid 
  where tp.placementtypekey = 'PRPL' and isrcr2.removalid::bigint= al_removalid AND tp.activeflag = 1 order by tp.updatedon desc limit 1;

SELECT inputjson->> 'iveCaseType' into v_ive_eligibility FROM ivecsesoutbounddata ivb where ivb.clientid = al_clientid and ivb.removalid = al_removalid and ivb.activeflag = 1; 

select CASE WHEN btrim(tce.ELIGIBILITY_STATUS_CD) IN ('2913','3597','3598') THEN 'F' else 'S' END into v_eligibility_check from tb_client_eligibility tce 
where tce.client_id = al_clientid and tce.removal_id = al_removalid limit 1;

select icc.fipscode into al_referralcounty from ivecsescountycodes icc where icc.description in (select c.countyname from caseassignment ca 
	    join servicecase sc on ca.objectid = sc.servicecaseid 
	    join intakeservreqchildremoval isrcr on isrcr.servicecaseid = sc.servicecaseid  
	    join intakeservicerequestactor isra on isra.intakeservicerequestactorid = isrcr.intakeservicerequestactorid
	    join person p on p.personid = isra.personid 
	    join county c on c.countyid = ca.toldssid and c.activeflag =1
	    where p.cjamspid::bigint = al_clientid --and ca.enddate is null 
      order by ca.updatedon desc limit 1);



select row_to_json(a) into v_inputjson from (
      select tce.client_id as "iveCaseNumber",
       --(select tep.approvalstatus from tb_eligibility_period tep where tce.eligibility_id = tep.eligibility_id order by update_ts desc limit 1) 
       (case when al_reviewperiod is not null then 'APPROVED' else 'PENDING' end) as "iveCaseStatus",
       (SELECT CASE WHEN btrim(tce.ELIGIBILITY_STATUS_CD) IN ('2913','3597','3598') THEN 'F'
                            else 'S' END) as "iveCaseType",
       (select tep.approvedon from tb_eligibility_period tep where tce.eligibility_id = tep.eligibility_id order by update_ts desc limit 1)::date as "iveApprovalDate",
       (case when tce.start_dt::date is not null then tce.start_dt::date 
             when isrcr.removaldate::date is not null then isrcr.removaldate::date
            else '0001-01-01' end) as "effectiveDate",
       (case when tce.end_dt::date is not null then tce.end_dt 
             when isrcr.exitdate::date is not null then isrcr.exitdate::date        
             else '0001-01-01' end) as "iveGrantEndDate",
       (case when al_reviewperiod = 'Removal Exit' and v_count <> 0 and isrcr.exitdate::date is not null then 'CLOS'
             when v_ive_eligibility <> v_eligibility_check and v_count <> 0 then 'UPDT-E'
             when v_agencyDetails <> v_validate_agency and v_count <> 0 then 'UPDT-P'
             when (select ivb.csmsreferralid from ivecsesoutbounddata ivb where ivb.clientid = al_clientid and ivb.removalid = al_removalid order by ivb.csmsreferralid limit 1) is not null then 'UPDT' else 'NAPP' 
        end) "ivdRecordType",
       al_removalid as "iveRemovalId", 
        'FC' as "iveReferralProgram",
        (case when (v_countupdate > 0) and (v_csms_updt_startdt >= v_referral_createddt)
            then true 
            else false end
       )::boolean  "csmsupdatestop",
       (select rv.value_text from referencevalues rv where rv.referencetypeid = 53 AND rv.activeflag = 1 AND TRIM(rv.ref_key) = TRIM(isrcr.removaltypekey)) as "iveRemovalReason",
       (case when (select fam.fund_allocation_date from tb_fund_allocation_master fam                                                                      
       inner  join tb_payment_detail tpd on tpd.payment_detail_id= fam.payment_detail_id and tpd.delete_sw ='N'               
       inner  join tb_payment_header tph on tph.payment_id= tpd.payment_id and tph.delete_sw='N'                              
       inner  join person P on p.cjamspid=tpd.client_id                                                                      
       where tpd.client_id= tce.client_id and fam.delete_sw='N'  order by fam.update_ts desc limit 1)::date is not null then (select fam.fund_allocation_date from tb_fund_allocation_master fam                                                                      
       inner  join tb_payment_detail tpd on tpd.payment_detail_id= fam.payment_detail_id and tpd.delete_sw ='N'               
       inner  join tb_payment_header tph on tph.payment_id= tpd.payment_id and tph.delete_sw='N'                              
       inner  join person P on p.cjamspid=tpd.client_id                                                                      
       where tpd.client_id= tce.client_id and fam.delete_sw='N'  order by fam.update_ts desc limit 1):: date else '0001-01-01' end) as "iveGrantDate",
       (select fam.payment_amount from tb_fund_allocation_master fam                                                                      
       inner  join tb_payment_detail tpd on tpd.payment_detail_id= fam.payment_detail_id and tpd.delete_sw ='N'               
       inner  join tb_payment_header tph on tph.payment_id= tpd.payment_id and tph.delete_sw='N'                              
       inner  join person P on p.cjamspid=tpd.client_id                                                                      
       where tpd.client_id= tce.client_id and fam.delete_sw='N'  order by fam.update_ts desc limit 1) as "iveGrantAmount",
       'N' as "parentalRightsTerminationInd",
       'N' as "courtOrderInd",
       null as "courtOrderType",
       null as "familyViolenceIndicator",
       (case when v_count > 0 then (select ivb.csmsreferralid from ivecsesoutbounddata ivb where ivb.clientid = al_clientid and ivb.removalid = al_removalid order by ivb.csmsreferralid limit 1) else null end) as "referralId",
       now():: date as "referralDate",
       null as "referralWorkerCaseNotes",
     (select icc.countycode from ivecsescountycodes icc where icc.description in (select c.countyname  
         from caseassignment ca 
	    join servicecase sc on ca.objectid = sc.servicecaseid 
	    join intakeservreqchildremoval isrcr on isrcr.servicecaseid = sc.servicecaseid  
	    join intakeservicerequestactor isra on isra.intakeservicerequestactorid = isrcr.intakeservicerequestactorid
	    join person p on p.personid = isra.personid 
	    join county c on c.countyid = ca.toldssid and c.activeflag =1
	    where p.cjamspid::bigint = al_clientid order by ca.updatedon desc limit 1)) as "referralJurisd", 
     (select up.fullname from userprofile up where up.securityusersid = v_securityuserid limit 1)  as "referralWorkerName",
     (select icc.fipscode from ivecsescountycodes icc where icc.description in (select c.countyname from caseassignment ca 
	    join servicecase sc on ca.objectid = sc.servicecaseid 
	    join intakeservreqchildremoval isrcr on isrcr.servicecaseid = sc.servicecaseid  
	    join intakeservicerequestactor isra on isra.intakeservicerequestactorid = isrcr.intakeservicerequestactorid
	    join person p on p.personid = isra.personid 
	    join county c on c.countyid = ca.toldssid and c.activeflag =1
	    where p.cjamspid::bigint = al_clientid order by ca.updatedon desc limit 1)) as "referralWorkerCounty",
     (select up.email from userprofile up where up.securityusersid = v_securityuserid limit 1)  as "referralWorkerEmail",
     (select NULLIF(LEFT(regexp_replace(upn.phonenumber, '\D', '', 'g'), 10), '') from userprofilephonenumber upn where upn.securityusersid = v_securityuserid and upn.activeflag = 1 order by upn.insertedon desc limit 1) as "referralWorkerPhone",
        -- Children Details 
        (SELECT  json_agg(a)  FROM  (SELECT 
        (CASE WHEN p.cisclientid ~ '^[0-9\.]+$' THEN p.cisclientid::numeric ELSE NULL END) as "childIrn",
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
          NULLIF(regexp_replace(p.ssnno, '\D','','g'), '') as ssn,
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
           (select row_to_json(d) from(
            select  (CASE when tp.placementtypekey = 'LA' and la.primarycaregiver is not null then la.primarycaregiver
            when tp.placementtypekey = 'LA' and la.primarycaregiver is null then 'NA' 
            WHEN (tbp.provider_nm is null OR btrim(tbp.provider_nm)='') THEN CONCAT(tbp.provider_first_nm,' ',tbp.provider_last_nm)::character varying ELSE tbp.provider_nm END) as "agencyName",
            tp.altproviderid as "providerid",
            placementtypekey as "agencyPlacementCd",
            '' as "agencyPhoneNum",
            '' as "agencyFax",
            tp.placementid as "placementid",
            tp.startdatetime::date as "placementStartDate",
            tp.enddatetime::date as "placementEndDate",
            (select row_to_json(b) from(
            select case when tp.placementtypekey = 'LA' then la.streetnumber::varchar else tpa.adr_street_tx end as "addressLine1",
            case when tp.placementtypekey = 'LA' then la.streetname else tpa.adr_street_nm end as "addressLine2" ,
            case when tp.placementtypekey = 'LA' then la.cityname else tpa.adr_city_nm end as city ,
            case when tp.placementtypekey = 'LA' then la.statetypekey else tpa.adr_state_cd end as state,
            case when tp.placementtypekey = 'LA' then la.zip5no::varchar else tpa.adr_zip5_no::varchar end as "zipCode", 
            'USA' as country,
            '' as "smartyStreetValidatedInd",
            null as "addrVerificationDt",
            'N' as "isInternationalAddr",
            case when tp.placementtypekey = 'LA' then la.countytypekey else  tpa.adr_county_cd end as "county",
            '0001-01-01' as "lastAddrDt",
            '' as "addrExist"            
            ) b ) as "agencyAddress"
            from placement tp 
          left join tb_services tbs on tbs.service_id = tp.service_id 
          left join tb_provider tbp on tbp.provider_id = tp.altproviderid
          left join tb_provider_addresses  tpa on tpa.parent_key_id = tbp.provider_id::character varying and tpa.adr_type_cd in ('3357', '3358') and tpa.delete_sw = 'N' AND tpa.adr_default_sw = 'Y'
          left join livingarrangement la on la.placementid =tp.placementid and la.activeflag = 1
          join intakeservreqchildremoval isrcr2 on isrcr2.intakeservreqchildremovalid = tp.intakeservreqchildremovalid and isrcr.activeflag = 1
          join placementrevision pcr on pcr.placementid = tp.placementid and pcr.activeflag = 1
          where tp.placementtypekey in ('LA','PRPL') and isrcr2.removalid::bigint= isrcr.removalid AND tp.activeflag = 1 and pcr.approvalstatustypkey = '3047' order by tp.updatedon desc limit 1
           ) d ) as "fosterCareDetails",
          (select personidentifiervalue mdm_id from personidentifier pf where pf.personid=p.personid and pf.personidentifiertypekey='MDM_ID' LIMIT 1) as "mdmId",
          '' as "childOnCrtord",
          null as "tprInitDate",
          (select email from personemail p2 where p2.personid = p.personid and p2.activeflag = 1 limit 1),
          (select row_to_json(b) from(
           select pa.address as "addressLine1",
           pa.address2 as "addressLine2" ,pa.city ,pa.state,pa.zipcode::varchar as "zipCode",(select c.statecountycode from county c where c.countyid:: character varying = pa.county limit 1) as county,pa.country, 'N' as "smartyStreetValidatedInd", 'N' as "isInternationalAddr",'0001-01-01' as "lastAddrDt", null as "addrVerificationDt"  from personaddress pa where pa.personid = p.personid and pa.currentlocationflag = 1 order by pa.updatedon desc limit 1
          ) b ) as "resAddress",
          (select row_to_json(b) from(
            select pa.address as "addressLine1",
            pa.address2 as "addressLine2" ,pa.city ,pa.state,pa.zipcode::varchar as "zipCode",(select c.statecountycode from county c where c.countyid:: character varying = pa.county limit 1) as county,pa.country, 'N' as "smartyStreetValidatedInd", 'N' as "isInternationalAddr",'0001-01-01' as "lastAddrDt" , null as "addrVerificationDt" from personaddress pa where pa.personid = p.personid and pa.currentlocationflag = 1 order by pa.updatedon desc limit 1
          ) b ) as "mailingAddress"
        ) a )::json  AS  children,
        -- Parent Info
        (case when v_parentinfocheck > 0 then 
        (SELECT json_agg(d) FROM (
         (select per.cjamspid as clientid, 
         per.personid ,
         peri.personidentifiervalue as "mdmId",
         (CASE WHEN per.cisclientid ~ '^[0-9\.]+$' THEN per.cisclientid::numeric ELSE NULL END) as "ncpIrn",
         csms.ncpcasenumber::numeric as "ivdCaseNumber",
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
         NULLIF(regexp_replace(per.ssnno, '\D','','g'), '') as ssn,
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
         left join ivecsmsncpcasedetails csms on csms.clientid = al_clientid and per.cjamspid = csms.ncpclientid and csms.activeflag = 1
         left join personphonenumber perpn on perpn.personid = ar.person1id and perpn.activeflag = 1 and perpn.personphonetypekey = 'P'
         where ar.person2id = p.personid ::uuid and ar.activeflag = 1 and ar.relationshiptypekey in ('BGMTHR', 'ADPMTHR') order by ar.insertedon desc limit 1)
         UNION ALL
         (select per.cjamspid as clientid, 
         per.personid ,
         peri.personidentifiervalue as "mdmId",
         (CASE WHEN per.cisclientid ~ '^[0-9\.]+$' THEN per.cisclientid::numeric ELSE NULL END) as "ncpIrn",
         csms.ncpcasenumber::numeric as "ivdCaseNumber",
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
         NULLIF(regexp_replace(per.ssnno, '\D','','g'), '') as ssn,
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
         left join ivecsmsncpcasedetails csms on csms.clientid = al_clientid and per.cjamspid = csms.ncpclientid and csms.activeflag = 1
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
        inner join person p on p.cjamspid  = tce.client_id and activeflag = 1
        INNER JOIN intakeservreqchildremoval isrcr ON isrcr.removalid = tce.removal_id AND isrcr.activeflag=1 --AND isrcr.exitdate is null
        INNER JOIN placement pl on (( pl.intakeservreqchildremovalid = isrcr.intakeservreqchildremovalid and pl.placementtypekey = 'PRPL') or (pl.placementtypekey = 'LA' and pl.personid = p.personid ))
        where tce.client_id = al_clientid and tce.removal_id = al_removalid and btrim(tce.eligibility_type_cd) IN ('2931')
        and tce.delete_sw = 'N') a;

IF v_countupdate > 0 THEN 
   update ivecsesoutbounddata cb set activeflag = 0, updatedon = now()  where cb.clientid = al_clientid and cb.removalid = al_removalid and cb.activeflag = 1;
end if;

insert into  cjams.ivecsesoutbounddata (ivecsesoutboundid, inputjson, reviewperiod, clientid, removalid , activeflag, insertedon, updatedon, referralcounty) 
values (gen_random_uuid(),v_inputjson,al_reviewperiod,al_clientid,al_removalid,1,now(),now(), al_referralcounty);        

return json_build_object('new_data', v_inputjson, 'old_data', v_oldjson);

end
 $function$
;
