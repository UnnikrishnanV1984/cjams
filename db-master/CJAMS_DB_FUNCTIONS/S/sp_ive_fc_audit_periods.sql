-- Drop function
DROP FUNCTION if exists sp_ive_fc_audit_periods(json);

-- Create Function
CREATE OR REPLACE FUNCTION cjams.sp_ive_fc_audit_periods(reqobj json)
 RETURNS TABLE(v_transactionid uuid, v_hashkey character varying, v_auditperiodid bigint, v_sqnm_sw character varying, v_start_dt date, v_end_dt date, v_courtstatus character varying, v_removalhome character varying, v_citizenship character varying, v_age character varying, v_deprivation character varying, v_assets character varying, v_income character varying, v_placement character varying, v_removaltype character varying, v_demographic character varying, v_finalresult character varying, v_fostercareeligibilitystatus character varying, v_initialize character varying, v_courtorderedremovals character varying, v_childbeeninfostercare12monthormorereason character varying, v_judicialdeterminationofrefppfirstredetermination character varying, v_receiptofotherbenefitsmet character varying, v_fostercareredeterminationeligibilitystatus character varying, v_fostercareredeterminationeligibilitystatuswitheventchange character varying, v_silaagreementmet character varying, v_youth18to21eligibilitycriteriamet character varying, v_eventstage character varying, v_eventreason character varying, v_eventstatus character varying, v_eventstartdate date, v_eventenddate date)
 LANGUAGE plpgsql
AS $function$

--------------------------------
-- CDM-30985 - Veera 05-08-2023 column length issue fix
-- CIDM-10235 - Veera 02-27-2025 Insertedby, Updatedby column fix
--------------------------------

declare
	v_auditperiodid bigint;
	v_transactionid uuid;
	v_userid character varying;
    v_hashkey varchar(50);
	v_sqnm_sw varchar(10);
	v_start_dt date;
	v_end_dt date;
	v_removalid bigint;
	v_cjamspid bigint;
	v_deprivationfactor varchar(100);
	v_grossincome185pctforau decimal;
	v_reasonforabsence varchar(50);
	v_alienregistrationnumber varchar(50);
	v_dateofparentdeath date;
	v_uscitizen varchar(50);
	v_standardofneedfornotinau decimal;
	v_totalchildcarecost decimal;
	v_incarcerationdate date;
	v_exitcaredatefrompreviousfostercareepisode date;
	v_reasonforexit varchar(100);
	v_qualifiedalienstaus varchar(50);	
	v_previousfostercareepisodeexist varchar(50);	
	v_noofmembersinau integer;
	v_qualifiedalien varchar(50);
	v_dateoflivingarrangement date;
	v_childdisabilityevaluationdocumentiondate date; 
	v_strdtofseceduorequivalentprogram date;
	v_isdjsordsschild varchar(50);
	v_dateofcourthearing date; 
	v_dateof2ndparentsignatureonvpa date; 
	v_relationshipidfromwhomchildwaspremoved integer;
	v_typeofremoval varchar(50);
	v_childphysicalremovaldate date; 
	v_ctwdecision varchar(50);
	v_dateofchildsignatureonvpa date; 
	v_dateofldsssignatureonvpa date; 
	v_issafehavenbaby varchar(50);
	v_dateoffindingctwdecision date; 
	v_nameofpromotetoemploymentprogram varchar(50);
	v_dateofnexthearing date; 
	v_clientidwhosignedvpa varchar(50);
	v_childdisabilitytype varchar(50);
	v_childphysicaladdressafterremoval varchar(500);
	v_nameofsubjectctwfinding varchar(50);
	v_dateof1stparentsignatureonvpa date; 
	v_clientidfromwhomchildwaspremoved varchar(50);
	v_childdeprivedofparentalsupport varchar(50);
	v_relationshipofsubjectctwfinding varchar(50);
	v_specifiedrelativedatechildlastlivedwith date;
	v_specifiedrelativephysicaladdress varchar(500);
	v_specifiedrelativename varchar(50);
	v_specifiedrelativeclientid varchar(50);
	v_specifiedrelativerelationshipid integer;
	v_dateofreasonableeffortscourthearing date;
	v_startdateofemployment date;
	v_childdisabilitystartdate date;
	v_nmofseceduorequivalentprogram varchar(50);
	v_dateofbirth date;
	v_clientidofsubjectctwfinding varchar(50);
	v_nmofpostsecorvocationaledu varchar(50);
	v_typeofvpa varchar(50);
	v_issignedbyjudge varchar(50);
	v_courtorderdelayremoval varchar(50);
	v_courtorderdelaytimeframe integer;
	v_renotnecessaryduetoemergcir varchar(50);
	v_reasonableeffortsmade varchar(50);
	v_dateofchildplacement date;
	v_isiveagencyresforplacementandcare varchar(50);
	v_magistrateorjudgename varchar(50);
	v_noteonmiss2ndparentsigonvpa varchar;
	v_strdtofpromotetoemplprog date;
	v_hourspermonthemployed decimal;
	v_strdtofpostsecorvocedu date;
	v_dateofguardiansignatureonvpa date;
	v_nameofemployer varchar(50);
	v_assetallowance decimal;
	v_assetsmarketvalue decimal;
	v_noofmembersnotinau integer;
	v_standardofneedforau decimal;
	v_eligibleplacement varchar(50);
	v_fostercareeligibilitystatus varchar(50);
	v_courtstatus varchar(50);
	v_removalhome varchar(50);
	v_citizenship varchar(50);
	v_age varchar(50);
	v_deprivation varchar(50);
	v_assets varchar(50);
	v_income varchar(50);
	v_placement varchar(50);
	v_removaltype varchar(50);
	v_demographic varchar(50);
	v_finalresult varchar(50);
	v_householdmember json;
	v_counter json;
	v_unearnedincometype varchar(50);
	v_unearnedincomeamount decimal;
	v_isincomedeemed varchar(50);
	v_supportexpenseamount decimal;
	v_clientid varchar(50);
	v_inau varchar(50);
	v_earnedincomeamount decimal;
	v_fostercarereviewperiodenddate date;
	v_suspendthessipaymentandclaimive varchar(50);
	v_typeofcourthearing varchar;
	v_refppnotdue varchar(50);
	v_fostercarereviewperiodstartdate date;
	v_dateofsubsequentfindingofbestinterest date;
	v_isplacementeligible varchar(50);
	v_istherevalidsilaagreement varchar(50);
	v_fostercareredeterminationstage varchar(50);
	v_dtofcurrentjdfindingofrefpp date;
	v_fcpermanencyplan varchar(50);
	v_fcredetcompletiondate date;
	v_dtofcurrentjdfindingofbi date;
	v_istheagencytherepresentativepayee varchar(50);
	v_dateofjudicialfindingofrefpp date;
	v_rsnagncyisntrepresentativepayee varchar(100);
	v_dateofvalidsilaagreement date;
	v_rsnoptedtosuspssipaymntclaimive varchar(100);
	v_dtofsubjdfindingofrefpp date;
	v_dtofprevjdfindingofrefpp date;
	v_childclientid varchar(50);
	v_dtagncylstlegalresp date;
	v_dtofprevbifinding date;
	v_childfostercareentrydate date;
	v_typeofbenefit varchar(50);
	v_childreceivssireviewperiod varchar(50);
	v_amountofbenefit decimal;
	v_childbeeninfc12monthormore varchar(50);
	v_dateofbestinterestfinding date;
	v_initialize varchar(50);
	v_courtorderedremovals varchar(50);
	v_childbeeninfc12mnthormorersn varchar(50);
	v_fcredeteligstatus varchar(50);
	v_jdofrefpp1stredet varchar(50);
	v_receiptofotherbenefitsmet varchar(50);
	v_fostercareevent json;
	v_rdcounter json;
	v_eventreason varchar(50);
	v_eventstatus varchar(50);
	v_typeoflapses varchar(50);
	v_eventstage varchar(50);
	v_eventenddate date;
	v_eventstartdate date;
	v_fcredeteligstatuswithevntchng varchar(50);
	v_silaagreementmet varchar(50);
	v_yth18to21eligcriteriamet varchar(50);
	v_severity VARCHAR(20);
	v_text varchar(3000);
	v_auditmessages json;
	v_msgcounter json;
	v_auditreason json;
	v_auditstatus json; 
	v_picklist_value_cd varchar(10);
	v_inputjson json;
	v_outputjson json;
	v_wasthechildremfromspfiedrel varchar(50);
	v_vparemovaldate date;
	v_courtorderremovaldate date;
	v_type_cd  varchar;
	v_eligibility_period_id  int;
	v_eligibility_id   int;
	v_beyondr1eligibility varchar;

begin
	v_transactionid := reqobj ->> 'transactionid';
	v_userid := reqobj ->> 'userid';
    v_hashkey := reqobj ->> 'hashkey';
	v_sqnm_sw := reqobj ->> 'sqnm_sw';
	v_start_dt := reqobj ->> 'start_dt';
	v_end_dt := reqobj ->> 'end_dt';
	v_removalid := reqobj ->> 'removalid';
	v_cjamspid := reqobj ->> 'cjamspid';
	v_deprivationfactor := reqobj ->> 'deprivationfactor';
	v_grossincome185pctforau := reqobj ->> 'grossincome185pctforau';
	v_reasonforabsence := reqobj ->> 'reasonforabsence';
	v_alienregistrationnumber := reqobj ->> 'alienregistrationnumber';
	v_dateofparentdeath := reqobj ->> 'dateofparentdeath';
	v_uscitizen := reqobj ->> 'uscitizen';
	v_standardofneedfornotinau := reqobj ->> 'standardofneedfornotinau';
	v_totalchildcarecost := reqobj ->> 'totalchildcarecost';
	v_incarcerationdate := reqobj ->> 'incarcerationdate';
	v_exitcaredatefrompreviousfostercareepisode := reqobj ->> 'exitcaredatefrompreviousfostercareepisode';
	v_reasonforexit := reqobj ->> 'reasonforexit';
	v_qualifiedalienstaus := reqobj ->> 'qualifiedalienstaus';
	v_previousfostercareepisodeexist := reqobj ->> 'previousfostercareepisodeexist';
	v_noofmembersinau := reqobj ->> 'noofmembersinau';
	v_qualifiedalien := reqobj ->> 'qualifiedalien';	
	v_dateoflivingarrangement := reqobj ->> 'dateoflivingarrangement';
	v_childdisabilityevaluationdocumentiondate := reqobj ->> 'childdisabilityevaluationdocumentiondate';
	v_strdtofseceduorequivalentprogram := reqobj ->> 'startdateofsecondaryeducationorequivalentprogram';
	v_isdjsordsschild := reqobj ->> 'isdjsordsschild';
	v_dateofcourthearing := reqobj ->> 'dateofcourthearing';
	v_dateof2ndparentsignatureonvpa := reqobj ->> 'dateof2ndparentsignatureonvpa';
	v_relationshipidfromwhomchildwaspremoved := reqobj ->> 'relationshipidofpersonfromwhomchildwasphysicallyremoved';
	v_typeofremoval := reqobj ->> 'typeofremoval';
	v_childphysicalremovaldate := reqobj ->> 'childphysicalremovaldate';
	v_ctwdecision := reqobj ->> 'ctwdecision';
	v_dateofchildsignatureonvpa := reqobj ->> 'dateofchildsignatureonvpa';
	v_dateofldsssignatureonvpa := reqobj ->> 'dateofldsssignatureonvpa';
	v_issafehavenbaby := reqobj ->> 'issafehavenbaby';
	v_dateoffindingctwdecision := reqobj ->> 'dateoffindingctwdecision';
	v_nameofpromotetoemploymentprogram := reqobj ->> 'nameofpromotetoemploymentprogram';
	v_dateofnexthearing := reqobj ->> 'dateofnexthearing';
	v_clientidwhosignedvpa := reqobj ->> 'clientidwhosignedvpa';
	v_childdisabilitytype := reqobj ->> 'childdisabilitytype';
	v_childphysicaladdressafterremoval := reqobj ->> 'childphysicaladdressafterremoval';
	v_nameofsubjectctwfinding := reqobj ->> 'nameofsubjectctwfinding';
	v_dateof1stparentsignatureonvpa := reqobj ->> 'dateof1stparentsignatureonvpa';
	v_clientidfromwhomchildwaspremoved := reqobj ->> 'clientidofpersonfromwhomchildwasphysicallyremoved';
	v_childdeprivedofparentalsupport := reqobj ->> 'childdeprivedofparentalsupport';
	v_relationshipofsubjectctwfinding := reqobj ->> 'relationshipofsubjectctwfinding';
	v_specifiedrelativedatechildlastlivedwith := reqobj ->> 'specifiedrelativedatechildlastlivedwith';
	v_specifiedrelativephysicaladdress := reqobj ->> 'specifiedrelativephysicaladdress';
	v_specifiedrelativename := reqobj ->> 'specifiedrelativename';
	v_specifiedrelativeclientid := reqobj ->> 'specifiedrelativeclientid';
	v_specifiedrelativerelationshipid := reqobj ->> 'specifiedrelativerelationshipid';
	v_dateofreasonableeffortscourthearing := reqobj ->> 'dateofreasonableeffortscourthearing';
	v_startdateofemployment := reqobj ->> 'startdateofemployment';
	v_childdisabilitystartdate := reqobj ->> 'childdisabilitystartdate';
	v_nmofseceduorequivalentprogram := reqobj ->> 'nameofsecondaryeducationorequivalentprogram';
	v_dateofbirth := reqobj ->> 'dateofbirth';
	v_clientidofsubjectctwfinding := reqobj ->> 'clientidofsubjectctwfinding';
	v_nmofpostsecorvocationaledu := reqobj ->> 'nameofpostsecondaryorvocationaleducation';
	v_typeofvpa := reqobj ->> 'typeofvpa';
	v_issignedbyjudge := reqobj ->> 'issignedbyjudge';
	v_courtorderdelayremoval := reqobj ->> 'courtorderdelayremoval';
	v_courtorderdelaytimeframe := reqobj ->> 'courtorderdelaytimeframe';
	v_renotnecessaryduetoemergcir := reqobj ->> 'reasonableeffortsnotnecessaryduetoemergentcircumstances';
	v_reasonableeffortsmade := reqobj ->> 'reasonableeffortsmade';
	v_dateofchildplacement := reqobj ->> 'dateofchildplacement';
	v_isiveagencyresforplacementandcare := reqobj ->> 'isiveagencyresponsibleforplacementandcare';
	v_magistrateorjudgename := reqobj ->> 'magistrateorjudgename';
	v_noteonmiss2ndparentsigonvpa := reqobj ->> 'mandatorynoteonmissing2ndparentsignatureonvpa';
	v_strdtofpromotetoemplprog := reqobj ->> 'startdateofpromotetoemploymentprogram';
	v_hourspermonthemployed := reqobj ->> 'hourspermonthemployed';
	v_strdtofpostsecorvocedu := reqobj ->> 'startdateofpostsecondaryorvocationaleducation';
	v_dateofguardiansignatureonvpa := reqobj ->> 'dateofguardiansignatureonvpa';
	v_nameofemployer := reqobj ->> 'nameofemployer';
	v_assetallowance := reqobj ->> 'assetallowance';
	v_assetsmarketvalue := reqobj ->> 'assetsmarketvalue';
	v_noofmembersnotinau := reqobj ->> 'noofmembersnotinau';
	v_standardofneedforau := reqobj ->> 'standardofneedforau';
	v_eligibleplacement := reqobj ->> 'eligibleplacement';
	v_fostercareeligibilitystatus := reqobj ->> 'fostercareeligibilitystatus';
	v_courtstatus := reqobj ->> 'courtstatus';
	v_removalhome := reqobj ->> 'removalhome';
	v_citizenship := reqobj ->> 'citizenship';
	v_age := reqobj ->> 'age';
	v_deprivation := reqobj ->> 'deprivation';
	v_assets := reqobj ->> 'assets';
	v_income := reqobj ->> 'income';
	v_placement := reqobj ->> 'placement';
	v_removaltype := reqobj ->> 'removaltype';
	v_demographic := reqobj ->> 'demographic';
	v_finalresult := reqobj ->> 'finalresult';
	v_householdmember := reqobj ->> 'householdmember';

	v_fostercarereviewperiodenddate := reqobj ->> 'fostercarereviewperiodenddate';
	v_suspendthessipaymentandclaimive := reqobj ->> 'hastheagencyoptedtosuspendthessipaymentandclaimive';
	v_typeofcourthearing := reqobj ->> 'typeofcourthearing';
	v_refppnotdue := reqobj ->> 'refppnotdue';
	v_fostercarereviewperiodstartdate := reqobj ->> 'fostercarereviewperiodstartdate';
	v_dateofsubsequentfindingofbestinterest := reqobj ->> 'dateofsubsequentfindingofbestinterest';
	v_isplacementeligible := reqobj ->> 'isplacementeligible';
	v_istherevalidsilaagreement := reqobj ->> 'istherevalidsilaagreement';
	v_fostercareredeterminationstage := reqobj ->> 'fostercareredeterminationstage';
	v_dtofcurrentjdfindingofrefpp := reqobj ->> 'dateofcurrentjudicialfindingofrefpp';
	v_fcpermanencyplan := reqobj ->> 'fostercarepermanencyplan';
	v_fcredetcompletiondate := reqobj ->> 'fostercareredeterminationcompletiondate';
	v_dtofcurrentjdfindingofbi := reqobj ->> 'dateofcurrentjudicialfindingofbestinterest';
	v_istheagencytherepresentativepayee := reqobj ->> 'istheagencytherepresentativepayee';
	v_dateofjudicialfindingofrefpp := reqobj ->> 'dateofjudicialfindingofrefpp';
	v_rsnagncyisntrepresentativepayee := reqobj ->> 'reasonforwhytheagencyisnottherepresentativepayee';
	v_dateofvalidsilaagreement := reqobj ->> 'dateofvalidsilaagreement';
	v_rsnoptedtosuspssipaymntclaimive := reqobj ->> 'reasonfornotoptedtosuspendthessipaymentandclaimive';
	v_dtofsubjdfindingofrefpp := reqobj ->> 'dateofsubsequentjudicialfindingofrefpp';
	v_dtofprevjdfindingofrefpp := reqobj ->> 'dateofpreviousjudicialfindingofrefpp';
	v_childclientid := reqobj ->> 'childclientid';
	v_dtagncylstlegalresp := reqobj ->> 'dateagencylostlegalresponsibility';
	v_dtofprevbifinding := reqobj ->> 'dateofpreviousbestinterestfinding';
	v_childfostercareentrydate := reqobj ->> 'childfostercareentrydate';
	v_typeofbenefit := reqobj ->> 'typeofbenefit';
	v_childreceivssireviewperiod := reqobj ->> 'childreceivingssiorssaduringreviewperiod';
	v_amountofbenefit := reqobj ->> 'amountofbenefit';
	v_childbeeninfc12monthormore := reqobj ->> 'childbeeninfostercare12monthormore';
	v_dateofbestinterestfinding := reqobj ->> 'dateofbestinterestfinding';
	v_initialize := reqobj ->> 'initialize';
	v_courtorderedremovals := reqobj ->> 'courtorderedremovals';
	v_childbeeninfc12mnthormorersn := reqobj ->> 'childbeeninfostercare12monthormorereason';
	v_fcredeteligstatus := reqobj ->> 'fostercareredeterminationeligibilitystatus';
	v_fcredeteligstatuswithevntchng := reqobj ->> 'fostercareredeterminationeligibilitystatuswitheventchange';
	v_jdofrefpp1stredet := reqobj ->> 'judicialdeterminationofrefppfirstredetermination';
	v_receiptofotherbenefitsmet := reqobj ->> 'receiptofotherbenefitsmet';
	v_fostercareevent := reqobj ->> 'fostercareevents';

	v_silaagreementmet := reqobj ->> 'silaagreementmet';
	v_yth18to21eligcriteriamet := reqobj ->> 'youth18to21eligibilitycriteriamet';

	v_auditmessages := reqobj ->> 'auditmessages';	
	v_auditstatus := reqobj ->> 'auditstatus';
	v_auditreason := reqobj ->> 'auditreason';
	v_inputjson := reqobj ->> 'inputjson';
	v_outputjson := reqobj ->> 'outputjson';
	v_wasthechildremfromspfiedrel := reqobj ->> 'wasthechildremovedfromspecifiedrelative';
	v_vparemovaldate := reqobj ->> 'vparemovaldate';
	v_courtorderremovaldate := reqobj ->> 'courtorderremovaldate';
	v_beyondr1eligibility := reqobj ->> 'beyondr1eligibility';

	INSERT INTO tb_ive_fostercare_audit(
		transactionid, 
		hashkey, 
		removalid, 
		cjamspid, 
		sqnm_sw, 
		start_dt, 
		end_dt, 
		deprivationfactor, 
		grossincome185pctforau, 
		reasonforabsence, 
		alienregistrationnumber, 
		dateofparentdeath, 
		uscitizen, 
		standardofneedfornotinau, 
		totalchildcarecost, 
		incarcerationdate, 
		exitcaredatefrompreviousfostercareepisode, 
		reasonforexit, 
		qualifiedalienstaus, 
		previousfostercareepisodeexist, 
		noofmembersinau, 
		qualifiedalien, 
		dateoflivingarrangement, 
		childdisabilityevaluationdocumentiondate, 
		startdateofsecondaryeducationorequivalentprogram, 
		isdjsordsschild, 
		dateofcourthearing, 
		dateof2ndparentsignatureonvpa, 
		relationshipidofpersonfromwhomchildwasphysicallyremoved, 
		typeofremoval, 
		childphysicalremovaldate, 
		ctwdecision, 
		dateofchildsignatureonvpa, 
		dateofldsssignatureonvpa, 
		issafehavenbaby, 
		dateoffindingctwdecision, 
		nameofpromotetoemploymentprogram, 
		dateofnexthearing, 
		clientidwhosignedvpa, 
		childdisabilitytype, 
		childphysicaladdressafterremoval, 
		nameofsubjectctwfinding, 
		dateof1stparentsignatureonvpa, 
		clientidofpersonfromwhomchildwasphysicallyremoved, 
		childdeprivedofparentalsupport, 
		relationshipofsubjectctwfinding, 
		specifiedrelativedatechildlastlivedwith, 
		specifiedrelativephysicaladdress, 
		specifiedrelativename, 
		specifiedrelativeclientid, 
		specifiedrelativerelationshipid, 
		dateofreasonableeffortscourthearing, 
		nameofsecondaryeducationorequivalentprogram, 
		dateofbirth, 
		clientidofsubjectctwfinding, 
		nameofpostsecondaryorvocationaleducation, 
		typeofvpa, 
		issignedbyjudge, 
		courtorderdelayremoval, 
		courtorderdelaytimeframe, 
		reasonableeffortsnotnecessaryduetoemergentcircumstances, 
		reasonableeffortsmade, 
		dateofchildplacement, 
		isiveagencyresponsibleforplacementandcare, 
		magistrateorjudgename, 
		mandatorynoteonmissing2ndparentsignatureonvpa, 
		startdateofpromotetoemploymentprogram, 
		hourspermonthemployed, 
		startdateofpostsecondaryorvocationaleducation, 
		dateofguardiansignatureonvpa, 
		nameofemployer, 
		assetallowance, 
		assetsmarketvalue, 
		noofmembersnotinau, 
		standardofneedforau, 
		eligibleplacement, 
		fostercareeligibilitystatus, 
		courtstatus, 
		removalhome, 
		citizenship, 
		age, 
		deprivation, 
		assets, 
		income, 
		placement, 
		removaltype, 
		demographic, 
		finalresult, 
		fostercarereviewperiodenddate, 
		hastheagencyoptedtosuspendthessipaymentandclaimive, 
		typeofcourthearing, 
		refppnotdue, 
		fostercarereviewperiodstartdate, 
		dateofsubsequentfindingofbestinterest, 
		isplacementeligible, 
		istherevalidsilaagreement, 
		fostercareredeterminationstage, 
		dateofcurrentjudicialfindingofrefpp, 
		fostercarepermanencyplan, 
		fostercareredeterminationcompletiondate, 
		dateofcurrentjudicialfindingofbestinterest, 
		istheagencytherepresentativepayee, 
		dateofjudicialfindingofrefpp, 
		reasonforwhytheagencyisnottherepresentativepayee, 
		dateofvalidsilaagreement, 
		reasonfornotoptedtosuspendthessipaymentandclaimive, 
		dateofsubsequentjudicialfindingofrefpp, 
		dateofpreviousjudicialfindingofrefpp, 
		childclientid, 
		dateagencylostlegalresponsibility, 
		dateofpreviousbestinterestfinding, 
		childfostercareentrydate, 
		typeofbenefit, 
		childreceivingssiorssaduringreviewperiod, 
		amountofbenefit, 
		childbeeninfostercare12monthormore, 
		dateofbestinterestfinding, 
		initialize, 
		courtorderedremovals, 
		childbeeninfostercare12monthormorereason, 
		judicialdeterminationofrefppfirstredetermination, 
		receiptofotherbenefitsmet, 
		fostercareredeterminationeligibilitystatus, 
		fostercareredeterminationeligibilitystatuswitheventchange, 
		silaagreementmet, 
		youth18to21eligibilitycriteriamet, 
		statusjsondata , 
		reasonjsondata, 
		inputjson , 
		outputjson, 
		wasthechildremovedfromspecifiedrelative,
		vparemovaldate,
		courtorderremovaldate,
		beyondr1eligibility,
		insertedby , updatedby , insertedon , updatedon
		)
	VALUES(
		v_transactionid, 
		v_hashkey, 
		v_removalid, 
		v_cjamspid, 
		v_sqnm_sw, 
		v_start_dt, 
		v_end_dt, 
		v_deprivationfactor, 
		v_grossincome185pctforau, 
		v_reasonforabsence, 
		v_alienregistrationnumber, 
		v_dateofparentdeath, 
		v_uscitizen, 
		v_standardofneedfornotinau, 
		v_totalchildcarecost, 
		v_incarcerationdate, 
		v_exitcaredatefrompreviousfostercareepisode, 
		v_reasonforexit, 
		v_qualifiedalienstaus, 
		v_previousfostercareepisodeexist, 
		v_noofmembersinau, 
		v_qualifiedalien, 
		v_dateoflivingarrangement, 
		v_childdisabilityevaluationdocumentiondate, 
		v_strdtofseceduorequivalentprogram, 
		v_isdjsordsschild, 
		v_dateofcourthearing, 
		v_dateof2ndparentsignatureonvpa, 
		v_relationshipidfromwhomchildwaspremoved, 
		v_typeofremoval, 
		v_childphysicalremovaldate, 
		v_ctwdecision, 
		v_dateofchildsignatureonvpa, 
		v_dateofldsssignatureonvpa, 
		v_issafehavenbaby, 
		v_dateoffindingctwdecision, 
		v_nameofpromotetoemploymentprogram, 
		v_dateofnexthearing, 
		v_clientidwhosignedvpa, 
		v_childdisabilitytype, 
		v_childphysicaladdressafterremoval, 
		v_nameofsubjectctwfinding, 
		v_dateof1stparentsignatureonvpa, 
		v_clientidfromwhomchildwaspremoved, 
		v_childdeprivedofparentalsupport, 
		v_relationshipofsubjectctwfinding, 
		v_specifiedrelativedatechildlastlivedwith, 
		v_specifiedrelativephysicaladdress, 
		v_specifiedrelativename, 
		v_specifiedrelativeclientid, 
		v_specifiedrelativerelationshipid, 
		v_dateofreasonableeffortscourthearing, 
		v_nmofseceduorequivalentprogram, 
		v_dateofbirth, 
		v_clientidofsubjectctwfinding, 
		v_nmofpostsecorvocationaledu, 
		v_typeofvpa, 
		v_issignedbyjudge, 
		v_courtorderdelayremoval, 
		v_courtorderdelaytimeframe, 
		v_renotnecessaryduetoemergcir, 
		v_reasonableeffortsmade, 
		v_dateofchildplacement, 
		v_isiveagencyresforplacementandcare, 
		v_magistrateorjudgename, 
		v_noteonmiss2ndparentsigonvpa, 
		v_strdtofpromotetoemplprog, 
		v_hourspermonthemployed, 
		v_strdtofpostsecorvocedu, 
		v_dateofguardiansignatureonvpa, 
		v_nameofemployer, 
		v_assetallowance, 
		v_assetsmarketvalue, 
		v_noofmembersnotinau, 
		v_standardofneedforau, 
		v_eligibleplacement, 
		v_fostercareeligibilitystatus, 
		v_courtstatus, 
		v_removalhome, 
		v_citizenship, 
		v_age, 
		v_deprivation, 
		v_assets, 
		v_income, 
		v_placement, 
		v_removaltype, 
		v_demographic, 
		v_finalresult, 
		v_fostercarereviewperiodenddate, 
		v_suspendthessipaymentandclaimive, 
		v_typeofcourthearing, 
		v_refppnotdue, 
		v_fostercarereviewperiodstartdate, 
		v_dateofsubsequentfindingofbestinterest, 
		v_isplacementeligible, 
		v_istherevalidsilaagreement, 
		v_fostercareredeterminationstage, 
		v_dtofcurrentjdfindingofrefpp, 
		v_fcpermanencyplan, 
		v_fcredetcompletiondate, 
		v_dtofcurrentjdfindingofbi, 
		v_istheagencytherepresentativepayee, 
		v_dateofjudicialfindingofrefpp, 
		v_rsnagncyisntrepresentativepayee, 
		v_dateofvalidsilaagreement, 
		v_rsnoptedtosuspssipaymntclaimive, 
		v_dtofsubjdfindingofrefpp, 
		v_dtofprevjdfindingofrefpp, 
		v_childclientid, 
		v_dtagncylstlegalresp, 
		v_dtofprevbifinding, 
		v_childfostercareentrydate, 
		v_typeofbenefit, 
		v_childreceivssireviewperiod, 
		v_amountofbenefit, 
		v_childbeeninfc12monthormore, 
		v_dateofbestinterestfinding, 
		v_initialize, 
		v_courtorderedremovals, 
		v_childbeeninfc12mnthormorersn, 
		v_jdofrefpp1stredet, 
		v_receiptofotherbenefitsmet, 
		v_fcredeteligstatus, 
		v_fcredeteligstatuswithevntchng, 
		v_silaagreementmet, 
		v_yth18to21eligcriteriamet,
		v_auditstatus,
		v_auditreason, 
		v_inputjson, 
		v_outputjson, 
		v_wasthechildremfromspfiedrel,
		v_vparemovaldate,
		v_courtorderremovaldate,
		v_beyondr1eligibility,
		v_userid , v_userid , now() , now()
		);

	select eligibility_id into v_eligibility_id from tb_client_eligibility where client_id = v_cjamspid and removal_id = v_removalid;


	SELECT auditperiodid into v_auditperiodid from tb_ive_fostercare_audit where transactionid = v_transactionid and sqnm_sw = v_sqnm_sw;

	Update tb_eligibility_period set delete_sw = 'Y' where eligibility_id = v_eligibility_id and sqnm_sw = v_sqnm_sw;

	IF(v_sqnm_sw = 'I') THEN
		v_type_cd = '2923';
		
		SELECT tpv.picklist_value_cd INTO v_picklist_value_cd FROM tb_picklist_values tpv 
		WHERE tpv.picklist_type_id = 262 AND tpv.value_tx = v_fostercareeligibilitystatus;

		INSERT INTO tb_eligibility_period
		(eligibility_period_id, start_dt, end_dt, status_cd, eligibility_id, create_ts, create_user_id, update_ts, update_user_id, delete_sw, sqnm_sw, finalresult, ivenarrativesection)
		VALUES(nextval('seq_tb_eligibility_period')::integer, v_start_dt, v_end_dt, v_picklist_value_cd, v_eligibility_id, now(), v_userid, now(), v_userid, 'N'::bpchar, v_sqnm_sw, v_finalresult, 'YES') returning eligibility_period_id into v_eligibility_period_id;

	ELSE
		v_type_cd = '2924';	

		IF (v_fcredeteligstatuswithevntchng is not null) 
		THEN
			SELECT tpv.picklist_value_cd INTO v_picklist_value_cd FROM tb_picklist_values tpv 
			WHERE tpv.picklist_type_id = 262 AND tpv.value_tx = v_fcredeteligstatuswithevntchng;
		ELSE
			SELECT tpv.picklist_value_cd INTO v_picklist_value_cd FROM tb_picklist_values tpv 
			WHERE tpv.picklist_type_id = 262 AND tpv.value_tx = v_fcredeteligstatus;
		END IF;

		INSERT INTO tb_eligibility_period
		(eligibility_period_id, start_dt, end_dt, status_cd, eligibility_id, create_ts, create_user_id, update_ts, update_user_id, delete_sw, sqnm_sw, finalresult, ivenarrativesection)
		VALUES(nextval('seq_tb_eligibility_period')::integer, v_start_dt, v_end_dt, v_picklist_value_cd, v_eligibility_id, now(), v_userid, now(), v_userid, 'N'::bpchar, v_sqnm_sw, v_finalresult, 'YES') returning eligibility_period_id into v_eligibility_period_id;
	
	END IF;

	UPDATE tb_ive_fostercare_audit SET eligibility_period_id = v_eligibility_period_id WHERE auditperiodid=v_auditperiodid;
	
--	v_counter := 0;
	 FOR v_rdcounter IN SELECT * FROM json_array_elements(v_fostercareevent)	 
	 loop	 	
	 	v_eventreason := v_rdcounter ->> 'eventreason';
		v_eventstatus := v_rdcounter ->> 'eventstatus';
		v_eventstage := v_rdcounter ->> 'eventstage';
		v_eventenddate := v_rdcounter ->> 'eventenddate';
		v_eventstartdate := v_rdcounter ->> 'eventstartdate';
		
		insert into tb_eligibility_events (event_id, type_cd, event_dt, eligibility_period_id, resulting_status_cd, create_ts, update_ts, create_user_id, update_user_id, delete_sw, event_start_dt, event_end_dt, active_sw, notes_tx, reason_cd) 
		values (nextval('seq_tb_eligibility_events')::integer, v_type_cd, now(), v_eligibility_period_id, (select picklist_value_cd from tb_picklist_values where trim(picklist_type_id::varchar) = '262' and description_tx = v_eventstatus), now(), now(), v_userid, v_userid,'N', v_eventstartdate, v_eventenddate, 'Y', v_eventstage, (select picklist_value_cd from tb_picklist_values where trim(picklist_type_id::varchar) = '263' and description_tx = v_eventreason));
--	    RAISE NOTICE 'output from space %', v_rdcounter ->> 'eventreason';
	 END LOOP;
	
	FOR v_msgcounter IN SELECT * FROM json_array_elements(v_auditmessages)	 
	 loop	 	
	 	v_severity := v_msgcounter ->> 'severity';
		v_text := v_msgcounter ->> 'message';		
	
	 	insert into fcauditperiodmessages(fcauditperiodmessagesid, auditperiodid, severity, message, cjamspid, insertedby, updatedby, insertedon, updatedon)
	 	values(gen_random_uuid(), v_eligibility_period_id, v_severity, v_text, v_cjamspid, v_userid, v_userid, now(), now());
--	    RAISE NOTICE 'output from space %', v_rdcounter ->> 'eventreason';
	 END LOOP;

-- component status
	-- court order
	insert into tb_ive_component_status (ive_component_status_id, component_type_cd, ive_event_status_cd, effective_dt, event_id, create_ts, update_ts, create_user_id, update_user_id, delete_sw)
	values(nextval('seq_tb_ive_component_status')::integer, '3238', (select picklist_value_cd from tb_picklist_values where trim(picklist_type_id::varchar) = '262' and description_tx = v_courtstatus), now(), v_eligibility_period_id, now(), now(), v_userid, v_userid,'N');
	-- removal Home
	insert into tb_ive_component_status (ive_component_status_id, component_type_cd, ive_event_status_cd, effective_dt, event_id, create_ts, update_ts, create_user_id, update_user_id, delete_sw)
	values(nextval('seq_tb_ive_component_status')::integer, '3239', (select picklist_value_cd from tb_picklist_values where trim(picklist_type_id::varchar) = '262' and description_tx = v_removalhome), now(), v_eligibility_period_id, now(), now(), v_userid, v_userid,'N');
	-- Deprivation
	insert into tb_ive_component_status (ive_component_status_id, component_type_cd, ive_event_status_cd, effective_dt, event_id, create_ts, update_ts, create_user_id, update_user_id, delete_sw)
	values(nextval('seq_tb_ive_component_status')::integer, '3240', (select picklist_value_cd from tb_picklist_values where trim(picklist_type_id::varchar) = '262' and description_tx = v_deprivation), now(), v_eligibility_period_id, now(), now(), v_userid, v_userid,'N');
	-- Assets
	insert into tb_ive_component_status (ive_component_status_id, component_type_cd, ive_event_status_cd, effective_dt, event_id, create_ts, update_ts, create_user_id, update_user_id, delete_sw)
	values(nextval('seq_tb_ive_component_status')::integer, '3242', (select picklist_value_cd from tb_picklist_values where trim(picklist_type_id::varchar) = '262' and description_tx = v_assets), now(), v_eligibility_period_id, now(), now(), v_userid, v_userid,'N');
	-- Income summary
	insert into tb_ive_component_status (ive_component_status_id, component_type_cd, ive_event_status_cd, effective_dt, event_id, create_ts, update_ts, create_user_id, update_user_id, delete_sw)
	values(nextval('seq_tb_ive_component_status')::integer, '3241', (select picklist_value_cd from tb_picklist_values where trim(picklist_type_id::varchar) = '262' and description_tx = v_income), now(), v_eligibility_period_id, now(), now(), v_userid, v_userid,'N');
	-- placement
	insert into tb_ive_component_status (ive_component_status_id, component_type_cd, ive_event_status_cd, effective_dt, event_id, create_ts, update_ts, create_user_id, update_user_id, delete_sw)
	values(nextval('seq_tb_ive_component_status')::integer, '3339', (select picklist_value_cd from tb_picklist_values where trim(picklist_type_id::varchar) = '262' and description_tx = v_placement), now(), v_eligibility_period_id, now(), now(), v_userid, v_userid,'N');
	-- Demographics
	insert into tb_ive_component_status (ive_component_status_id, component_type_cd, ive_event_status_cd, effective_dt, event_id, create_ts, update_ts, create_user_id, update_user_id, delete_sw)
	values(nextval('seq_tb_ive_component_status')::integer, '3236', (select picklist_value_cd from tb_picklist_values where trim(picklist_type_id::varchar) = '262' and description_tx = v_demographic), now(), v_eligibility_period_id, now(), now(), v_userid, v_userid,'N');
	-- Removal type
	insert into tb_ive_component_status (ive_component_status_id, component_type_cd, ive_event_status_cd, effective_dt, event_id, create_ts, update_ts, create_user_id, update_user_id, delete_sw)
	values(nextval('seq_tb_ive_component_status')::integer, '3237', (select picklist_value_cd from tb_picklist_values where trim(picklist_type_id::varchar) = '262' and description_tx = v_removaltype), now(), v_eligibility_period_id, now(), now(), v_userid, v_userid,'N');



	
RETURN QUERY
select
 --tb_audit_periods
 tap.transactionid													AS		v_transactionid,
 tap.hashkey														AS		v_hashkey,
 tap.auditperiodid													AS		v_auditperiodid,
 tap.sqnm_sw                  										AS  	v_sqnm_sw,              
 tap.start_dt                 										AS  	v_start_dt,
 tap.end_dt															AS		v_end_dt,
 tap.courtstatus              										AS  	v_courtstatus,              
 tap.removalhome                 									AS  	v_removalhome,
 tap.citizenship              										AS  	v_citizenship,              
 tap.age                 											AS  	v_age,
 tap.deprivation              										AS  	v_deprivation,              
 tap.assets                 										AS  	v_assets,
 tap.income                 										AS  	v_income,
 tap.placement              										AS  	v_placement,
 tap.removaltype              										AS  	v_removaltype,
 tap.demographic              										AS  	v_demographic,
 tap.finalresult                 									AS  	v_finalresult,
 tap.fostercareeligibilitystatus   									AS  	v_fostercareeligibilitystatus, 
 tap.initialize   													AS  	v_initialize, 
 tap.courtorderedremovals   										AS  	v_courtorderedremovals, 
 tap.childbeeninfostercare12monthormorereason   					AS  	v_childbeeninfostercare12monthormorereason, 
 tap.judicialdeterminationofrefppfirstredetermination   			AS  	v_judicialdeterminationofrefppfirstredetermination, 
 tap.receiptofotherbenefitsmet   									AS  	v_receiptofotherbenefitsmet,
 tap.fostercareredeterminationeligibilitystatus   					AS  	v_fostercareredeterminationeligibilitystatus,
 tap.fostercareredeterminationeligibilitystatuswitheventchange  	AS  	v_fostercareredeterminationeligibilitystatuswitheventchange,
 tap.silaagreementmet											  	AS  	v_silaagreementmet, 
 tap.youth18to21eligibilitycriteriamet								AS  	v_youth18to21eligibilitycriteriamet,
 
-- tb_audit_fostercareevent
 taf.eventstage											AS		v_eventstage,
 taf.eventreason										AS		v_eventreason,
 taf.eventstatus										AS		v_eventstatus,
 taf.eventstartdate::date								AS		v_eventstartdate,
 taf.eventenddate::date									AS		v_eventenddate
 
 FROM tb_ive_fostercare_audit AS tap
 LEFT JOIN tb_audit_fostercareevent AS taf ON tap.auditperiodid = taf.auditperiodid
 where tap.transactionid = v_transactionid and tap.sqnm_sw = v_sqnm_sw;

end;
$function$
;
