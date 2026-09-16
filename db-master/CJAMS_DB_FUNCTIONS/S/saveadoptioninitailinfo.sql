DROP FUNCTION IF EXISTS cjams.saveadoptioninitailinfo(reqobj json);
CREATE OR REPLACE FUNCTION cjams.saveadoptioninitailinfo(reqobj json)
 RETURNS text
 LANGUAGE plpgsql
AS $function$ 
--------------------------------------------------------------------------------------------------------------
--- CDM-20318 - 03-21 - changed type VARCHAR to TEXT IN adoptioninitialeligibilityinfo  Table

--------------------------------------------------------------------------------------------------------------
DECLARE
	v_clientId  BIGINT;
	returnStatus text;
	v_num INT;
    v_countyofjurisdiction varchar(50);
    v_nameofchild varchar(80);
    v_dateofbirth timestamp;
    v_gender varchar(10);
    v_nameofadoptiveparent1 varchar(80);
    v_nameofadoptiveparent2 varchar(80);
    v_provideridofadoptiveparent int4;
    v_dateofadoptionfinalization timestamp;
    v_singleparentadoptioncheck boolean;
    v_adoptionparent1signdate timestamp;
    v_adoptionparent2signdate timestamp;
    v_adoptionldssdate timestamp;
    v_adoptionpetitiondate timestamp;
    v_childmeetallmedicaldisabilityrequirementsforssi varchar(10);
    v_child617yearsofage boolean;
    v_physicalmentalemotionaldisability boolean;
    v_emotionaldisturbance boolean;
    v_siblinginformationcheck boolean;
    v_siblinggroup json;
    v_recognizedhighriskofphysicaldisability boolean;
    v_raceethnicityofchild boolean;
    v_raceorethnicitywithoneofthesabove text;
    v_effortstoplacechildweremade varchar(10);
    v_dtofdocforeffortstoplacewithoutasubsidy timestamp;
    v_exceptiongrantedinchildsbestinterests varchar(10);
    v_dtofdocumentationforexceptiongrantedinchildsbi timestamp;
    v_isreasonforexceptionrecorded varchar(10);
    v_unsuccessfulreasonableeffortsstatusrecords varchar(10);
    v_tprGrantedtoBothParent varchar(10);
    v_dateofTpRofParent1 timestamp;
    v_dateofTpRofParent2 timestamp;
    v_ifnoReasonfornotgrantingTpRforbothparent varchar(80);
    v_canchildreturntohome varchar(10);
    v_descriptionofreturnhome varchar(500);
    v_isuscitizen varchar(10);
    v_isqualifiedalien varchar(10);
    v_age varchar(10);
    v_isthechildresidinginafosterfamilyhome varchar(10);
    v_childspreviouslyadopted varchar(10);
    v_childsIvEStatusofpreviousadoption varchar(30);
    v_previousAdoptiveParentsTpRterminationDate timestamp;
    v_previousAdoptiveParentsDeathDateIfdead timestamp;
    v_childreceivingssiatremoval varchar(10);
    v_startdateofreceivingssi timestamp;
    v_minorparentivefostercarestatus varchar(40);
    v_dateoflatestpaymentofminorparentivefostercare timestamp;
    v_minorparentivefostercarestartdate timestamp;
    v_isafdceligibilitymet varchar(10);
    v_wasthechildremovedfromspecifiedrelative varchar(10);
    v_childdeprivedofparentalsupport varchar(10);
    v_isincomeassetsmet varchar(10);
    v_childremovaldate timestamp;
    v_removalcourtorderdate timestamp;
    v_voluntaryrelinquishment varchar(10);
    v_childapplicableassessmentdt timestamp;
    v_childapplicabilitystatus varchar(50);
    v_adoptionassistancestartdate timestamp;
    v_adoptionapplicabilitystartdt timestamp;
    v_adoptionapplicabilityminorparentinfo json;
    v_istheminorparentreceivingivefc varchar(10);
    v_insertedby varchar(50);
    v_updatedby varchar(50);
    v_isdocumentedphysicalandmentaldisability varchar(10);
    v_activeflag int;
    v_childagency varchar;
    v_casenumber varchar;
    v_adoptioncasenumber varchar;
    v_adoptioncaseid varchar;
    v_adoptionstartdate timestamp;
    v_createdate timestamp;
    v_ivestatus varchar;
    v_servicecaseid uuid;    
    v_bioclientid 	bigint;
       
BEGIN
    
	v_clientid := reqObj ->> 'clientId';
	v_countyofjurisdiction := reqObj ->> 'countyofjurisdiction';
	v_nameofchild := reqObj ->> 'nameofchild';
    v_dateofbirth := reqObj ->> 'dateofbirth';
    v_gender := reqObj ->> 'gender';
    v_nameofadoptiveparent1 := reqObj ->> 'nameofadoptiveparent1';
	v_nameofadoptiveparent2 := reqObj ->> 'nameofadoptiveparent2';
	v_provideridofadoptiveparent := reqObj ->> 'provideridofadoptiveparent';
	v_dateofadoptionfinalization := reqObj ->> 'dateofadoptionfinalization';
	v_singleparentadoptioncheck := reqObj ->> 'singleparentadoptioncheck';
    v_adoptionparent1signdate := reqObj ->> 'adoptionparent1signdate';
	v_adoptionparent2signdate := reqObj ->> 'adoptionparent2signdate';
	v_adoptionldssdate := reqObj ->> 'adoptionldssdate';
	v_adoptionpetitiondate := reqObj ->> 'adoptionpetitiondate';
	v_childmeetallmedicaldisabilityrequirementsforssi := reqObj ->> 'childmeetallmedicaldisabilityrequirementsforssi';
    v_child617yearsofage := reqObj ->> 'child617yearsofage';
    v_physicalmentalemotionaldisability := reqObj ->> 'physicalmentalemotionaldisability';
    v_emotionaldisturbance := reqObj ->> 'emotionaldisturbance';
    v_siblinginformationcheck := reqObj ->> 'siblinginformationcheck';
    v_siblinggroup := reqObj ->> 'siblinggroup';
    v_recognizedhighriskofphysicaldisability := reqObj ->> 'recognizedhighriskofphysicaldisability';
    v_raceethnicityofchild := reqObj ->> 'raceethnicityofchild';
    v_raceorethnicitywithoneofthesabove := reqObj ->> 'raceorethnicitywithoneofthesabove';
    v_effortstoplacechildweremade := reqObj ->> 'effortstoplacechildweremade';
    v_dtofdocforeffortstoplacewithoutasubsidy := reqObj ->> 'dtofdocforeffortstoplacewithoutasubsidy';
	v_exceptiongrantedinchildsbestinterests := reqObj ->> 'exceptiongrantedinchildsbestinterests';
    v_dtofdocumentationforexceptiongrantedinchildsbi := reqObj ->> 'dtofdocumentationforexceptiongrantedinchildsbi';
    v_isreasonforexceptionrecorded := reqObj ->> 'isreasonforexceptionrecorded';
    v_unsuccessfulreasonableeffortsstatusrecords := reqObj ->> 'unsuccessfulreasonableeffortsstatusrecords';
    v_tprGrantedtoBothParent := reqObj ->> 'tprGrantedtoBothParent';
    v_dateofTpRofParent1 := reqObj ->> 'dateofTpRofParent1';
    v_dateofTpRofParent2 := reqObj ->> 'dateofTpRofParent2';
    v_ifnoReasonfornotgrantingTpRforbothparent := reqObj ->> 'ifnoReasonfornotgrantingTpRforbothparent';
	v_canchildreturntohome := reqObj ->> 'canchildreturntohome';
	v_descriptionofreturnhome := reqObj ->> 'descriptionofreturnhome';
    v_isuscitizen := reqObj ->> 'isuscitizen';
	v_isqualifiedalien := reqObj ->> 'isqualifiedalien';
    v_age := reqObj ->> 'age';
    v_isthechildresidinginafosterfamilyhome := reqObj ->> 'isthechildresidinginafosterfamilyhome';
    v_childspreviouslyadopted := reqObj ->> 'childspreviouslyadopted';
    v_childsIvEStatusofpreviousadoption := reqObj ->> 'childsIvEStatusofpreviousadoption';
    v_previousAdoptiveParentsTpRterminationDate := reqObj ->> 'previousAdoptiveParentsTpRterminationDate';
    v_previousAdoptiveParentsDeathDateIfdead := reqObj ->> 'previousAdoptiveParentsDeathDateIfdead';
    v_childreceivingssiatremoval := reqObj ->> 'childreceivingssiatremoval';
    v_startdateofreceivingssi := reqObj ->> 'startdateofreceivingssi';
    v_minorparentivefostercarestatus := reqObj ->> 'minorparentivefostercarestatus';
    v_dateoflatestpaymentofminorparentivefostercare := reqObj ->> 'dateoflatestpaymentofminorparentivefostercare';
	v_minorparentivefostercarestartdate := reqObj ->> 'minorparentivefostercarestartdate';
    v_isafdceligibilitymet := reqObj ->> 'isafdceligibilitymet';
    v_wasthechildremovedfromspecifiedrelative := reqObj ->> 'wasthechildremovedfromspecifiedrelative';
    v_childdeprivedofparentalsupport := reqObj ->> 'childdeprivedofparentalsupport';
    v_isincomeassetsmet := reqObj ->> 'isincomeassetsmet';
    v_childremovaldate := reqObj ->> 'childremovaldate';
    v_removalcourtorderdate := reqObj ->> 'removalcourtorderdate';
	v_voluntaryrelinquishment := reqObj ->> 'voluntaryrelinquishment';
    v_childapplicableassessmentdt := reqObj ->> 'childapplicableassessmentdt';
    v_childapplicabilitystatus := reqObj ->> 'childapplicabilitystatus';
    v_adoptionassistancestartdate := reqObj ->> 'adoptionassistancestartdate';
    v_adoptionapplicabilitystartdt := reqObj ->> 'adoptionapplicabilitystartdt';
    v_adoptionapplicabilityminorparentinfo := reqObj ->> 'adoptionapplicabilityminorparentinfo';
    v_istheminorparentreceivingivefc := reqObj ->> 'istheminorparentreceivingivefc';
	v_insertedby := reqObj ->> 'insertedby';
    v_updatedby := reqObj ->> 'updatedby';
    v_isdocumentedphysicalandmentaldisability := reqObj ->> 'isdocumentedphysicalandmentaldisability';
	v_activeflag := reqObj ->> 'activeflag';
    v_childagency := reqObj ->> 'childagency';
    v_casenumber := reqObj ->> 'casenumber';
    v_adoptioncasenumber := reqObj ->> 'adoptioncasenumber';
    v_adoptioncaseid := reqObj ->> 'adoptioncaseid';
    v_adoptionstartdate := reqObj ->> 'adoptionstartdate';
    v_createdate := reqObj ->> 'createdate';
    v_ivestatus := reqObj ->> 'ivestatus';  
    v_servicecaseid := reqObj ->> 'servicecaseid';  
    v_bioclientid := reqObj ->> 'bioclientid';  
     
	returnStatus := 'Success';
	
	SELECT count(*) into v_num FROM adoptioninitialeligibilityinfo WHERE clientId = v_clientId;

	IF (v_num) >= 1
	THEN
	 	UPDATE adoptioninitialeligibilityinfo	
	
    SET 	
    
    clientId = v_clientId,
    countyofjurisdiction = v_countyofjurisdiction,
    nameofchild = v_nameofchild,
    dateofbirth = v_dateofbirth,
    gender = v_gender,
    nameofadoptiveparent1 = v_nameofadoptiveparent1,
    nameofadoptiveparent2 = v_nameofadoptiveparent2,
    provideridofadoptiveparent = v_provideridofadoptiveparent,
    dateofadoptionfinalization = v_dateofadoptionfinalization,
    singleparentadoptioncheck = v_singleparentadoptioncheck,
    adoptionparent1signdate = v_adoptionparent1signdate,
    adoptionparent2signdate = v_adoptionparent2signdate,
    adoptionldssdate = v_adoptionldssdate,
    adoptionpetitiondate = v_adoptionpetitiondate,
    childmeetallmedicaldisabilityrequirementsforssi = v_childmeetallmedicaldisabilityrequirementsforssi,
    child617yearsofage = v_child617yearsofage,
    physicalmentalemotionaldisability = v_physicalmentalemotionaldisability,
    emotionaldisturbance = v_emotionaldisturbance,
    siblinginformationcheck = v_siblinginformationcheck,
    siblinggroup = v_siblinggroup,
    recognizedhighriskofphysicaldisability = v_recognizedhighriskofphysicaldisability,
    raceethnicityofchild = v_raceethnicityofchild,
    raceorethnicitywithoneofthesabove = v_raceorethnicitywithoneofthesabove,
    effortstoplacechildweremade = v_effortstoplacechildweremade,
    dtofdocforeffortstoplacewithoutasubsidy = v_dtofdocforeffortstoplacewithoutasubsidy,
    exceptiongrantedinchildsbestinterests = v_exceptiongrantedinchildsbestinterests,
    dtofdocumentationforexceptiongrantedinchildsbi = v_dtofdocumentationforexceptiongrantedinchildsbi,
    isreasonforexceptionrecorded = v_isreasonforexceptionrecorded,
    unsuccessfulreasonableeffortsstatusrecords = v_unsuccessfulreasonableeffortsstatusrecords,
    tprGrantedtoBothParent = v_tprGrantedtoBothParent,
    dateofTpRofParent1 = v_dateofTpRofParent1,
    dateofTpRofParent2 = v_dateofTpRofParent2,
    ifnoReasonfornotgrantingTpRforbothparent  = v_ifnoReasonfornotgrantingTpRforbothparent,
    canchildreturntohome = v_canchildreturntohome,
    descriptionofreturnhome = v_descriptionofreturnhome,
    isuscitizen = v_isuscitizen,
    isqualifiedalien = v_isqualifiedalien,
    age = v_age ,
    isthechildresidinginafosterfamilyhome = v_isthechildresidinginafosterfamilyhome,
    childspreviouslyadopted = v_childspreviouslyadopted,
    childsIvEStatusofpreviousadoption = v_childsIvEStatusofpreviousadoption,
    previousAdoptiveParentsTpRterminationDate = v_previousAdoptiveParentsTpRterminationDate,
    previousAdoptiveParentsDeathDateIfdead = v_previousAdoptiveParentsDeathDateIfdead,
    childreceivingssiatremoval = v_childreceivingssiatremoval,
    startdateofreceivingssi = v_startdateofreceivingssi,
    minorparentivefostercarestatus = v_minorparentivefostercarestatus,
    dateoflatestpaymentofminorparentivefostercare = v_dateoflatestpaymentofminorparentivefostercare,
    minorparentivefostercarestartdate = v_minorparentivefostercarestartdate,
    isafdceligibilitymet = v_isafdceligibilitymet,
    wasthechildremovedfromspecifiedrelative = v_wasthechildremovedfromspecifiedrelative,
    childdeprivedofparentalsupport = v_childdeprivedofparentalsupport,
    isincomeassetsmet = v_isincomeassetsmet,
    childremovaldate = v_childremovaldate,
    removalcourtorderdate = v_removalcourtorderdate,
    voluntaryrelinquishment = v_voluntaryrelinquishment,
    childapplicableassessmentdt = v_childapplicableassessmentdt,
    childapplicabilitystatus = v_childapplicabilitystatus,
    adoptionassistancestartdate = v_adoptionassistancestartdate,
    adoptionapplicabilitystartdt = v_adoptionapplicabilitystartdt,
    adoptionapplicabilityminorparentinfo = v_adoptionapplicabilityminorparentinfo,
    istheminorparentreceivingivefc = v_istheminorparentreceivingivefc,
	insertedby = v_insertedby,
    updatedby = v_updatedby,
    isdocumentedphysicalandmentaldisability = v_isdocumentedphysicalandmentaldisability,
    activeflag = 1,
    childagency = v_childagency,
    casenumber = v_casenumber,
    adoptioncasenumber = v_adoptioncasenumber,
    adoptioncaseid = v_adoptioncaseid,
    adoptionstartdate = v_adoptionstartdate,
    createdate = v_createdate,
    ivestatus = v_ivestatus,
    servicecaseid = v_servicecaseid,
    bioclientid = v_bioclientid   	

    WHERE clientId = v_clientId;
	
else
       
     
Insert into adoptioninitialeligibilityinfo(adoptioninitialid, clientId, countyofjurisdiction, nameofchild, dateofbirth, gender, nameofadoptiveparent1, nameofadoptiveparent2, provideridofadoptiveparent, dateofadoptionfinalization, singleparentadoptioncheck, 
            adoptionparent1signdate, adoptionparent2signdate, adoptionldssdate,  adoptionpetitiondate, childmeetallmedicaldisabilityrequirementsforssi,   child617yearsofage,   physicalmentalemotionaldisability, emotionaldisturbance, siblinginformationcheck, 
            siblinggroup, recognizedhighriskofphysicaldisability, raceethnicityofchild,  raceorethnicitywithoneofthesabove, effortstoplacechildweremade, dtofdocforeffortstoplacewithoutasubsidy,  exceptiongrantedinchildsbestinterests,  dtofdocumentationforexceptiongrantedinchildsbi, 
            isreasonforexceptionrecorded, unsuccessfulreasonableeffortsstatusrecords, tprGrantedtoBothParent , dateofTpRofParent1, dateofTpRofParent2, ifnoReasonfornotgrantingTpRforbothparent, canchildreturntohome, descriptionofreturnhome, isuscitizen, isqualifiedalien, age, 
            isthechildresidinginafosterfamilyhome, childspreviouslyadopted , childsIvEStatusofpreviousadoption, previousAdoptiveParentsTpRterminationDate, previousAdoptiveParentsDeathDateIfdead, childreceivingssiatremoval, startdateofreceivingssi, minorparentivefostercarestatus, 
            dateoflatestpaymentofminorparentivefostercare, minorparentivefostercarestartdate, isafdceligibilitymet, wasthechildremovedfromspecifiedrelative, childdeprivedofparentalsupport, isincomeassetsmet, childremovaldate, removalcourtorderdate, voluntaryrelinquishment, 
            childapplicableassessmentdt, childapplicabilitystatus, adoptionassistancestartdate, adoptionapplicabilitystartdt, adoptionapplicabilityminorparentinfo, istheminorparentreceivingivefc, insertedby, updatedby, updatedon, isdocumentedphysicalandmentaldisability, activeflag, childagency,
            casenumber, adoptioncasenumber, adoptioncaseid, adoptionstartdate, createdate, ivestatus, servicecaseid, bioclientid)

VALUES(gen_random_uuid(), v_clientId, v_countyofjurisdiction, v_nameofchild, v_dateofbirth, v_gender, v_nameofadoptiveparent1, v_nameofadoptiveparent2, v_provideridofadoptiveparent, v_dateofadoptionfinalization, v_singleparentadoptioncheck, v_adoptionparent1signdate,  v_adoptionparent2signdate, 
        v_adoptionldssdate, v_adoptionpetitiondate, v_childmeetallmedicaldisabilityrequirementsforssi, v_child617yearsofage, v_physicalmentalemotionaldisability, v_emotionaldisturbance, v_siblinginformationcheck, v_siblinggroup, v_recognizedhighriskofphysicaldisability, v_raceethnicityofchild,
        v_raceorethnicitywithoneofthesabove, v_effortstoplacechildweremade, v_dtofdocforeffortstoplacewithoutasubsidy, v_exceptiongrantedinchildsbestinterests, v_dtofdocumentationforexceptiongrantedinchildsbi, v_isreasonforexceptionrecorded, v_unsuccessfulreasonableeffortsstatusrecords, 
        v_tprGrantedtoBothParent, v_dateofTpRofParent1, v_dateofTpRofParent2, v_ifnoReasonfornotgrantingTpRforbothparent, v_canchildreturntohome, v_descriptionofreturnhome, v_isuscitizen, v_isqualifiedalien, v_age, v_isthechildresidinginafosterfamilyhome, v_childspreviouslyadopted, 
        v_childsIvEStatusofpreviousadoption, v_previousAdoptiveParentsTpRterminationDate, v_previousAdoptiveParentsDeathDateIfdead, v_childreceivingssiatremoval, v_startdateofreceivingssi,  v_minorparentivefostercarestatus,  v_dateoflatestpaymentofminorparentivefostercare, v_minorparentivefostercarestartdate, 
        v_isafdceligibilitymet, v_wasthechildremovedfromspecifiedrelative, v_childdeprivedofparentalsupport, v_isincomeassetsmet, v_childremovaldate, v_removalcourtorderdate, v_voluntaryrelinquishment, v_childapplicableassessmentdt, v_childapplicabilitystatus, v_adoptionassistancestartdate, v_adoptionapplicabilitystartdt,
        v_adoptionapplicabilityminorparentinfo, v_istheminorparentreceivingivefc, v_insertedby,  v_updatedby, now(), v_isdocumentedphysicalandmentaldisability, 1, v_childagency, v_casenumber, v_adoptioncasenumber, v_adoptioncaseid, v_adoptionstartdate, v_createdate, v_ivestatus, v_servicecaseid, v_bioclientid);
           
           
	end if;

RETURN format('%s', returnStatus);

end;
	
$function$
