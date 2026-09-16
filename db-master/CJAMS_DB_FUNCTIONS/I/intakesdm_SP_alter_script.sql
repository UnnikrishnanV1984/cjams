drop FUNCTION if exists cjams.intakesdm(sdmobj json, dispositioncode character varying, lintakeserviceid uuid, securityusersid character varying, l_intakenumber character varying );
CREATE OR REPLACE FUNCTION cjams.intakesdm(sdmobj json, dispositioncode character varying, lintakeserviceid uuid, securityusersid character varying, l_intakenumber character varying DEFAULT ''::character varying)
 RETURNS text
 LANGUAGE plpgsql
AS $function$
 
 DECLARE
 
 l_sdmid uuid;
 v_sdmap json;
 v_sdmam json;
 v_sdmpr json;
 v_sdmav json;
 v_intakeserviceid uuid;
 v_securityusersid character varying;
 v_date timestamp without time zone;
 result character varying;
 v_status integer;
 l_actiontype character varying;
 l_ar bool;
 l_ir bool;
 l_maltreat bool;
 l_iscps bool;
 v_sdmobj json;
 
 BEGIN
 
  v_sdmobj := sdmobj; 
  sdmobj:='['|| sdmobj ||']'; 
  v_intakeserviceid := lintakeserviceid; 
  V_DATE:= now() ; 
  v_sdmav := v_sdmobj->>'allegedvictim'; 
  /*  from  request*/ 
  v_sdmam := v_sdmobj->>'allegedmaltreator'; 
  /*  from  request*/ 
  v_sdmpr := v_sdmobj->>'provider'; 
  /*  from  request*/ 
  v_securityusersid := securityusersid; 
  /*  from  request*/ 
  
 IF length(l_intakenumber) > 0 THEN 
	UPDATE intakeservicerequestsdm 
	SET    activeflag = 0 
	WHERE  intakenumber = l_intakenumber; 
 END IF;
 
 IF v_intakeserviceid IS NOT NULL THEN 
	v_status := 15;
 END IF;
 
		INSERT INTO intakeservicerequestsdm ( 
				intakeserviceid, 
				intakenumber, 
				status, 
				comments, 
				ismaltreatment, 
				referralname, 
				referraldob, 
				referralid, 
				countyid, 
				ismalpa_suspeciousdeath, 
				ismalpa_nonaccident, 
				ismalpa_injuryinconsistent, 
				ismalpa_insjury, 
				ismalpa_childtoxic, 
				ismalpa_caregiver, 
				ismalsa_sexualmolestation, 
				ismalsa_sexualact, 
				ismalsa_sexualexploitation, 
				ismalsa_physicalindicators, 
				isneggn_suspiciousdeath, 
				isneggn_signsordiagnosis, 
				isneggn_inadequatefood, 
				isneggn_exposuretounsafe, 
				isneggn_inadequateclothing, 
				isneggn_inadequatesupervision, 
				isnegrh_treatmenthealthrisk,
				isneggn_childdischarged, 
				isnegfp_cargiverintervene, 
				isnegab_abandoned, 
				isneguc_leftunsupervised, 
				isneguc_leftaloneinappropriatecare, 
				isneguc_leftalonewithoutsupport, 
				isnegrh_priordeath, 
				isnegrh_sexualperpetrator, 
				isnegrh_basicneedsunmet, 
				isnegrh_sex_offender , 
			    isnegrh_risk_dv , 
			    isnegrh_fatality_can , 
			    isnegrh_indicated_unsub , 
			    isnegrh_survivor , 
			    isnegrh_birth_match , 
			    isnegrh_sex_trafficking ,
				isnegmn_unreasonabledelay, 
				ismenab_psycologicalability, 
				ismenng_psycologicalability, 
				isrecsc_screenout, 
				isrecsc_scrrenin, 
				isrecovr_no, 
				isrecovr_scrrenin, 
				isreccps_screenout, 
				isrec_imlist, 
				isrec_noimmediate, 
				isrec_reportallegtion, 
				officerfirstname, 
				officermiddlename, 
				officerlastname, 
				badgenumber, 
				recordnumber, 
				reportdate, 
				worker, 
				workerdate, 
				supervisor, 
				supervisordate, 
				activeflag, 
				updatedby, 
				insertedby, 
				issexualabuse , 
				isoutofhome , 
				isdeathorserious , 
				isrisk , 
				isreportmeets , 
				issignordiagonises , 
				ismaltreatment3yrs , 
				ismaltreatment12yrs , 
				ismaltreatment24yrs , 
				isactiveinvestigation , 
				isreportedhistory , 
				ismultiple , 
				isdomesticvoilence , 
				isthread , 
				islawenforcement , 
				iscourtiinvestigation , 
				isar , 
				isir, 
				iscps, 
				isscrninrecovr_courtorder, 
				isscrninrecovr_otherspecify , 
				isscrnoutrecovr_insufficient, 
				isscrnoutrecovr_information, 
				isscrnoutrecovr_historicalinformation, 
				isscrnoutrecovr_otherspecify, 
				isimmed_childfaatility, 
				isimmed_seriousinjury, 
				isimmed_childleftalone, 
				isimmed_allegation, 
				isimmed_otherspecify, 
				iscriminalhistory, 
				yesdatadescription, 
				scrnin_description, 
				scrnout_description, 
				isnoimmed_physicalabuse, 
				isnoimmed_sexualabuse, 
				isnoimmed_neglectresponse, 
				isnoimmed_mentalinjury, 
				isfinalscreenin, 
				isfcplacementsetting, 
				isprivateplacement, 
				islicenseddaycare, 
				isschool, 
				ischildfatality,
			    issubexpnewborn,
				isriskcso,
                isriskvoilence,
				iscgimpairment,
				islivinginhome,
				isdeathan,
				issextrafficking,
				isadultsurvivor,
				isbirthmatchtpr,
				isbirthmatchcriminal		
							) 
			SELECT v_intakeserviceid, 
				   l_intakenumber, 
				   v_status, 
				   comments, 
				   ismaltreatment, 
				   referralname, 
				   referraldob, 
				   referralid, 
				   countyid, 
				   ismalpa_suspeciousdeath, 
				   ismalpa_nonaccident, 
				   ismalpa_injuryinconsistent, 
				   ismalpa_insjury, 
				   ismalpa_childtoxic, 
				   ismalpa_caregiver, 
				   ismalsa_sexualmolestation, 
				   ismalsa_sexualact, 
				   ismalsa_sexualexploitation, 
				   ismalsa_physicalindicators, 
				   isneggn_suspiciousdeath, 
				   isneggn_signsordiagnosis, 
				   isneggn_inadequatefood, 
				   isneggn_exposuretounsafe, 
				   isneggn_inadequateclothing, 
				   isneggn_inadequatesupervision, 
				   isnegrh_treatmenthealthrisk,
				   isneggn_childdischarged, 
				   isnegfp_cargiverintervene, 
				   isnegab_abandoned, 
				   isneguc_leftunsupervised, 
				   isneguc_leftaloneinappropriatecare, 
				   isneguc_leftalonewithoutsupport, 
				   isnegrh_priordeath, 
				   isnegrh_sexualperpetrator, 
				   isnegrh_basicneedsunmet, 
				   isnegrh_sex_offender , 
			       isnegrh_risk_dv , 
			       isnegrh_fatality_can , 
			       isnegrh_indicated_unsub , 
			       isnegrh_survivor , 
			       isnegrh_birth_match , 
			       isnegrh_sex_trafficking ,
				   isnegmn_unreasonabledelay, 
				   ismenab_psycologicalability, 
				   ismenng_psycologicalability, 
				   isrecsc_screenout, 
				   isrecsc_scrrenin, 
				   isrecovr_no, 
				   isrecovr_scrrenin, 
				   isreccps_screenout, 
				   isrec_imlist, 
				   isrec_noimmediate , 
				   isrec_reportallegtion, 
				   officerfirstname , 
				   officermiddlename, 
				   officerlastname, 
				   badgenumber, 
				   recordnumber, 
				   reportdate, 
				   worker, 
				   workerdate, 
				   supervisor, 
				   supervisordate, 
				   1, 
				   v_securityusersid, 
				   v_securityusersid, 
				   issexualabuse , 
				   isoutofhome , 
				   isdeathorserious , 
				   isrisk , 
				   isreportmeets , 
				   issignordiagonises , 
				   ismaltreatment3yrs , 
				   ismaltreatment12yrs , 
				   ismaltreatment24yrs , 
				   isactiveinvestigation , 
				   isreportedhistory , 
				   ismultiple , 
				   isdomesticvoilence , 
				   isthread , 
				   islawenforcement , 
				   iscourtiinvestigation , 
				   isar , 
				   isir, 
				   iscps, 
				   isscrninrecovr_courtorder, 
				   isscrninrecovr_otherspecify , 
				   isscrnoutrecovr_insufficient, 
				   isscrnoutrecovr_information, 
				   isscrnoutrecovr_historicalinformation, 
				   isscrnoutrecovr_otherspecify, 
				   isimmed_childfaatility, 
				   isimmed_seriousinjury, 
				   isimmed_childleftalone, 
				   isimmed_allegation, 
				   isimmed_otherspecify, 
				   iscriminalhistory, 
				   yesdatadescription, 
				   scrnin_description, 
				   scrnout_description, 
				   isnoimmed_physicalabuse, 
				   isnoimmed_sexualabuse, 
				   isnoimmed_neglectresponse, 
				   isnoimmed_mentalinjury, 
				   isfinalscreenin, 
				   isfcplacementsetting, 
				   isprivateplacement, 
				   islicenseddaycare, 
				   isschool, 
				   ischildfatality,
				   issubexpnewborn,
				   isriskcso,
				   isriskvoilence,
				   iscgimpairment,
				   islivinginhome,
				   isdeathan,
				   issextrafficking,
				   isadultsurvivor,
				   isbirthmatchtpr,
				   isbirthmatchcriminal
			FROM   json_to_recordset(sdmobj ) AS x(
								"comments" character varying,
								"referralname" character varying, 
								"referraldob" date, 
								"referralid" character varying, 
								"countyid" uuid, 
								"ismaltreatment" bool, 
								"ismalpa_suspeciousdeath" bool ,
								"ismalpa_nonaccident" bool , 
								"ismalpa_injuryinconsistent" bool , 
								"ismalpa_insjury" bool , 
								"ismalpa_childtoxic" bool , 
								"ismalpa_caregiver" bool , 
								"ismalsa_sexualmolestation" bool , 
								"ismalsa_sexualact" bool , 
								"ismalsa_sexualexploitation" bool ,
								"ismalsa_physicalindicators" bool , 
								"isneggn_suspiciousdeath" bool , 
								"isneggn_signsordiagnosis" bool ,
								"isneggn_inadequatefood" bool ,
								"isneggn_exposuretounsafe" bool , 
								"isneggn_inadequateclothing" bool , 
								"isneggn_inadequatesupervision" bool ,
								"isnegrh_treatmenthealthrisk" bool,
								"isneggn_childdischarged" bool , 
								"isnegfp_cargiverintervene" bool , 
								"isnegab_abandoned" bool ,
								"isneguc_leftunsupervised" bool ,
								"isneguc_leftaloneinappropriatecare" bool , 
								"isneguc_leftalonewithoutsupport" bool , 
								"isnegrh_priordeath" bool , 
								"isnegrh_sexualperpetrator" bool , 
								"isnegrh_basicneedsunmet" bool , 
								"isnegrh_sex_offender" bool , 
								"isnegrh_risk_dv" bool , 
								"isnegrh_fatality_can" bool , 
								"isnegrh_indicated_unsub" bool , 
								"isnegrh_survivor" bool , 
								"isnegrh_birth_match" bool , 
								"isnegrh_sex_trafficking" bool ,
								"isnegmn_unreasonabledelay" bool , 
								"ismenab_psycologicalability" bool ,
								"ismenng_psycologicalability" bool , 
								"isrecsc_screenout" bool , 
								"isrecsc_scrrenin" bool , 
								"isrecovr_no" bool , 
								"isrecovr_scrrenin" bool , 
								"isreccps_screenout" bool ,
								"isrec_imlist" bool , 
								"isrecovr_maltreatment" bool , 
								"isreccps_maltreatment" bool , 
								"isrec_imlt" bool , 
								"isrec_noimmediate" bool ,
								"isrec_reportallegtion" bool , 
								"officerfirstname" character varying, 
								"officermiddlename" character varying, 
								"officerlastname" character varying, 
								"badgenumber" character varying, 
								"recordnumber" character varying,
								"reportdate" date, 
								"worker" character varying, 
								"workerdate" date, 
								"supervisor" character varying, 
								"supervisordate" date, 
								"recover_no" bool,
								"recover_scrrenin" bool, 
								"reccps_screenout" bool, 
								"issexualabuse" bool ,
								"isoutofhome" bool , 
								"isdeathorserious" bool , 
								"isrisk" bool , 
								"isreportmeets" bool , 
								"issignordiagonises" bool , 
								"ismaltreatment3yrs" bool , 
								"ismaltreatment12yrs" bool , 
								"ismaltreatment24yrs" bool , 
								"isactiveinvestigation" bool , 
								"isreportedhistory" bool ,
								"ismultiple" bool , 
								"isdomesticvoilence" bool , 
								"isthread" bool , 
								"islawenforcement" bool , 
								"iscourtiinvestigation" bool , 
								"isar" bool , 
								"isir" bool , 
								"iscps" bool, 
								"isscrninrecovr_courtorder" bool, 
								"isscrninrecovr_otherspecify" bool , 
								"isscrnoutrecovr_insufficient" bool, 
								"isscrnoutrecovr_information" bool, 
								"isscrnoutrecovr_historicalinformation" bool, 
								"isscrnoutrecovr_otherspecify" bool,
								"isimmed_childfaatility" bool, 
								"isimmed_seriousinjury" bool, 
								"isimmed_childleftalone" bool, 
								"isimmed_allegation" bool, 
								"isimmed_otherspecify" bool, 
								"iscriminalhistory" bool, 
								"yesdatadescription" character varying, 
								"scrnin_description" character varying, 
								"scrnout_description" character varying, 
								"isnoimmed_physicalabuse" bool,
								"isnoimmed_sexualabuse" bool,
								"isnoimmed_neglectresponse" bool,
								"isnoimmed_mentalinjury" bool, 
								"isfinalscreenin" bool, 
								"isfcplacementsetting" bool, 
								"isprivateplacement" bool, 
								"islicenseddaycare" bool, 
								"isschool" bool, 
								"ischildfatality" bool,
								"issubexpnewborn" integer,
								"isriskcso" integer ,
								"isriskvoilence" integer,
								"iscgimpairment" integer,
								"islivinginhome" integer,
								"isdeathan" integer,
								"issextrafficking" integer,
								"isadultsurvivor" integer,
								"isbirthmatchtpr" integer,
								"isbirthmatchcriminal"	integer							
								) returning "intakeservicerequestsdmid" INTO   l_sdmid;
								
					SELECT isar, isir, ismaltreatment, iscps INTO   l_ar, l_ir, l_maltreat , l_iscps 
					FROM   intakeservicerequestsdm WHERE  intakeservicerequestsdmid = l_sdmid;

			INSERT INTO intakeservrequestsdmmaltreatment 
            ( 
                        intakeservicerequestsdmid, 
                        maltreatmenttype, 
                        maltreatorsname, 
                        activeflag, 
                        updatedby, 
                        updatedon, 
                        effectivedate, 
                        insertedby, 
                        insertedon 
            ) 
			SELECT l_sdmid, 
				   'AV', 
				   victimname, 
				   1, 
				   v_securityusersid, 
				   v_date, 
				   v_date, 
				   v_securityusersid, 
				   v_date 
			FROM   json_to_recordset(v_sdmav ) AS x("intakeservicerequestsdmid" uuid,
													"victimname" character varying);
			
			INSERT INTO intakeservrequestsdmmaltreatment( 
                        intakeservicerequestsdmid, 
                        maltreatmenttype, 
                        maltreatorsname, 
                        activeflag, 
                        updatedby, 
                        updatedon, 
                        effectivedate, 
                        insertedby, 
                        insertedon ) 
						
			SELECT l_sdmid, 
					'AM', 
				   maltreatorsname, 
				   1, 
				   v_securityusersid, 
				   v_date, 
				   v_date, 
				   v_securityusersid, 
                   v_date 
			FROM   json_to_recordset(v_sdmam) AS x(
										"intakeservicerequestsdmid" uuid, 
										"maltreatorsname" character varying );
			INSERT INTO intakeservrequestsdmmaltreatment( 
                        intakeservicerequestsdmid, 
                        maltreatmenttype, 
                        maltreatorsname, 
                        activeflag, 
                        updatedby, 
                        updatedon, 
                        effectivedate, 
                        insertedby, 
                        insertedon ) 
			SELECT l_sdmid, 
					'PR', 
					providername, 
				   1, 
				   v_securityusersid, 
				   v_date, 
				   v_date, 
				   v_securityusersid, 
				   v_date 
			FROM   json_to_recordset(v_sdmpr) AS x( 
			"intakeservicerequestsdmid" uuid, 
			"providername" character varying);
			
	IF (COALESCE(l_ar,false) = true) THEN
	l_actiontype:='AR';
	ELSIF(COALESCE(l_ir,false) = true ) THEN
	l_actiontype:='IR';
	ELSIF(COALESCE(l_maltreat,false) = true AND lower(COALESCE(dispositioncode,'')) IN ('ovrscrnin', 'scrnin')) THEN 
	l_actiontype:='IR';
	ELSE
	l_actiontype:='AR';
	END IF;

RAISE notice '(l_ar--->%' , l_ar;
RAISE notice 'l_ir--->%' , l_ir;
RAISE notice 'l_maltreat--->%' , l_maltreat;
RAISE notice 'l_actiontype--->%' , l_actiontype;
RAISE notice 'v_intakeserviceid--->%',v_intakeserviceid;
RAISE notice 'l_iscps--->%',l_iscps;

	IF (Length(l_intakenumber) = 0 AND  (l_ar = true  or l_ir = true)) THEN
	UPDATE intakeservicerequest 
	SET   actiontype = l_actiontype, iscps =l_iscps 
	WHERE  intakeserviceid = v_intakeserviceid;
	END IF;

result := 'SUCCESS';
RETURN result;
END 
$function$
;
