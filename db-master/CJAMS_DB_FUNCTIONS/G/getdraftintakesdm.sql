DROP FUNCTION IF EXISTS cjams.getdraftintakesdm(uuid);
DROP FUNCTION IF EXISTS cjams.getdraftintakesdm(uuid,character varying,integer);
DROP FUNCTION IF EXISTS cjams.getdraftintakesdm(uuid,integer);
CREATE OR REPLACE FUNCTION cjams.getdraftintakesdm(v_intakeserviceid uuid, v_isexpunged integer DEFAULT 0::integer)
RETURNS TABLE(s1 json) 
    LANGUAGE 'plpgsql'
AS $function$
-------------------------------------------------------------------------------------------------------------
-- 01/29/2026 — Umasankar Raavi — Added `ismalpa_laborTrafficking`, islabortrafficking, column per the “Add Labor Trafficking to SDM as Physical Abuse Sub-Category” user story.
-------------------------------------------------------------------------------------------------------------

BEGIN
IF v_isexpunged = 1 THEN 
	-- Encrypted Expunged Query
	RETURN QUERY 
	SELECT row_to_json(e) from (
	SELECT *, 
		(SELECT CASE count(1) WHEN 0 THEN 'No Immediate' ELSE 'Immediate' END 
		FROM jsonb_each("noImmediateList"::jsonb) WHERE 'value'='true') as "immediate"
		FROM (
			SELECT 
			isreportedhistory as "isreportedhistory",
			isscrnoutrecovr_historicalinformation as "isscrnoutrecovr_historicalinformation",
			isneggn_exposuretounsafe as "isneggn_exposuretounsafe",
			isnegab_abandoned as "isnegab_abandoned",
			'' as "childunderoneyear",
			isnegrh_priordeath as "isnegrh_priordeath",
			referralid as "referralid",
			isfinalscreenin as "isfinalscreenin",
			isactiveinvestigation as "isactiveinvestigation",
			isscrninrecovr_courtorder as "isscrninrecovr_courtorder",
			isdeathorserious as "isdeathorserious",
			isir as "isir",
			isimmed_seriousinjury as "isimmed_seriousinjury",
			ismaltreatment as "maltreatment",
			ismaltreatment3yrs as "ismaltreatment3yrs",
			officerfirstname as "officerfirstname",
			issexualabuse as "issexualabuse",
			islabortrafficking as "islabortrafficking",
			ismalsa_physicalindicators as "ismalsa_physicalindicators",
			ismalpa_nonaccident as "ismalpa_nonaccident",
			supervisordate as "supervisordate",
			issignordiagonises as "issignordiagonises",
			ismalsa_sexualmolestation as "ismalsa_sexualmolestation",
			isneguc_leftalonewithoutsupport as "isneguc_leftalonewithoutsupport",
			scrnin_description as "scrnin_description",
			'' as "screeningRecommend",
			isrisk as "isrisk",
			isimmed_otherspecify as "isimmed_otherspecify",
			isscrnoutrecovr_insufficient as "isscrnoutrecovr_insufficient",
			immediateother as "immediateList6",
			ismalpa_caregiver as "ismalpa_caregiver",
			ismalpa_insjury as "ismalpa_insjury",
			isimmed_childfaatility as "isimmed_childfaatility",
			isthread as "isthread",
			isneggn_suspiciousdeath as "isneggn_suspiciousdeath",
			isdomesticvoilence as "isdomesticvoilence",
			badgenumber as "badgenumber",
			reportdate as "reportdate",
			referraldob as "referraldob",
			isscrninrecovr_otherspecify as "isscrninrecovr_otherspecify",
			isoutofhome as "isoutofhome",
			isneggn_inadequateclothing as "isneggn_inadequateclothing",
			countyid as "county",
			isnoimmed_mentalinjury as "isnoimmed_mentalinjury",
			ismalpa_suspeciousdeath as "ismalpa_suspeciousdeath" ,
			case when isar = true then 'CPS-AR' when isir = true then 'CPS-IR' else '' end "cpsResponseType",
			isnoimmed_neglectresponse as "isnoimmed_neglectresponse",
			ismalsa_sexualact as "ismalsa_sexualact",
			isimmed_allegation as "isimmed_allegation",
			ismenng_psycologicalability as "ismenng_psycologicalability",
			isneggn_inadequatesupervision as "isneggn_inadequatesupervision",
			isnegrh_treatmenthealthrisk as "isnegrh_treatmenthealthrisk",		 
			ismalpa_injuryinconsistent as "ismalpa_injuryinconsistent",
			isnegfp_cargiverintervene as "isnegfp_cargiverintervene",
			supervisor as "supervisor",
			'' as "scnRecommendOveride",
			isneguc_leftunsupervised as "isneguc_leftunsupervised",
			isscrnoutrecovr_otherspecify as "isscrnoutrecovr_otherspecify",
			isreportmeets as "isreportmeets",
			iscourtiinvestigation as "iscourtiinvestigation",
			isneggn_childdischarged as "isneggn_childdischarged",
			ismultiple as "ismultiple",
			ismaltreatment12yrs as "ismaltreatment12yrs",
			isimmed_childleftalone as "isimmed_childleftalone",
			referralname as "referralname",
			worker as "worker",
			isnegrh_basicneedsunmet as "isnegrh_basicneedsunmet",
			ismaltreatment as "ismaltreatment",
			isneggn_signsordiagnosis as "isneggn_signsordiagnosis",
			isscrnoutrecovr_information as "isscrnoutrecovr_information",
			workerdate as "workerdate",
			scrnout_description as "scrnout_description",
			isnoimmed_physicalabuse as "isnoimmed_physicalabuse",
			recordnumber as "recordnumber",
			ismalpa_childtoxic as "ismalpa_childtoxic",
			isnegmn_unreasonabledelay as "isnegmn_unreasonabledelay",
			ismenab_psycologicalability as "ismenab_psycologicalability",
			iscriminalhistory as "iscriminalhistory",
			islawenforcement as "islawenforcement",
			isneggn_inadequatefood as "isneggn_inadequatefood",
			isneguc_leftaloneinappropriatecare as "neguc_leftaloneinappropriatecare",
			isar as "isar",
			ismalsa_sexualmolestation as "ismalsa_sexualmolestation",
			officermiddlename as "officermiddlename",
			isnoimmed_sexualabuse as "isnoimmed_sexualabuse",
			officerlastname as "officerlastname",
			isnegrh_sexualperpetrator as "negrh_sexualperpetrator",
			isnegrh_risk_dv as "isnegrh_risk_dv", 
			isnegrh_fatality_can as "isnegrh_fatality_can", 
			isnegrh_indicated_unsub as "isnegrh_indicated_unsub", 
			isnegrh_survivor as "isnegrh_survivor", 
			isnegrh_birth_match as "isnegrh_birth_match", 
			isnegrh_sex_trafficking as "isnegrh_sex_trafficking",
			ismaltreatment24yrs as "ismaltreatment24yrs", 
			json_build_object(
			'ismalpa_childtoxic', ismalpa_childtoxic, 
			'ismalpa_nonaccident', ismalpa_nonaccident, 
			'ismalpa_suspeciousdeath', ismalpa_suspeciousdeath,
			'ismalpa_caregiver', ismalpa_caregiver, 
			'ismalpa_injuryinconsistent', ismalpa_injuryinconsistent, 
			'ismalpa_insjury', ismalpa_insjury) "physicalAbuse",
			json_build_object(
			'isimmed_seriousinjury', isimmed_seriousinjury,
			'isimmed_allegation', isimmed_allegation, 
			'isimmed_childleftalone', isimmed_childleftalone,
			'isimmed_childfaatility', isimmed_childfaatility,   
			'isimmed_otherspecify', isimmed_otherspecify) "immediateList",
			coalesce( (SELECT json_agg(item)
				FROM (
				SELECT m.maltreatorsname as victimname
				FROM expunge.intakeservrequestsdmmaltreatment_expunge m 
				WHERE m.intakeservicerequestsdmid = sdm.intakeservicerequestsdmid
				and m.maltreatmenttype = 'AV'
			) item),'[]' ::json) "allegedvictim", 
			coalesce( (SELECT json_agg(item)
				FROM (
				SELECT m.maltreatorsname as providername
				FROM expunge.intakeservrequestsdmmaltreatment_expunge m 
				WHERE m.intakeservicerequestsdmid = sdm.intakeservicerequestsdmid
				and m.maltreatmenttype = 'PR'
			) item) ,'[]' ::json )"provider", 
			json_build_object(
				'isneguc_leftaloneinappropriatecare', isneguc_leftaloneinappropriatecare,
				'isneguc_leftunsupervised', isneguc_leftunsupervised,
				'isneguc_leftalonewithoutsupport',isneguc_leftalonewithoutsupport) "unattendedChild",
			json_build_object(
				'isscrninrecovr_courtorder', isscrninrecovr_courtorder,
				'isscrninrecovr_otherspecify', isscrninrecovr_otherspecify,
				'scrnin_description', scrnin_description) "screenIn",  
			json_build_object(
				'iscriminalhistory', iscriminalhistory,
				'isthread', isthread,
				'ismultiple', ismultiple,
				'iscourtiinvestigation', iscourtiinvestigation,
				'islawenforcement', islawenforcement,
				'isdomesticvoilence', isdomesticvoilence,
				'isreportedhistory', isreportedhistory) "disqualifyingFactors",
			coalesce( (SELECT json_agg(item)
				FROM (
				SELECT m.maltreatorsname as maltreatorsname
				FROM expunge.intakeservrequestsdmmaltreatment_expunge m 
				WHERE m.intakeservicerequestsdmid = sdm.intakeservicerequestsdmid
				and m.maltreatmenttype = 'AM'
			) item) ,'[]' ::json ) "allegedmaltreator" ,  		
			json_build_object(
						'isnegrh_sexualperpetrator', isnegrh_sexualperpetrator,
						'isnegrh_priordeath', isnegrh_priordeath,
						'isnegrh_basicneedsunmet', isnegrh_basicneedsunmet,
						'isnegrh_risk_dv', isnegrh_risk_dv, 
						'isnegrh_fatality_can', isnegrh_fatality_can, 
						'isnegrh_indicated_unsub', isnegrh_indicated_unsub, 
						'isnegrh_survivor', isnegrh_survivor, 
						'isnegrh_birth_match', isnegrh_birth_match, 
						'isnegrh_sex_trafficking', isnegrh_sex_trafficking) "riskofHarm",
			json_build_object(
				'ismalsa_physicalindicators', ismalsa_physicalindicators,
				'ismalsa_sexualexploitation', ismalsa_sexualexploitation,
				'ismalsa_sexualmolestation', ismalsa_sexualmolestation,
				'ismalsa_sexualact', ismalsa_sexualact) "sexualAbuse",
			json_build_object(
				'isneggn_signsordiagnosis', isneggn_signsordiagnosis,
				'isneggn_inadequatefood', isneggn_inadequatefood,
				'isneggn_inadequateclothing', isneggn_inadequateclothing,
				'isneggn_exposuretounsafe', isneggn_exposuretounsafe,
				'isneggn_inadequatesupervision', isneggn_inadequatesupervision,
				'isnegrh_treatmenthealthrisk', isnegrh_treatmenthealthrisk,	
				'isneggn_suspiciousdeath', isneggn_suspiciousdeath,
				'isneggn_childdischarged', isneggn_childdischarged) "generalNeglect", 
			json_build_object(
				'isnoimmed_mentalinjury', isnoimmed_mentalinjury,
				'isnoimmed_neglectresponse', isnoimmed_neglectresponse,
				'isnoimmed_physicalabuse', isnoimmed_physicalabuse,
				'isnoimmed_sexualabuse', isnoimmed_sexualabuse) "noImmediateList",
			json_build_object(
				'issexualabuse', issexualabuse,
				'islabortrafficking', islabortrafficking,
				'ismaltreatment12yrs', ismaltreatment12yrs,
				'issignordiagonises', issignordiagonises,
				'isoutofhome', isoutofhome,
				'ismaltreatment3yrs', ismaltreatment3yrs,
				'isactiveinvestigation', isactiveinvestigation,
				'isrisk', isrisk,
				'isreportmeets', isreportmeets,
				'isdeathorserious', isdeathorserious,
				'ismaltreatment24yrs', ismaltreatment24yrs) "disqualifyingCriteria",
			json_build_object(
				'isscrnoutrecovr_otherspecify', isscrnoutrecovr_otherspecify,
				'scrnout_description', scrnout_description,
				'isscrnoutrecovr_information', isscrnoutrecovr_information,
				'isscrnoutrecovr_insufficient', isscrnoutrecovr_insufficient,
				'isscrnoutrecovr_historicalinformation', isscrnoutrecovr_historicalinformation) "screenOut"
			FROM expunge.intakeservicerequestsdm_expunge sdm
			WHERE sdm.intakeserviceid =v_intakeserviceid
			) t
	) as e;
ELSE 
-- Original Query
	RETURN QUERY 
	SELECT row_to_json(e) from (
	SELECT *, 
		(SELECT CASE count(1) WHEN 0 THEN 'No Immediate' ELSE 'Immediate' END 
		FROM jsonb_each("noImmediateList"::jsonb) WHERE 'value'='true') as "immediate"
		FROM (
			SELECT 
			isreportedhistory as "isreportedhistory",
			isscrnoutrecovr_historicalinformation as "isscrnoutrecovr_historicalinformation",
			isneggn_exposuretounsafe as "isneggn_exposuretounsafe",
			isnegab_abandoned as "isnegab_abandoned",
			'' as "childunderoneyear",
			isnegrh_priordeath as "isnegrh_priordeath",
			referralid as "referralid",
			isfinalscreenin as "isfinalscreenin",
			isactiveinvestigation as "isactiveinvestigation",
			isscrninrecovr_courtorder as "isscrninrecovr_courtorder",
			isdeathorserious as "isdeathorserious",
			isir as "isir",
			isimmed_seriousinjury as "isimmed_seriousinjury",
			ismaltreatment as "maltreatment",
			ismaltreatment3yrs as "ismaltreatment3yrs",
			officerfirstname as "officerfirstname",
			issexualabuse as "issexualabuse",
			islabortrafficking as "islabortrafficking",
			ismalsa_physicalindicators as "ismalsa_physicalindicators",
			ismalpa_nonaccident as "ismalpa_nonaccident",
			supervisordate as "supervisordate",
			issignordiagonises as "issignordiagonises",
			ismalsa_sexualmolestation as "ismalsa_sexualmolestation",
			isneguc_leftalonewithoutsupport as "isneguc_leftalonewithoutsupport",
			scrnin_description as "scrnin_description",
			'' as "screeningRecommend",
			isrisk as "isrisk",
			isimmed_otherspecify as "isimmed_otherspecify",
			isscrnoutrecovr_insufficient as "isscrnoutrecovr_insufficient",
			immediateother as "immediateList6",
			ismalpa_caregiver as "ismalpa_caregiver",
			ismalpa_insjury as "ismalpa_insjury",
			isimmed_childfaatility as "isimmed_childfaatility",
			isthread as "isthread",
			isneggn_suspiciousdeath as "isneggn_suspiciousdeath",
			isdomesticvoilence as "isdomesticvoilence",
			badgenumber as "badgenumber",
			reportdate as "reportdate",
			referraldob as "referraldob",
			isscrninrecovr_otherspecify as "isscrninrecovr_otherspecify",
			isoutofhome as "isoutofhome",
			isneggn_inadequateclothing as "isneggn_inadequateclothing",
			countyid as "county",
			isnoimmed_mentalinjury as "isnoimmed_mentalinjury",
			ismalpa_suspeciousdeath as "ismalpa_suspeciousdeath" ,
			case when isar = true then 'CPS-AR' when isir = true then 'CPS-IR' else '' end "cpsResponseType",
			isnoimmed_neglectresponse as "isnoimmed_neglectresponse",
			ismalsa_sexualact as "ismalsa_sexualact",
			isimmed_allegation as "isimmed_allegation",
			ismenng_psycologicalability as "ismenng_psycologicalability",
			isneggn_inadequatesupervision as "isneggn_inadequatesupervision",
			isnegrh_treatmenthealthrisk as "isnegrh_treatmenthealthrisk",		 
			ismalpa_injuryinconsistent as "ismalpa_injuryinconsistent",
			isnegfp_cargiverintervene as "isnegfp_cargiverintervene",
			supervisor as "supervisor",
			'' as "scnRecommendOveride",
			isneguc_leftunsupervised as "isneguc_leftunsupervised",
			isscrnoutrecovr_otherspecify as "isscrnoutrecovr_otherspecify",
			isreportmeets as "isreportmeets",
			iscourtiinvestigation as "iscourtiinvestigation",
			isneggn_childdischarged as "isneggn_childdischarged",
			ismultiple as "ismultiple",
			ismaltreatment12yrs as "ismaltreatment12yrs",
			isimmed_childleftalone as "isimmed_childleftalone",
			referralname as "referralname",
			worker as "worker",
			isnegrh_basicneedsunmet as "isnegrh_basicneedsunmet",
			ismaltreatment as "ismaltreatment",
			isneggn_signsordiagnosis as "isneggn_signsordiagnosis",
			isscrnoutrecovr_information as "isscrnoutrecovr_information",
			workerdate as "workerdate",
			scrnout_description as "scrnout_description",
			isnoimmed_physicalabuse as "isnoimmed_physicalabuse",
			recordnumber as "recordnumber",
			ismalpa_childtoxic as "ismalpa_childtoxic",
			isnegmn_unreasonabledelay as "isnegmn_unreasonabledelay",
			ismenab_psycologicalability as "ismenab_psycologicalability",
			iscriminalhistory as "iscriminalhistory",
			islawenforcement as "islawenforcement",
			isneggn_inadequatefood as "isneggn_inadequatefood",
			isneguc_leftaloneinappropriatecare as "neguc_leftaloneinappropriatecare",
			isar as "isar",
			ismalsa_sexualmolestation as "ismalsa_sexualmolestation",
			officermiddlename as "officermiddlename",
			isnoimmed_sexualabuse as "isnoimmed_sexualabuse",
			officerlastname as "officerlastname",
			isnegrh_sexualperpetrator as "negrh_sexualperpetrator",
			isnegrh_risk_dv as "isnegrh_risk_dv", 
			isnegrh_fatality_can as "isnegrh_fatality_can", 
			isnegrh_indicated_unsub as "isnegrh_indicated_unsub", 
			isnegrh_survivor as "isnegrh_survivor", 
			isnegrh_birth_match as "isnegrh_birth_match", 
			isnegrh_sex_trafficking as "isnegrh_sex_trafficking",
			ismaltreatment24yrs as "ismaltreatment24yrs", 
			json_build_object(
			'ismalpa_childtoxic', ismalpa_childtoxic, 
			'ismalpa_nonaccident', ismalpa_nonaccident, 
			'ismalpa_suspeciousdeath', ismalpa_suspeciousdeath,
			'ismalpa_caregiver', ismalpa_caregiver, 
			'ismalpa_injuryinconsistent', ismalpa_injuryinconsistent, 
			'ismalpa_insjury', ismalpa_insjury) "physicalAbuse",
			json_build_object(
			'isimmed_seriousinjury', isimmed_seriousinjury,
			'isimmed_allegation', isimmed_allegation, 
			'isimmed_childleftalone', isimmed_childleftalone,
			'isimmed_childfaatility', isimmed_childfaatility,   
			'isimmed_otherspecify', isimmed_otherspecify) "immediateList",
			coalesce( (SELECT json_agg(item)
				FROM (
				SELECT m.maltreatorsname as victimname
				FROM cjams.intakeservrequestsdmmaltreatment m 
				WHERE m.intakeservicerequestsdmid = sdm.intakeservicerequestsdmid
				and m.maltreatmenttype = 'AV'
			) item),'[]' ::json) "allegedvictim", 
			coalesce( (SELECT json_agg(item)
				FROM (
				SELECT m.maltreatorsname as providername
				FROM cjams.intakeservrequestsdmmaltreatment m 
				WHERE m.intakeservicerequestsdmid = sdm.intakeservicerequestsdmid
				and m.maltreatmenttype = 'PR'
			) item) ,'[]' ::json )"provider", 
			json_build_object(
				'isneguc_leftaloneinappropriatecare', isneguc_leftaloneinappropriatecare,
				'isneguc_leftunsupervised', isneguc_leftunsupervised,
				'isneguc_leftalonewithoutsupport',isneguc_leftalonewithoutsupport) "unattendedChild",
			json_build_object(
				'isscrninrecovr_courtorder', isscrninrecovr_courtorder,
				'isscrninrecovr_otherspecify', isscrninrecovr_otherspecify,
				'scrnin_description', scrnin_description) "screenIn",  
			json_build_object(
				'iscriminalhistory', iscriminalhistory,
				'isthread', isthread,
				'ismultiple', ismultiple,
				'iscourtiinvestigation', iscourtiinvestigation,
				'islawenforcement', islawenforcement,
				'isdomesticvoilence', isdomesticvoilence,
				'isreportedhistory', isreportedhistory) "disqualifyingFactors",
			coalesce(  (SELECT json_agg(item)
				FROM (
				SELECT m.maltreatorsname
				FROM cjams.intakeservrequestsdmmaltreatment m 
				WHERE m.intakeservicerequestsdmid = sdm.intakeservicerequestsdmid
				and m.maltreatmenttype = 'AM'
			) item) ,'[]' ::json ) "allegedmaltreator" ,  		
			json_build_object(
						'isnegrh_sexualperpetrator', isnegrh_sexualperpetrator,
						'isnegrh_priordeath', isnegrh_priordeath,
						'isnegrh_basicneedsunmet', isnegrh_basicneedsunmet,
						'isnegrh_risk_dv', isnegrh_risk_dv, 
						'isnegrh_fatality_can', isnegrh_fatality_can, 
						'isnegrh_indicated_unsub', isnegrh_indicated_unsub, 
						'isnegrh_survivor', isnegrh_survivor, 
						'isnegrh_birth_match', isnegrh_birth_match, 
						'isnegrh_sex_trafficking', isnegrh_sex_trafficking) "riskofHarm",
			json_build_object(
				'ismalsa_physicalindicators', ismalsa_physicalindicators,
				'ismalsa_sexualexploitation', ismalsa_sexualexploitation,
				'ismalsa_sexualmolestation', ismalsa_sexualmolestation,
				'ismalsa_sexualact', ismalsa_sexualact) "sexualAbuse",
			json_build_object(
				'isneggn_signsordiagnosis', isneggn_signsordiagnosis,
				'isneggn_inadequatefood', isneggn_inadequatefood,
				'isneggn_inadequateclothing', isneggn_inadequateclothing,
				'isneggn_exposuretounsafe', isneggn_exposuretounsafe,
				'isneggn_inadequatesupervision', isneggn_inadequatesupervision,
				'isnegrh_treatmenthealthrisk', isnegrh_treatmenthealthrisk,	
				'isneggn_suspiciousdeath', isneggn_suspiciousdeath,
				'isneggn_childdischarged', isneggn_childdischarged) "generalNeglect", 
			json_build_object(
				'isnoimmed_mentalinjury', isnoimmed_mentalinjury,
				'isnoimmed_neglectresponse', isnoimmed_neglectresponse,
				'isnoimmed_physicalabuse', isnoimmed_physicalabuse,
				'isnoimmed_sexualabuse', isnoimmed_sexualabuse) "noImmediateList",
			json_build_object(
				'issexualabuse', issexualabuse,
				' islabortrafficking', islabortrafficking,
				'ismaltreatment12yrs', ismaltreatment12yrs,
				'issignordiagonises', issignordiagonises,
				'isoutofhome', isoutofhome,
				'ismaltreatment3yrs', ismaltreatment3yrs,
				'isactiveinvestigation', isactiveinvestigation,
				'isrisk', isrisk,
				'isreportmeets', isreportmeets,
				'isdeathorserious', isdeathorserious,
				'ismaltreatment24yrs', ismaltreatment24yrs) "disqualifyingCriteria",
			json_build_object(
				'isscrnoutrecovr_otherspecify', isscrnoutrecovr_otherspecify,
				'scrnout_description', scrnout_description,
				'isscrnoutrecovr_information', isscrnoutrecovr_information,
				'isscrnoutrecovr_insufficient', isscrnoutrecovr_insufficient,
				'isscrnoutrecovr_historicalinformation', isscrnoutrecovr_historicalinformation) "screenOut"
			FROM cjams.intakeservicerequestsdm sdm
			WHERE sdm.intakeserviceid =v_intakeserviceid
			) t
	) as e;
END IF;
                         
END;

$function$;




