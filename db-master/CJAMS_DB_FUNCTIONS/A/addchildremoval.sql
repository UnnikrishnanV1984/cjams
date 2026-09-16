CREATE OR REPLACE FUNCTION cjams.addchildremoval(obj json, v_userid uuid)
 RETURNS JSON
 LANGUAGE plpgsql
AS $function$ 
------------------------------------------------------------------------
-- Revision(s)
 --07/22/2025-- Umasankar Raavi- Added column 'showcontactpage' to track save from GoTo Contact button
 -------------------------------------------------------------------------------------
 
DECLARE 
l_generatedIntakeservreqchildremovalid uuid;
l_persondisability json;
i json; 
v_result json;


BEGIN

l_generatedIntakeservreqchildremovalid := (obj ->> 'intakeservreqchildremovalid'):: uuid;

IF (l_generatedIntakeservreqchildremovalid is null) THEN ---- new intakeservreqchildremoval

l_generatedIntakeservreqchildremovalid := gen_random_uuid();
l_persondisability := (obj ->> 'persondisability')::json;

insert into cjams.intakeservreqchildremoval (
    intakeservreqchildremovalid,
    intakeserviceid,
    assessmentid,
    intakeservicerequestactorid,
    personid,
    rmvdfrmisractorid,
    agencytypekey,
    fathername,
    mothername,
    rmvdfrmpersonname,
    removalreasontypeid,
    removaladd1,
    removaladd2,
    removalzip,
    removalstatecd,
    removalcity,
    removaldate,
    removaltime,
    familystructuretypekey,
    primarycaregiverid,
    vpabegindate,
    parent1id,
    vpaparentssigneddate,
    agencysigneddate,
    isbothparentssigned,
    reasonableeffortsmade,
    childfactorsentry,
    removaltypekey,
    environmentatremovalkey,
    removalid,
    primarycaregiveractorid,
    seccaregiveractorid,
    seccaregiveradd,
    primarycaregiveradd,
    volrelinquishment,
    isverifiedreporteradd,
    isverifiedcaregiver1add,
    isverifiedcaregiver2add,
    relativeactorid,
    isdisability,
    servicecaseid,
    vpaenddate,
    vpayouthsigneddate,
    parent2id,
    guardianid,
    parent2signeddate,
    vpaguardiansigneddate,
    comments,
    specifiedrelativedatechildlastlivedwith,
    specifiedrelativename,
    parent2comments,
    returndate,
    returntime,
    activeflag,
    insertedby,
    insertedon,
    updatedby,
    updatedon,
    ischildaddressasprimaryaddress,
    childphysicalremovaladdress,
    ischildphysicalremovaladdressverified,
    isuploadedmanually,
    isshelterauthcompleted,
    exitdate,
    returntransts,
    removalexitreason,
    showcontactpage
    ) values (
    l_generatedIntakeservreqchildremovalid,
    (obj ->> 'intakeserviceid'):: uuid,
    (obj ->> 'assessmentid'):: uuid,
    (obj ->> 'intakeservicerequestactorid')::uuid,
    (obj ->> 'personid'):: uuid,
    (obj ->> 'rmvdfrmisractorid'):: uuid,
    obj ->> 'agencytypekey',
    obj ->> 'fathername',
    obj ->> 'mothername',
    obj ->> 'rmvdfrmpersonname',
    (obj ->> 'removalreasontypeid'):: uuid,
    obj ->> 'removaladd1',
    obj ->> 'removaladd2',
    obj ->> 'removalzip',
    obj ->> 'removalstatecd',
    obj ->> 'removalcity',
    (obj ->> 'removaldate'):: timestamp without time zone,
    (obj ->> 'removaltime'):: timestamp without time zone,
    obj ->> 'familystructuretypekey',
    (obj ->> 'primarycaregiverid'):: integer,
    (obj ->> 'vpabegindate') :: date,
    (obj ->> 'parent1id'):: bigint,
    (obj ->> 'vpaparentssigneddate'):: date,
    (obj ->> 'agencysigneddate'):: date,
    (obj ->> 'isbothparentssigned'):: integer,
    obj ->> 'reasonableeffortsmade',
    obj ->> 'childfactorsentry',
    obj ->> 'removaltypekey',
     obj ->> 'environmentatremovalkey',
    (obj ->> 'removalid'):: bigint,
    (obj ->> 'primarycaregiveractorid') ::uuid,
    (obj ->> 'seccaregiveractorid'):: uuid,
    obj ->> 'seccaregiveradd',
    obj ->> 'primarycaregiveradd',
    (obj ->> 'volrelinquishment'):: integer,
    (obj ->> 'isverifiedreporteradd'):: integer,
    (obj ->> 'isverifiedcaregiver1add'):: integer,
    (obj ->> 'isverifiedcaregiver2add'):: integer,
    (obj ->> 'relativeactorid'):: uuid,
    (obj ->> 'isdisability'):: integer,
    (obj ->> 'servicecaseid'):: uuid,
    (obj ->> 'vpaenddate'):: timestamp without time zone,
    (obj ->> 'vpayouthsigneddate'):: date,
    (obj ->> 'parent2id'):: bigint,
    (obj ->> 'guardianid'):: bigint,
    (obj ->> 'parent2signeddate'):: date,
    (obj ->> 'vpaguardiansigneddate'):: date,
    obj ->> 'comments',
    (obj ->> 'specifiedrelativedatechildlastlivedwith'):: date,
    obj ->> 'specifiedrelativename',
    obj ->> 'parent2comments',
    (obj ->> 'returndate'):: timestamp without time zone,
    (obj ->> 'returntime'):: timestamp without time zone,
    1,
    v_userid,
    now(),
    v_userid,
    now(),
    (obj ->> 'ischildaddressasprimaryaddress'):: integer,
    obj ->> 'childphysicalremovaladdress',
    (obj ->> 'ischildphysicalremovaladdressverified'):: integer,
    (obj ->> 'isuploadedmanually'):: integer,
    (obj ->> 'isshelterauthcompleted'):: integer,
    (obj ->> 'exitdate') :: timestamp without time zone,
    (obj ->> 'returntransts'):: date,
    obj ->> 'removalexitreason',
    obj ->> 'showcontactpage'
    );

    -- add or update person disabilities

    IF (l_persondisability is not null) then 

    IF ((l_persondisability ->> 'personid') is not null) THEN

    IF (select count(*) from  cjams.persondisability where personid = (l_persondisability ->> 'personid'):: uuid) > 0 THEN

    UPDATE cjams.persondisability SET 
    disabilityconditiontypekey = (l_persondisability ->> 'disabilityconditiontypekey'),
    diagnoiseddisabilitynotes = (l_persondisability ->> 'diagnoiseddisabilitynotes'),
    startdate = (l_persondisability ->> 'startdate'),
    enddate = (l_persondisability ->> 'enddate'),
    evaluationdate = (l_persondisability ->> 'evaluationdate'),
    disabilityflag = (l_persondisability ->> 'disabilityflag'),
    evaluatorname = (l_persondisability ->> 'evaluatorname'),
    disabilitytypekey = (l_persondisability ->> 'disabilitytypekey'),
    comments = (l_persondisability ->> 'comments'),
    updatedby = v_userid,
    updatedon = now()

    where personid = (l_persondisability ->> 'personid'):: uuid;

    ELSE

    insert into  cjams.persondisability (
        persondisabilityid, personid, disabilityconditiontypekey,diagnoiseddisabilitynotes, startdate, enddate,
        evaluationdate, disabilityflag, evaluatorname, disabilitytypekey, comments, activeflag, insertedby,insertedon,updatedby, updatedon
    ) values (gen_random_uuid(), (l_persondisability ->> 'personid'):: uuid,l_persondisability ->> 'disabilityconditiontypekey', l_persondisability ->> 'diagnoiseddisabilitynotes',
        l_persondisability ->> 'startdate', l_persondisability ->> 'enddate', l_persondisability ->> 'evaluationdate', l_persondisability ->> 'disabilityflag', l_persondisability ->> 'evaluatorname',
        l_persondisability ->> 'disabilitytypekey', l_persondisability ->> 'comments',1, v_userid, now(), v_userid, now()
    );

    END IF;

    END IF;

    END IF;

    -- removalreason

    FOR  i  in  Select  *  from  json_array_elements((obj->>'removalreason')::json)                                                   
         LOOP

        insert into cjams.Intakeservreqchildremovalreason (intakeservreqchildremovalreasonid, intakeservreqchildremovalid, removalreasontypekey, inputtypekey, activeflag, insertedby, insertedon, updatedby, updatedon) 
        values(gen_random_uuid(), l_generatedIntakeservreqchildremovalid, i ->> 'removalreasontypekey', 'CHFE', 1, v_userid, now(), v_userid, now());


         END  LOOP;

    -- care giver reason

    FOR  i  in  Select  *  from  json_array_elements((obj->>'caregiverreason')::json)                                                   
         LOOP

        insert into cjams.Intakeservreqchildremovalreason (intakeservreqchildremovalreasonid, intakeservreqchildremovalid, removalreasontypekey, inputtypekey, activeflag, insertedby, insertedon, updatedby, updatedon) 
        values(gen_random_uuid(), l_generatedIntakeservreqchildremovalid, i ->> 'reasontypekey', 'CGFE', 1, v_userid, now(), v_userid, now());


         END  LOOP;
    
    -- reasonable efforts

    FOR  i  in  Select  *  from  json_array_elements((obj->>'reasonableefforts')::json)                                                   
         LOOP

        insert into cjams.Intakeservreqchildremovalreason (intakeservreqchildremovalreasonid, intakeservreqchildremovalid, removalreasontypekey, otherdescription, inputtypekey, activeflag, insertedby, insertedon, updatedby, updatedon) 
        values(gen_random_uuid(), l_generatedIntakeservreqchildremovalid, i ->> 'reasontypekey', i ->> 'otherdescription','REPCR', 1, v_userid, now(), v_userid, now());


         END  LOOP;

    -- not making efforts

    FOR  i  in  Select  *  from  json_array_elements((obj->>'notmakingefforts')::json)                                                   
         LOOP

        insert into cjams.Intakeservreqchildremovalreason (intakeservreqchildremovalreasonid, intakeservreqchildremovalid, removalreasontypekey, inputtypekey, activeflag, insertedby, insertedon, updatedby, updatedon) 
        values(gen_random_uuid(), l_generatedIntakeservreqchildremovalid, i ->> 'reasontypekey', 'RNME', 1, v_userid, now(), v_userid, now());


         END  LOOP;
    
    -- exit reason

    FOR  i  in  Select  *  from  json_array_elements((obj->>'exitreason')::json)                                                   
         LOOP

        insert into cjams.Intakeservreqchildremovalreason (intakeservreqchildremovalreasonid, intakeservreqchildremovalid, removalreasontypekey, inputtypekey, activeflag, insertedby, insertedon, updatedby, updatedon) 
        values(gen_random_uuid(), l_generatedIntakeservreqchildremovalid, i ->> 'reasontypekey', 'ECR', 1, v_userid, now(), v_userid, now());


         END  LOOP;
    
    ELSE -- existing intakeservreqchildremoval

    l_persondisability := (obj ->> 'persondisability')::json;

    UPDATE cjams.intakeservreqchildremoval SET
    
    intakeserviceid = (obj ->> 'intakeserviceid'):: uuid,
    assessmentid = (obj ->> 'assessmentid'):: uuid,
    intakeservicerequestactorid = (obj ->> 'intakeservicerequestactorid')::uuid,
    personid = (obj ->> 'personid'):: uuid,
    rmvdfrmisractorid = (obj ->> 'rmvdfrmisractorid'):: uuid,
    agencytypekey = obj ->> 'agencytypekey',
    fathername = obj ->> 'fathername',
    mothername = obj ->> 'mothername',
    rmvdfrmpersonname = obj ->> 'rmvdfrmpersonname',
    removalreasontypeid = (obj ->> 'removalreasontypeid'):: uuid,
    removaladd1 = obj ->> 'removaladd1',
    removaladd2 = obj ->> 'removaladd2',
    removalzip = obj ->> 'removalzip',
    removalstatecd = obj ->> 'removalstatecd',
    removalcity = obj ->> 'removalcity',
    removaldate = (obj ->> 'removaldate'):: timestamp without time zone,
    removaltime = (obj ->> 'removaltime'):: timestamp without time zone,
    familystructuretypekey = obj ->> 'familystructuretypekey',
    primarycaregiverid = (obj ->> 'primarycaregiverid'):: integer,
    vpabegindate = (obj ->> 'vpabegindate') :: date,
    parent1id = (obj ->> 'parent1id'):: bigint,
    vpaparentssigneddate = (obj ->> 'vpaparentssigneddate'):: date,
    agencysigneddate = (obj ->> 'agencysigneddate'):: date,
    isbothparentssigned = (obj ->> 'isbothparentssigned'):: integer,
    reasonableeffortsmade = obj ->> 'reasonableeffortsmade',
    childfactorsentry = obj ->> 'childfactorsentry',
    removaltypekey = obj ->> 'removaltypekey',
    environmentatremovalkey = obj ->> 'environmentatremovalkey',
    removalid = (obj ->> 'removalid'):: bigint,
    primarycaregiveractorid = (obj ->> 'primarycaregiveractorid') ::uuid,
    seccaregiveractorid = (obj ->> 'seccaregiveractorid'):: uuid,
    seccaregiveradd = obj ->> 'seccaregiveradd',
    primarycaregiveradd = obj ->> 'primarycaregiveradd',
    volrelinquishment = (obj ->> 'volrelinquishment'):: integer,
    isverifiedreporteradd = (obj ->> 'isverifiedreporteradd'):: integer,
    isverifiedcaregiver1add = (obj ->> 'isverifiedcaregiver1add'):: integer,
    isverifiedcaregiver2add = (obj ->> 'isverifiedcaregiver2add'):: integer,
    relativeactorid = (obj ->> 'relativeactorid'):: uuid,
    isdisability = (obj ->> 'isdisability'):: integer,
    servicecaseid = (obj ->> 'servicecaseid'):: uuid,
    vpaenddate = (obj ->> 'vpaenddate'):: timestamp without time zone,
    vpayouthsigneddate = (obj ->> 'vpayouthsigneddate'):: date,
    parent2id = (obj ->> 'parent2id'):: bigint,
    guardianid = (obj ->> 'guardianid'):: bigint,
    parent2signeddate = (obj ->> 'parent2signeddate'):: date,
    vpaguardiansigneddate = (obj ->> 'vpaguardiansigneddate'):: date,
    comments = obj ->> 'comments',
    specifiedrelativedatechildlastlivedwith = (obj ->> 'specifiedrelativedatechildlastlivedwith'):: date,
    specifiedrelativename = obj ->> 'specifiedrelativename',
    parent2comments = obj ->> 'parent2comments',
    returndate = (obj ->> 'returndate'):: timestamp without time zone,
    returntime = (obj ->> 'returntime'):: timestamp without time zone,
    activeflag = 1,
    updatedby = v_userid,
    updatedon = now(),
    ischildaddressasprimaryaddress = (obj ->> 'ischildaddressasprimaryaddress'):: integer,
    childphysicalremovaladdress = obj ->> 'childphysicalremovaladdress',
    ischildphysicalremovaladdressverified = (obj ->> 'ischildphysicalremovaladdressverified'):: integer,
    isuploadedmanually = (obj ->> 'isuploadedmanually'):: integer,
    isshelterauthcompleted = (obj ->> 'isshelterauthcompleted'):: integer,
    exitdate = (obj ->> 'exitdate') :: timestamp without time zone,
    returntransts = (CASE WHEN ((obj ->> 'exitdate')::timestamp without time zone) IS NOT NULL THEN (now())::date ELSE (obj ->> 'returntransts'):: date END),
    removalexitreason = obj ->> 'removalexitreason',
    showcontactpage = obj ->>'showcontactpage'

    WHERE intakeservreqchildremovalid = l_generatedIntakeservreqchildremovalid;

        -- add or update person disabilities

    IF (l_persondisability is not null) then 

    IF ((l_persondisability ->> 'personid') is not null) THEN

    IF (select count(*) from  cjams.persondisability where personid = (l_persondisability ->> 'personid'):: uuid) > 0 THEN

    UPDATE cjams.persondisability SET 
    disabilityconditiontypekey = (l_persondisability ->> 'disabilityconditiontypekey'),
    diagnoiseddisabilitynotes = (l_persondisability ->> 'diagnoiseddisabilitynotes'),
    startdate = (l_persondisability ->> 'startdate'),
    enddate = (l_persondisability ->> 'enddate'),
    evaluationdate = (l_persondisability ->> 'evaluationdate'),
    disabilityflag = (l_persondisability ->> 'disabilityflag'),
    evaluatorname = (l_persondisability ->> 'evaluatorname'),
    disabilitytypekey = (l_persondisability ->> 'disabilitytypekey'),
    comments = (l_persondisability ->> 'comments'),
    updatedby = v_userid,
    updatedon = now()

    where personid = (l_persondisability ->> 'personid'):: uuid;

    ELSE

    insert into  cjams.persondisability (
        persondisabilityid, personid, disabilityconditiontypekey,diagnoiseddisabilitynotes, startdate, enddate,
        evaluationdate, disabilityflag, evaluatorname, disabilitytypekey, comments, activeflag, insertedby,insertedon,updatedby, updatedon
    ) values (gen_random_uuid(), (l_persondisability ->> 'personid'):: uuid,l_persondisability ->> 'disabilityconditiontypekey', l_persondisability ->> 'diagnoiseddisabilitynotes',
        l_persondisability ->> 'startdate', l_persondisability ->> 'enddate', l_persondisability ->> 'evaluationdate', l_persondisability ->> 'disabilityflag', l_persondisability ->> 'evaluatorname',
        l_persondisability ->> 'disabilitytypekey', l_persondisability ->> 'comments',1, v_userid, now(), v_userid, now()
    );

    END IF;

    END IF;

    END IF;

    -- case plan 

    update cjams.caseplan1 set activeflag =0, updatedon= now(),updatedby=v_userid WHERE  caseid = l_generatedIntakeservreqchildremovalid;

    -- old child removal reasons

    update cjams.intakeservreqchildremovalreason set activeflag =0 WHERE  intakeservreqchildremovalid = l_generatedIntakeservreqchildremovalid;
    
    -- removalreason

    FOR  i  in  Select  *  from  json_array_elements((obj->>'removalreason')::json)                                                   
         LOOP

        insert into cjams.Intakeservreqchildremovalreason (intakeservreqchildremovalreasonid, intakeservreqchildremovalid, removalreasontypekey, inputtypekey, activeflag, insertedby, insertedon, updatedby, updatedon) 
        values(gen_random_uuid(), l_generatedIntakeservreqchildremovalid, i ->> 'removalreasontypekey', 'CHFE', 1, v_userid, now(), v_userid, now());


         END  LOOP;

    -- care giver reason

    FOR  i  in  Select  *  from  json_array_elements((obj->>'caregiverreason')::json)                                                   
         LOOP

        insert into cjams.Intakeservreqchildremovalreason (intakeservreqchildremovalreasonid, intakeservreqchildremovalid, removalreasontypekey, inputtypekey, activeflag, insertedby, insertedon, updatedby, updatedon) 
        values(gen_random_uuid(), l_generatedIntakeservreqchildremovalid, i ->> 'reasontypekey', 'CGFE', 1, v_userid, now(), v_userid, now());


         END  LOOP;
    
    -- reasonable efforts

    FOR  i  in  Select  *  from  json_array_elements((obj->>'reasonableefforts')::json)                                                   
         LOOP

        insert into cjams.Intakeservreqchildremovalreason (intakeservreqchildremovalreasonid, intakeservreqchildremovalid, removalreasontypekey, otherdescription, inputtypekey, activeflag, insertedby, insertedon, updatedby, updatedon) 
        values(gen_random_uuid(), l_generatedIntakeservreqchildremovalid, i ->> 'reasontypekey', i ->> 'otherdescription','REPCR', 1, v_userid, now(), v_userid, now());


         END  LOOP;

    -- not making efforts

    FOR  i  in  Select  *  from  json_array_elements((obj->>'notmakingefforts')::json)                                                   
         LOOP

        insert into cjams.Intakeservreqchildremovalreason (intakeservreqchildremovalreasonid, intakeservreqchildremovalid, removalreasontypekey, inputtypekey, activeflag, insertedby, insertedon, updatedby, updatedon) 
        values(gen_random_uuid(), l_generatedIntakeservreqchildremovalid, i ->> 'reasontypekey', 'RNME', 1, v_userid, now(), v_userid, now());


         END  LOOP;
    
    -- exit reason

    FOR  i  in  Select  *  from  json_array_elements((obj->>'exitreason')::json)                                                   
         LOOP

        insert into cjams.Intakeservreqchildremovalreason (intakeservreqchildremovalreasonid, intakeservreqchildremovalid, removalreasontypekey, inputtypekey, activeflag, insertedby, insertedon, updatedby, updatedon) 
        values(gen_random_uuid(), l_generatedIntakeservreqchildremovalid, i ->> 'reasontypekey', 'ECR', 1, v_userid, now(), v_userid, now());


         END  LOOP;

    END IF; -- end existing intakeservreqchildremoval

    SELECT json_agg(pe) into v_result FROM 
		(
		select * from cjams.intakeservreqchildremoval where intakeservreqchildremovalid = l_generatedIntakeservreqchildremovalid and activeflag = 1    
			
		) pe;

RETURN v_result;

END;

$function$
;