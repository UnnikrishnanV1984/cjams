DROP FUNCTION IF EXISTS cjams.sp_adoption_eligibility_worksheet_info(bigint, bigint);

CREATE OR REPLACE FUNCTION cjams.sp_adoption_eligibility_worksheet_info(al_client_id bigint, al_removal_id bigint)
 RETURNS TABLE(clientid bigint, countyofjurisdiction character varying, childagency character varying, servicecaseid uuid, casenumber character varying, removalid bigint, dateofbirth timestamp without time zone, gender character varying, personid uuid, nameofchild character varying, childraceethnicity character varying, isuscitizen character varying, isqualifiedalien character varying, 
 				adoptionassistancestartdate timestamp without time zone, effortstoplacechildweremade character varying, dateofadoptionfinalization timestamp without time zone, adoptionpetitiondate timestamp without time zone, childdeprivedofparentalsupport character varying, issingleparent integer,	dateoflatestpaymentofminorparent timestamp without time zone, tprdetails json, 
				isafdceligibilitymet character varying, wasthechildremovedfromspecifiedrelative character varying, isincomeassetsmet character varying, provideridofadoptiveparent integer, nameofAdoptiveParent1 character varying, dtofdocforeffortstoplacewithoutasubsidy timestamp without time zone, exceptiongrantedinchildsbestinterests character varying, 
				dtofdocumentationforexceptiongrantedinchildsbi timestamp without time zone, childmeetsssimedicaldisabledeligliblerequirements character varying, childreceivingssiatremoval character varying, adoptionparent1signdate timestamp without time zone, adoptionparent2signdate timestamp without time zone, adoptionldssdate timestamp without time zone, 
				singleparentadoptioncheck integer, childapplicabilitystatus character varying, age integer, nameofadoptiveparent2 character varying, isreasonforexceptionrecorded character varying,canchildreturntohome character varying, descriptionofreturnhome character varying, childmeetallmedicaldisabilityrequirementsforssi character varying, child617yearsofage boolean, 
				physicalmentalemotionaldisability boolean, emotionaldisturbance boolean, siblinginformationcheck 	boolean, recognizedhighriskofphysicaldisability boolean, raceethnicityofchild  boolean,	unsuccessfulreasonableeffortsstatusrecords 	character varying, childapplicableassessmentdt timestamp without time zone, removalcourtorderdate timestamp without time zone, 
				childremovaldate timestamp without time zone, childspreviouslyadopted character varying, voluntaryrelinquishment character varying, startdateofreceivingssi timestamp without time zone, isthechildresidinginafosterfamilyhome character varying, ivestatus character varying, childsivestatusofpreviousadoption character varying, previousadoptiveparentstpr timestamp without time zone,
				adoptiveparentstprdate timestamp without time zone, createdate timestamp without time zone, siblingsinfo JSON, minorparentinfo JSON, raceorethnicitywithoneofthesabove character varying, adoptionapplicabilitystartdt timestamp without time zone, eligiblesiblingsinfo JSON, adoptioncasenumber character varying, adoptioncaseid character varying, adoptionstartdate timestamp without time zone, istheminorparentreceivingivefc character varying, 
                tprGrantedtoBothParent character varying,dateofTpRofParent1 timestamp without time zone, dateofTpRofParent2 timestamp without time zone, ifnoReasonfornotgrantingTpRforbothparent character varying, previoustprterminationofparentdt timestamp without time zone, previousAdoptiveParentsDeathDateIfdead timestamp without time zone, minorparentivefostercarestatus character varying, minorparentivefostercarestartdate timestamp without time zone, 
				isdocumentedphysicalandmentaldisability character varying, bioclientid bigint)
 LANGUAGE plpgsql
AS $function$
--------------------------------------------------------------------------------------------------------------
--- CDM-20318 - 03-21 - changed type VARCHAR to TEXT IN adoptioninitialeligibilityinfo  Table

--------------------------------------------------------------------------------------------------------------
DECLARE 
		vs_Procedure_nm 												VARCHAR(100) DEFAULT 'sp_adoption_eligibility_worksheet_info';		
		vn_srv_req_id													UUID;
		vs_srv_req_no													VARCHAR(50);
		vd_birth_dt														TIMESTAMP;
		vs_gender														VARCHAR(20);
        vs_person_id                                                    UUID;
		vs_nm															VARCHAR(50);
		vs_race															VARCHAR(50);
		vs_us_ctzn														VARCHAR(50);
		vs_qlfd_alien													VARCHAR(50);
		vd_adp_asst_st_dt												TIMESTAMP;
		vs_efrts_to_place_chld											VARCHAR(50);
		vd_fnlztn_dt													TIMESTAMP;
		vd_adptn_pitn_dt												TIMESTAMP;
		vs_child_dprvd_prntl_sprt										VARCHAR(20);
		vs_jrsdctn														VARCHAR(50);
		vs_chd_agcy														VARCHAR(50);
		v_isSingleParent                         						integer; 
		v_parent_details  												record;
		v_aagrecord   													record;
		v_date_of_latest_payment_of_minor_parent 						timestamp without time zone;
	    v_tpr_details													JSON;
	    v_is_afdc_eligibility_met										VARCHAR(20);
	    v_wasthechildremovedfromspecifiedrelative						VARCHAR(20);
	    v_is_income_assets_met											VARCHAR(20);
		v_parent_provider_id        									INTEGER; 
		v_parent_provider_name											VARCHAR(100);
		v_effort_date                									timestamp without time zone;
		v_is_exception_granted 											VARCHAR(50);
		v_date_of_exception_granted 									timestamp without time zone;
		v_remarks 														TEXT;
		vd_childmeetsssimedicaldisabledeligliblerequirements            VARCHAR(5);
        vd_childreceivingssiatremoval                                   VARCHAR(5);
		vd_adp_ldss_dt                                          		TIMESTAMP;
		vd_adp_parent1sign_dt                                   		TIMESTAMP;
		vd_adp_parent2sign_dt                                   		TIMESTAMP;
		vd_single_parent_adoption_check 								INTEGER;
		vd_adp_issingleparent                       					INTEGER;
		vd_childapplicabilitystatus	  									VARCHAR;
		vn_child_age													INTEGER;
		v_parent2_provider_name											VARCHAR;
		vd_isReasonForExceptionRecorded									VARCHAR;
		vd_adoptionplanningid											UUID;
		vd_canchildreturntohome 										VARCHAR;
		vd_descriptionofreturnhome 										VARCHAR;
		vd_childmeetallmedicaldisabilityrequirementsforssi 				VARCHAR;
		vd_child617yearsofage 											boolean;
		vd_physicalmentalemotionaldisability 							boolean;
		vd_emotionaldisturbance 										boolean;
		vd_siblinginformationcheck 										boolean;
		vd_recognizedhighriskofphysicaldisability 						boolean;
		vd_raceethnicityofchild  										boolean;
		vd_unsuccessfulreasonableeffortsstatusrecords 					varchar;
		vd_decisionresubmissiondate 									timestamp;
		vd_removalcourtorderdate 										timestamp;
		vd_childremovaldate 											timestamp;
		vd_childspreviouslyadopted 										varchar;
		vd_voluntaryrelinquishment                  					VARCHAR;
		vd_startdateofreceivingssi 										timestamp;
		vd_isthechildresidinginafosterfamilyhome 						VARCHAR;
		vd_ivestatus 													varchar;
		vd_childsivestatusofpreviousadoption							varchar;
		vd_previousadoptiveparentstpr 									timestamp;
		vd_adoptiveparentstprdate 										timestamp;
		vd_createddate													timestamp;
		vd_siblingsinfo													JSON;
		vd_minorparentinfo												JSON;
		vd_raceorethnicitywithoneofthesabove 							text;
		vd_adoptionapplicabilitystartdt									timestamp;
		vd_eligiblesiblingsinfo 										json;
		vd_adoptioncasenumber											varchar;
		vd_adoptioncaseid												varchar;
		vd_adoptionstartdate											timestamp;	
        vd_minorparentrecievingivefc                                    varchar;
        vd_tprgrantedtobothparent                                       varchar;
        vd_dateoftprofparent1                                           timestamp;
        vd_dateoftprofparent2                                           timestamp;
        vd_reasonfornotgrantingtpr                                      varchar;
        vd_previoustprterminationofparentdt                             timestamp;
        vd_previousAdoptiveParentsDeathDate                             timestamp;
        vd_minorparentivefostercarestatus                               varchar;
        vd_minorparentivefostercarestartdate                            timestamp;
        vd_isdocumentedphysicalandmentaldisability                      varchar;
        v_adoption_initial_count                                        int;
		v_bioclientid 													bigint;
        

 BEGIN		
CREATE TEMP TABLE IF NOT EXISTS
Temp_adoption_eligibility_worksheet_info ( 
		client_id 												BIGINT,																					
		childjurisdiction										VARCHAR(50),
		childagency												VARCHAR(50),
		servicecaseid											UUID,
		casenumber												VARCHAR(50),
		removalid												BIGINT,
		dateofbirth												TIMESTAMP,
		gender													VARCHAR(20),
        personid                                                UUID,
		childname												VARCHAR(50),
		childraceethnicity										VARCHAR(50),
		uscitizen												VARCHAR(50),
		qualifiedalien											VARCHAR(50),
		adoptionassistancestartdate								TIMESTAMP,
		effortstoplacechildweremade								VARCHAR(50),
		finalizationdate								        TIMESTAMP,
		adoptionpetitiondate									TIMESTAMP,
		childdeprivedofparentalsupport							VARCHAR(20),
		isSingleParent 											integer, 
		dateoflatestpaymentofminorparent 						timestamp without time zone,
		tprdetails 												json NULL,
		isafdceligibilitymet									VARCHAR(20),
		wasthechildremovedfromspecifiedrelative					VARCHAR(10),
		isincomeassetsmet										VARCHAR(20),
		parent1providerid 										INTEGER,
		parent1providername 									VARCHAR(100),
		effortdate 												timestamp without time zone, 
		isexceptiongranted 										VARCHAR(50),
		dateofexceptiongranted 									timestamp without time zone,
		childmeetsssimedicaldisabledeligliblerequirements		VARCHAR(5),
        childreceivingssiatremoval                              VARCHAR(5),
		adoptionparent1signdate                                 TIMESTAMP,
		adoptionparent2signdate                                 TIMESTAMP,
		adoptionldssdate                                        TIMESTAMP,
		singleparentadoptioncheck								INTEGER,
		childapplicabilitystatus                				VARCHAR,
		age														INTEGER,
		nameofAdoptiveParent2									VARCHAR,
		isreasonforexceptionrecorded							VARCHAR,
		canchildreturntohome 									VARCHAR,
		descriptionofreturnhome 								VARCHAR,
		childmeetallmedicaldisabilityrequirementsforssi 		VARCHAR,
		child617yearsofage 										boolean,
		physicalmentalemotionaldisability 						boolean,
		emotionaldisturbance 									boolean,
		siblinginformationcheck 								boolean,
		recognizedhighriskofphysicaldisability 					boolean,
		raceethnicityofchild  									boolean,
		unsuccessfulreasonableeffortsstatusrecords 				varchar,
		decisionresubmissiondate 								timestamp,
		removalcourtorderdate 									timestamp,
		childremovaldate 										timestamp,
		childspreviouslyadopted 								varchar,
		voluntaryrelinquishment                  				VARCHAR,
		startdateofreceivingssi 								timestamp,
		isthechildresidinginafosterfamilyhome 					VARCHAR,
		ivestatus   											varchar,
		childsivestatusofpreviousadoption						VARCHAR,
		previousadoptiveparentstpr								timestamp,
		adoptiveparentstprdate 									timestamp,
		createddate		     									timestamp,
		siblingsinfo											JSON,
		minorparentinfo											JSON,
		raceorethnicitywithoneofthesabove						VARCHAR,
		adoptionapplicabilitystartdt							timestamp,
	    eligiblesiblingsinfo 									JSON,
	    adoptioncasenumber										varchar,
		adoptioncaseid											varchar,
		adoptionstartdate										timestamp,
        istheminorparentreceivingivefc                          varchar, 
        tprGrantedtoBothParent                                  varchar,
        dateofTpRofParent1                                      timestamp, 
        dateofTpRofParent2                                      timestamp, 
        ifnoReasonfornotgrantingTpRforbothparent                varchar, 
        previoustprterminationofparentdt                        timestamp,
        previousAdoptiveParentsDeathDateIfdead                  timestamp, 
        minorparentivefostercarestatus                          varchar, 
        minorparentivefostercarestartdate                       timestamp,
        isdocumentedphysicalandmentaldisability                 varchar,
		bioclientid												bigint
	);	



select count(*) into v_adoption_initial_count from adoptioninitialeligibilityinfo aidt where aidt.clientid = al_client_id and aidt.activeflag = 1;

SELECT p.cjamspid INTO v_bioclientid
FROM intakeservreqchildremoval isrcr
INNER JOIN person p ON p.personid = isrcr.personid AND p.activeflag= 1
WHERE isrcr.removalid = al_removal_id and isrcr.activeflag = 1;

-- Service Case ID  , Case Number , Child Agency
SELECT sc.servicecaseid, sc.servicecasenumber, 'DHS'
	INTO vn_srv_req_id, vs_srv_req_no, vs_chd_agcy
	FROM servicecase sc
	inner join intakeservicerequestactor isra on isra.servicecaseid = sc.servicecaseid
	inner join person per on per.personid = isra.personid
	inner join placement plt on plt.servicecaseid = sc.servicecaseid
	inner join intakeservreqchildremoval isrcr on isrcr.intakeservreqchildremovalid = plt.intakeservreqchildremovalid
WHERE 
	isra.intakeservicerequestpersontypekey = 'CHILD' 
	AND per.cjamspid::BIGINT =  v_bioclientid and per.activeflag = 1 order by sc.updatedon desc limit 1;
	

IF v_adoption_initial_count > 0 THEN

	SELECT aidt.clientid, aidt.countyofjurisdiction, aidt.nameofchild, aidt.dateofbirth, aidt.gender, aidt.nameofadoptiveparent1, aidt.nameofadoptiveparent2,  aidt.provideridofadoptiveparent, aidt.dateofadoptionfinalization, aidt.adoptionparent1signdate, aidt.adoptionparent2signdate,
		   aidt.adoptionldssdate, aidt.adoptionpetitiondate, aidt.childmeetallmedicaldisabilityrequirementsforssi, aidt.child617yearsofage, aidt.physicalmentalemotionaldisability, aidt.emotionaldisturbance, aidt.siblinginformationcheck, aidt.siblinggroup, aidt.recognizedhighriskofphysicaldisability, 
		   aidt.raceethnicityofchild, aidt.raceorethnicitywithoneofthesabove, aidt.effortstoplacechildweremade, aidt.dtofdocforeffortstoplacewithoutasubsidy, aidt.exceptiongrantedinchildsbestinterests, aidt.dtofdocumentationforexceptiongrantedinchildsbi, aidt.isreasonforexceptionrecorded, 
		   aidt.unsuccessfulreasonableeffortsstatusrecords, aidt.canchildreturntohome, aidt.descriptionofreturnhome, aidt.isuscitizen, aidt.isqualifiedalien, aidt.age, aidt.isthechildresidinginafosterfamilyhome, aidt.childspreviouslyadopted, aidt.childsIvEStatusofpreviousadoption, aidt.childreceivingssiatremoval, 
		   aidt.startdateofreceivingssi, aidt.dateoflatestpaymentofminorparentivefostercare, aidt.isafdceligibilitymet, aidt.wasthechildremovedfromspecifiedrelative, aidt.childdeprivedofparentalsupport, aidt.isincomeassetsmet, aidt.childremovaldate, aidt.removalcourtorderdate, aidt.voluntaryrelinquishment, 
		   aidt.adoptionapplicabilitystartdt, aidt.childapplicabilitystatus, aidt.adoptionassistancestartdate, aidt.adoptionapplicabilityminorparentinfo, aidt.childapplicableassessmentdt ,aidt.istheminorparentreceivingivefc, aidt.tprGrantedtoBothParent, aidt.dateofTpRofParent1, aidt.dateofTpRofParent2, 
		   aidt.ifnoReasonfornotgrantingTpRforbothparent, aidt.previousAdoptiveParentsTpRterminationDate, aidt.previousAdoptiveParentsDeathDateIfdead, aidt.minorparentivefostercarestatus, aidt.minorparentivefostercarestartdate, aidt.isdocumentedphysicalandmentaldisability,
		   (case when aidt.singleparentadoptioncheck = true then 1 when aidt.singleparentadoptioncheck = false then 0 else null end), aidt.createdate, aidt.ivestatus     
    
    INTO al_client_id, vs_jrsdctn, vs_nm, vd_birth_dt, vs_gender, v_parent_provider_name, v_parent2_provider_name, v_parent_provider_id, vd_fnlztn_dt, vd_adp_parent1sign_dt,	vd_adp_parent2sign_dt, vd_adp_ldss_dt, vd_adptn_pitn_dt,vd_childmeetallmedicaldisabilityrequirementsforssi, vd_child617yearsofage, 
		 vd_physicalmentalemotionaldisability, vd_emotionaldisturbance, vd_siblinginformationcheck, vd_siblingsinfo, vd_recognizedhighriskofphysicaldisability, vd_raceethnicityofchild, vd_raceorethnicitywithoneofthesabove, vs_efrts_to_place_chld, v_effort_date, v_is_exception_granted,v_date_of_exception_granted, 
		 vd_isReasonForExceptionRecorded, vd_unsuccessfulreasonableeffortsstatusrecords, vd_canchildreturntohome, vd_descriptionofreturnhome, vs_us_ctzn, vs_qlfd_alien, vn_child_age,  vd_isthechildresidinginafosterfamilyhome, vd_childspreviouslyadopted, vd_childsivestatusofpreviousadoption, vd_childreceivingssiatremoval, 
		 vd_startdateofreceivingssi, v_date_of_latest_payment_of_minor_parent, v_is_afdc_eligibility_met, v_wasthechildremovedfromspecifiedrelative, vs_child_dprvd_prntl_sprt, v_is_income_assets_met, vd_childremovaldate, vd_removalcourtorderdate, vd_voluntaryrelinquishment, vd_adoptionapplicabilitystartdt, 
		 vd_childapplicabilitystatus, vd_adp_asst_st_dt , vd_minorparentinfo,  vd_decisionresubmissiondate, vd_minorparentrecievingivefc, vd_tprgrantedtobothparent, vd_dateoftprofparent1, vd_dateoftprofparent2, vd_reasonfornotgrantingtpr, vd_previoustprterminationofparentdt, vd_previousAdoptiveParentsDeathDate, 
		 vd_minorparentivefostercarestatus, vd_minorparentivefostercarestartdate, vd_isdocumentedphysicalandmentaldisability, vd_single_parent_adoption_check, vd_createddate, vd_ivestatus
	
	FROM cjams.adoptioninitialeligibilityinfo aidt where aidt.clientid = al_client_id and aidt.activeflag = 1;  


   select ac.adoptioncasenumber, ac.adoptioncaseid::varchar, ac.startdate
   into vd_adoptioncasenumber, vd_adoptioncaseid, vd_adoptionstartdate
   from adoptioncase ac 
    join adoptioncaseactor aca on aca.adoptioncaseid = ac.adoptioncaseid and aca.actortypekey = 'CHILD'
    join person p on p.personid = aca.personid
    join adoptioncaseagreement aa on aa.adoptioncaseid = ac.adoptioncaseid
    where p.cjamspid = al_client_id;


	IF vd_siblingsinfo::jsonb = '[]'::jsonb THEN


	SELECT 
	Json_agg(e) into vd_siblingsinfo
	FROM 
	(
	  select concat(p.firstname, ' ', p.lastname) as nameofsiblingchild, tiaa2.childexpectedadoptiveproviderid as siblingproviderid, 
        tiaa2.adoptionfinalizationdate as dateofsiblingsadoptiondecree, tiaa2.updatedon as dateofsiblingsapplicablechildassessment,
        (select a2.dateofadoptionfinalization from adoptioninitialeligibilityinfo a2 
		inner join tb_ive_adoption_audit tvia on tvia.clientid = a2.clientid 
		where a2.bioclientid = p.cjamspid and tvia.adoptionassistance not in ('Incomplete') order by tvia.updatedon desc limit 1) as dtofsiblingsadoptiondecree,
		(select a2.nameofadoptiveparent1 from adoptioninitialeligibilityinfo a2 
		inner join tb_ive_adoption_audit tvia on tvia.clientid = a2.clientid 
		where a2.bioclientid = p.cjamspid and tvia.adoptionassistance not in ('Incomplete') order by tvia.updatedon desc limit 1) as adpsiblingname,
        (select tvia.adoptionassistance from adoptioninitialeligibilityinfo a2 
		inner join tb_ive_adoption_audit tvia on tvia.clientid = a2.clientid 
		where a2.bioclientid = p.cjamspid and tvia.adoptionassistance not in ('Incomplete') order by tvia.updatedon desc limit 1) as siblingadoptionstatus
		FROM 
		(select max(tiaa.adoptionauditid) as adoptionauditid , tiaa.cjamspid from tb_ive_adoption_audit tiaa
				--join tb_client_eligibility tce on tce.client_id = tiaa.cjamspid and tce.eligibility_type_cd = '2934' and trim(tce.eligibility_status_cd) in ('2913')
				join person p2 on tiaa.cjamspid = p2.cjamspid 
				join actorrelationship ar on p2.personid = ar.person1id and ar.activeflag = 1 and ar.relationshiptypekey in ('BGSISTR','BIOBR')
				join person p on ar.person2id = p.personid 
				join intakeservicerequestactor isra1 on isra1.personid = p.personid
				join permanencyplan pp1 on pp1.intakeservicerequestactorid = isra1.intakeservicerequestactorid and pp1.activeflag = 1
				where p.cjamspid  = v_bioclientid group by tiaa.cjamspid ) as TIAA 
		INNER JOIN tb_ive_adoption_audit tiaa2 on TIAA.adoptionauditid = tiaa2.adoptionauditid
		INNER JOIN person p on p.cjamspid = tiaa2.cjamspid	
	) AS e; 

	END IF;
    
	SELECT  per.personid INTO vs_person_id FROM person as per     
	WHERE per.cjamspid::BIGINT = al_client_id AND per.activeflag = 1;
        
ELSE 


-- Date of Birth , Gender , Name ,  Child Race , US Citizen , Qualified Alien      
SELECT per.dob ,(case when per.gendertypekey = 'M' then 'Male' when per.gendertypekey = 'F' then 'Female' else 'Other' end), concat(per.firstname, ' ', per.middlename, ' ', per.lastname),
	(select rt.typedescription::VARCHAR from racetype rt where TRIM(rt.racetypekey)=TRIM(per.racetypekey) and rt.activeflag =1 limit 1),
	(CASE WHEN (TRIM(per.primarycitizenshiptypekey) = 'US' or  TRIM(per.primarycitizenshiptypekey) = 'USA')
 				THEN 'YES'::VARCHAR ELSE 'NO'::VARCHAR END) ,
	(CASE WHEN (per.alienstatustypekey is not null and  per.alienregistrationtext is not null and TRIM(per.alienregistrationtext) != '' ) 
 				THEN 'YES'::VARCHAR ELSE 'NO'::VARCHAR END), per.personid 
	INTO vd_birth_dt, vs_gender, vs_nm, vs_race, vs_us_ctzn, vs_qlfd_alien ,vs_person_id
  	FROM person as per     
WHERE per.cjamspid::BIGINT = al_client_id
  	AND per.activeflag = 1;

-- Adoptiondetails, created date

SELECT (CASE WHEN (ap.isexceptiongranted = 1) THEN 'YES'::VARCHAR ELSE 'NO'::VARCHAR END), ap.dateofexceptiongranted, 
	   (case when ap.remarks is null then 'NO' else 'YES' end), ap.adoptionplanningid, r.insertedon
INTO v_is_exception_granted, v_date_of_exception_granted, vd_isReasonForExceptionRecorded, vd_adoptionplanningid, vd_createddate
  	FROM adoptionplanning ap 
	join adoptionbreakthelink adbl on adbl.adoptionplanningid::varchar = ap.adoptionplanningid::varchar
	join routing r on adbl.adoptionbreakthelinkid::varchar = r.objectid::varchar
  	join intakeservicerequestactor isra on isra.intakeservicerequestactorid = ap.intakeservicerequestactorid AND isra.servicecaseid = ap.servicecaseid 
  	join person p on p.personid = isra.personid and p.activeflag = 1 and ap.activeflag = 1
WHERE p.cjamspid::BIGINT = v_bioclientid and r.eventcode='ABLR' and r.activeflag=1 and r.routingstatustypeid::text = '16'
order by r.insertedon asc limit 1;

-- Adoption case number 
select ac.adoptioncasenumber, ac.adoptioncaseid::varchar, ac.startdate, (select c.countyname  from caseassignment ca join county c on c.countyid = ca.toldssid and c.activeflag =1
	 							where ca.objectid = ac.adoptioncaseid and ca.enddate is null order by ca.insertedon desc limit 1),
	   aa.parent1providerid, aa.parent1providername, aa.parent2providername, aa.parent1signdate,
	   aa.parent2signdate, aa.ldssdate, aa.singleparentadoptioncheck, (select aar.startdate from adoptioncaseagreementrate aar where aar.adoptionagreementid = aa.adoptionagreementid order by aar.startdate asc limit 1), aa.issingleparent 
into vd_adoptioncasenumber, vd_adoptioncaseid, vd_adoptionstartdate, vs_jrsdctn , v_parent_provider_id, v_parent_provider_name, v_parent2_provider_name, vd_adp_parent1sign_dt,
	 	 vd_adp_parent2sign_dt, vd_adp_ldss_dt, vd_single_parent_adoption_check, vd_adp_asst_st_dt, vd_adp_issingleparent
from adoptioncase ac 
join adoptioncaseactor aca on aca.adoptioncaseid = ac.adoptioncaseid and aca.actortypekey = 'CHILD'
join person p on p.personid = aca.personid
join adoptioncaseagreement aa on aa.adoptioncaseid = ac.adoptioncaseid
where p.cjamspid = al_client_id;

--finalizationd date and petition date

select isrco.courtorderdate, isrp.petitiondate, EXTRACT(year FROM age(isrco.courtorderdate,p.dob))::int
	into vd_fnlztn_dt, vd_adptn_pitn_dt, vn_child_age
from  intakeservreqcourtorder isrco 
	join intakeservicerequestcourthearing isrch on isrch.intakeservicerequestcourthearingid = isrco.intakeservicerequesthearingid
	join intakeservicerequestpetition isrp on isrp.intakeservicerequestpetitionid = isrch.intakeservicerequestpetitionid and isrp.activeflag = 1 and isrp.petitiontypekey in ('Adoption', 'GAPTPR')
	join intakeservreqcohearingoutcome isrho on isrho.intakeservreqcourtorderid = isrco.intakeservreqcourtorderid and isrho.hearingoutcometypekey = 'ADOGRA' and isrho.activeflag = 1
	join intakeservicerequestactor isra on isra.intakeservicerequestactorid = isrco.intakeservicerequestactorid
	join person p on p.personid = isra.personid 
WHERE p.cjamspid = v_bioclientid limit 1;

-- Adoption efforts
SELECT (CASE WHEN ae.activeflag = 1 THEN 'YES'::VARCHAR ELSE 'NO'::VARCHAR END) , ae.effortdate
	INTO vs_efrts_to_place_chld, v_effort_date 
  	FROM adoptionefforts ae
WHERE ae.adoptionplanningid = vd_adoptionplanningid order by ae.updatedon desc limit 1;

-- TPR Details
select json_agg(to_json(r)) INTO v_tpr_details from 
(SELECT 
   DISTINCT tpr.tprdetailsid,
	case 
		when tpr.isgranted = true then 'YES'
		when tpr.isdenied = false then 'NO'
		else null
	end isgranted,
  	tpr.tprdecisiondate,
  	tpr.reason
from tprdetails tpr  
	JOIN tprrecommendation tr ON tpr.tprrecommendationid = tr.tprrecommendationid
	JOIN intakeservicerequestactor isra ON isra.intakeservicerequestactorid = tr.intakeservicerequestactorid 
	join person p on p.personid = isra.personid and p.activeflag = 1
	JOIN adoptionplanning app ON 
		(tpr.servicecaseid = app.servicecaseid AND app.adoptionplanningid = vd_adoptionplanningid) OR 												-- HANDLING MIGRATED CASES --
		tpr.servicecaseid = (SELECT biologicalcaseid FROM   biologicaladoptionlink bio WHERE preadoptivecaseid = vd_adoptionplanningid)				-- HANDLING MIGRATED CASES --
where p.cjamspid = v_bioclientid and tpr.activeflag = 1) r;

-- AFDC Details
SELECT 
	CASE WHEN (fca.deprivation = 'CRITERIA_PASSED' AND fca.assets = 'CRITERIA_PASSED' AND fca.income = 'CRITERIA_PASSED') THEN 'YES' ELSE 'NO' END,
  	CASE WHEN (fca.assets = 'CRITERIA_PASSED' AND fca.income = 'CRITERIA_PASSED') THEN 'YES' ELSE 'NO' END,	(CASE WHEN fca.removalhome = 'CRITERIA_PASSED' THEN 'YES' ELSE 'NO' END), (CASE WHEN fca.deprivation = 'CRITERIA_PASSED' THEN 'YES' ELSE 'NO' END)
	INTO v_is_afdc_eligibility_met, v_is_income_assets_met, v_wasthechildremovedfromspecifiedrelative, vs_child_dprvd_prntl_sprt
FROM tb_ive_fostercare_audit fca WHERE fca.sqnm_sw = 'I' AND fca.cjamspid = v_bioclientid ORDER BY fca.insertedon DESC LIMIT 1;

---finalresult 

select tiaa.finalresult, tiaa.decisionresubmissiondate into vd_childapplicabilitystatus, vd_decisionresubmissiondate from tb_ive_adoption_audit tiaa where tiaa.category = 'A' and tiaa.cjamspid = v_bioclientid order by  tiaa.insertedon desc limit 1;

SELECT  adpi.childmeetallmedicaldisabilityrequirementsforssi::varchar, adpi.child617yearsofage, adpi.physicalmentalemotionaldisability, adpi.emotionaldisturbance, adpi.siblinginformationcheck, adpi.recognizedhighriskofphysicaldisability, 
		adpi.raceethnicityofchild, adpi.unsuccessfulreasonableeffortsstatusrecords::varchar, adpi.descriptionofreturnhome::varchar, adpi.canchildreturntohome::varchar, adpi.removalcourtorderdate, adpi.childremovaldate,
		adpi.childspreviouslyadopted::varchar, adpi.voluntaryrelinquishment::varchar, adpi.childreceivingssiatremoval::varchar, adpi.startdateofreceivingssi, adpi.isthechildresidinginafosterfamilyhome::varchar, adpi.ivestatus::varchar,
		adpi.childsivestatusofpreviousadoption::varchar, adpi.previousadoptiveparentstpr, adpi.adoptiveparentstprdate, adpi.raceorethnicitywithoneofthesabove, adpi.adoptionapplicabilitystartdt, adpi.eligiblesiblingsinfo
into 	vd_childmeetallmedicaldisabilityrequirementsforssi, vd_child617yearsofage, vd_physicalmentalemotionaldisability, vd_emotionaldisturbance, vd_siblinginformationcheck, vd_recognizedhighriskofphysicaldisability,
		vd_raceethnicityofchild, vd_unsuccessfulreasonableeffortsstatusrecords, vd_descriptionofreturnhome, vd_canchildreturntohome, vd_removalcourtorderdate , vd_childremovaldate,
		vd_childspreviouslyadopted, vd_voluntaryrelinquishment, vd_childreceivingssiatremoval, vd_startdateofreceivingssi, vd_isthechildresidinginafosterfamilyhome, vd_ivestatus, vd_childsivestatusofpreviousadoption,
		vd_previousadoptiveparentstpr, vd_adoptiveparentstprdate, vd_raceorethnicitywithoneofthesabove, vd_adoptionapplicabilitystartdt, vd_eligiblesiblingsinfo

from adoptionapplicabilityinfo adpi where adpi.clientid = v_bioclientid and adpi.removalid = al_removal_id;       

SELECT 
Json_agg(e) into vd_siblingsinfo
FROM 
(
	select asi.* from adoptionapplicabilitysiblinginfo asi 
	join adoptionapplicabilityinfo aai on asi.adoptionapplicabilityid = aai.adoptionapplicabilityid where aai.clientid = v_bioclientid and aai.removalid = al_removal_id		
) AS e; 

IF vd_siblingsinfo is null THEN

	SELECT 
	Json_agg(e) into vd_siblingsinfo
	FROM 
	(
	select concat(p.firstname, ' ', p.lastname) as siblingname, tiaa2.childexpectedadoptiveproviderid as siblingproviderid, 
	(select tvia.adoptionassistance from adoptioninitialeligibilityinfo a2 
		inner join tb_ive_adoption_audit tvia on tvia.clientid = a2.clientid 
		where a2.bioclientid = p.cjamspid and tvia.adoptionassistance not in ('Incomplete') order by tvia.updatedon desc limit 1) as siblingadoptionstatus,
		tiaa2.adoptionfinalizationdate as dateofsiblingsadoptiondecree, tiaa2.updatedon as dateofsiblingsapplicablechildassessment
		FROM 
		(select max(tiaa.adoptionauditid) as adoptionauditid , tiaa.cjamspid from tb_ive_adoption_audit tiaa
				--join tb_client_eligibility tce on tce.client_id = tiaa.cjamspid and tce.eligibility_type_cd = '2934' and trim(tce.eligibility_status_cd) in ('2913')
				join person p2 on tiaa.cjamspid = p2.cjamspid 
				join actorrelationship ar on p2.personid = ar.person1id and ar.activeflag = 1 and ar.relationshiptypekey in ('BGSISTR','BIOBR')
				join person p on ar.person2id = p.personid 
				join intakeservicerequestactor isra1 on isra1.personid = p.personid
				where p.cjamspid  = v_bioclientid group by tiaa.cjamspid ) as TIAA 
		INNER JOIN tb_ive_adoption_audit tiaa2 on TIAA.adoptionauditid = tiaa2.adoptionauditid
		INNER JOIN person p on p.cjamspid = tiaa2.cjamspid
	) AS e; 

END IF;

SELECT 
Json_agg(e) into vd_minorparentinfo
FROM 
(
	select asi.* from adoptionapplicabilityminorparentinfo asi 
	join adoptionapplicabilityinfo aai on asi.adoptionapplicabilityid = aai.adoptionapplicabilityid where aai.clientid = v_bioclientid and aai.removalid = al_removal_id		
) AS e; 

END IF;
    
INSERT INTO Temp_adoption_eligibility_worksheet_info
SELECT 
		al_client_id,
		vs_jrsdctn,
		vs_chd_agcy,
		vn_srv_req_id,
		vs_srv_req_no,
		al_removal_id,
		vd_birth_dt,
		vs_gender,
        vs_person_id,
		vs_nm,
		vs_race,
		vs_us_ctzn,
		vs_qlfd_alien,
		vd_adp_asst_st_dt,
		vs_efrts_to_place_chld,
		vd_fnlztn_dt,
		vd_adptn_pitn_dt,
		vs_child_dprvd_prntl_sprt,
		vd_adp_issingleparent,
		v_date_of_latest_payment_of_minor_parent,
		v_tpr_details,
		v_is_afdc_eligibility_met,
		v_wasthechildremovedfromspecifiedrelative,
		v_is_income_assets_met,
		v_parent_provider_id,		
		v_parent_provider_name,		
		v_effort_date,
		v_is_exception_granted, 
		v_date_of_exception_granted,
		(select case when vd_childmeetsssimedicaldisabledeligliblerequirements is null then 'NO' else vd_childmeetsssimedicaldisabledeligliblerequirements end),
        vd_childreceivingssiatremoval,
		vd_adp_parent1sign_dt,
		vd_adp_parent2sign_dt,
		vd_adp_ldss_dt,
		vd_single_parent_adoption_check,
		vd_childapplicabilitystatus,
		vn_child_age,
		v_parent2_provider_name,
		vd_isReasonForExceptionRecorded,
		vd_canchildreturntohome,
		vd_descriptionofreturnhome,
		vd_childmeetallmedicaldisabilityrequirementsforssi,
		vd_child617yearsofage,
		vd_physicalmentalemotionaldisability,
		vd_emotionaldisturbance,
		vd_siblinginformationcheck,
		vd_recognizedhighriskofphysicaldisability,
		vd_raceethnicityofchild,
		vd_unsuccessfulreasonableeffortsstatusrecords,
		vd_decisionresubmissiondate,
		vd_removalcourtorderdate,
		vd_childremovaldate,
		vd_childspreviouslyadopted,
		vd_voluntaryrelinquishment,
		vd_startdateofreceivingssi,
		vd_isthechildresidinginafosterfamilyhome,
		vd_ivestatus,
		vd_childsivestatusofpreviousadoption,
		vd_previousadoptiveparentstpr,
		vd_adoptiveparentstprdate,
		vd_createddate,
		vd_siblingsinfo,
		vd_minorparentinfo,
		vd_raceorethnicitywithoneofthesabove,
		vd_adoptionapplicabilitystartdt,
		vd_eligiblesiblingsinfo,
		vd_adoptioncasenumber,
		vd_adoptioncaseid,
		vd_adoptionstartdate,
        vd_minorparentrecievingivefc,
        vd_tprgrantedtobothparent,
        vd_dateoftprofparent1,
        vd_dateoftprofparent2,
        vd_reasonfornotgrantingtpr,
        vd_previoustprterminationofparentdt,
        vd_previousAdoptiveParentsDeathDate,
        vd_minorparentivefostercarestatus,
        vd_minorparentivefostercarestartdate,
        vd_isdocumentedphysicalandmentaldisability,
		v_bioclientid;

   	
RETURN QUERY SELECT * FROM Temp_adoption_eligibility_worksheet_info;
              
DROP TABLE Temp_adoption_eligibility_worksheet_info;

   END
   $function$;