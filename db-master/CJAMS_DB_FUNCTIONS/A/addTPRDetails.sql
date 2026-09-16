DROP FUNCTION IF EXISTS cjams.addtprdetails(newtprdetails json, childintakeactorid uuid);
DROP FUNCTION IF EXISTS cjams.addtprdetails(newtprdetails json);
CREATE OR REPLACE FUNCTION cjams.addtprdetails(newtprdetails json)
 RETURNS uuid
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------------------------
--Revisions
--Surya Arigela 06/12/2026  - CIDM-11401: B-240648 Termination of Parental Rights
------------------------------------------------------------------------------------------                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          

declare 
   v_newtprdetails                      json;
   v_tprdetailsid						uuid;
   v_tprdetailsid2                      uuid;
   v_personid							uuid;
   v_intakeservicerequestactorid		uuid;
   v_date                               TIMESTAMP WITHOUT TIME ZONE;
   returnmsg                            CHARACTER VARYING;
   v_otherperson						boolean;
   v_otherperson1						boolean;
   v_intakeservicerequestactorid1	    uuid;
   v_childintakeactorid                 uuid;
   v_securityuserid 					uuid;
   v_randomuuid                         uuid;
   v_tprrecommendationid                uuid;
   v_parent1_unknown                    boolean;
   v_parent2_unknown                    boolean;
BEGIN

   v_date := now ();
   v_newtprdetails := newtprdetails;
  v_tprdetailsid := NULLIF(newtprdetails ->> 'tprdetailsid', '')::uuid;
  v_tprdetailsid2 := NULLIF(newtprdetails ->> 'tprdetailsid1', '')::uuid;
  raise notice 'input json intakeservicerequestactorid %',(newtprdetails ->>'intakeservicerequestactorid');
  v_securityuserid := (newtprdetails ->>'securityuserid')::uuid;
  v_parent2_unknown :=
    newtprdetails ->> 'intakeservicerequestactorid1' IN ('PARENT1', 'PARENT2', 'UNKNOWN');
  v_intakeservicerequestactorid1 :=
    CASE
        WHEN v_parent2_unknown THEN gen_random_uuid()
        WHEN NULLIF(newtprdetails ->> 'intakeservicerequestactorid1', '') IS NULL
            THEN NULL
        ELSE (newtprdetails ->> 'intakeservicerequestactorid1')::uuid
    END;
  v_childintakeactorid:= (newtprdetails ->> 'childintakeactorid')::uuid;
  v_tprrecommendationid := (newtprdetails ->> 'tprrecommendationid'):: uuid;

  IF v_parent2_unknown THEN
    INSERT INTO cjams.otherperson (
        personid,
        activeflag,
        objectid,
        firstname,
        lastname,
        middlename,
        objecttype,
        insertedby,
        insertedon,
        updatedby,
        updatedon
    )
    VALUES (
        v_intakeservicerequestactorid1,
        1,
        NULL,
        'Parent2',
        'Unknown',
        NULL,
        'PERMANENCYTPR',
        v_securityuserid,
        now(),
        v_securityuserid,
        now()
    );
END IF;

--       insert into otherperson (personid, firstname, lastname) values ( gen_random_uuid, v_person -> 'firstname', v_person -> 'lastname')
--      returning personid into v_personid
      
      returnmsg := 'inserting into tprdetails';
     v_otherperson := length(TRIM(newtprdetails ->>'intakeservicerequestactorid')) = 1;
    
	raise notice 'is not null:%', v_otherperson;

		raise notice 'v_otherperson1 is not null:%', v_otherperson1;
     
     if ( v_otherperson)
   	then
		returnmsg := returnmsg || ', inside otherperson';
   		insert into cjams.otherperson (activeflag, objectid, firstname, lastname, middlename, objecttype, insertedby, insertedon, updatedby, updatedon ) 
		values ( 1, v_tprdetailsid, 'Parent', newtprdetails ->>'intakeservicerequestactorid',newtprdetails ->>'otherpersonmiddlename', 'PERMANENCYTPR',  v_securityuserid, now(), v_securityuserid, now()) 
		returning personid into v_intakeservicerequestactorid ;
	else
		raise notice 'else part';
		v_parent1_unknown :=
    newtprdetails ->> 'intakeservicerequestactorid' IN ('PARENT1', 'PARENT2', 'UNKNOWN');
		v_intakeservicerequestactorid :=
    		CASE
       				 WHEN v_parent1_unknown THEN gen_random_uuid()
       				 WHEN NULLIF(newtprdetails ->> 'intakeservicerequestactorid', '') IS NULL
          				THEN NULL
       				 ELSE (newtprdetails ->> 'intakeservicerequestactorid')::uuid
    END;
	IF v_parent1_unknown THEN
    INSERT INTO cjams.otherperson (
        personid,
        activeflag,
        objectid,
        firstname,
        lastname,
        middlename,
        objecttype,
        insertedby,
        insertedon,
        updatedby,
        updatedon
    )
    VALUES (
        v_intakeservicerequestactorid,
        1,
        NULL,
        'Parent1',
        'Unknown',
        NULL,
        'PERMANENCYTPR',
        v_securityuserid,
        now(),
        v_securityuserid,
        now()
    );
END IF;
	end if;
   

	select gen_random_uuid() into v_randomuuid; 

	if(v_tprrecommendationid is null) then
	    v_tprrecommendationid = v_randomuuid;
	end if;

	if(v_childintakeactorid is not null) then

	 raise notice 'insert into tprrecommendation %',v_randomuuid;
	           INSERT INTO cjams.tprrecommendation
                     (tprrecommendationid, intakeservicerequestactorid, intakeserviceid, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, servicecaseid)
                VALUES(v_randomuuid, v_childintakeactorid, NULL, 1, v_securityuserid, now(), v_securityuserid, now(), now(), uuid(newtprdetails ->>'servicecaseid'));
	end if;

IF v_intakeservicerequestactorid1 IS NOT NULL THEN

    RAISE NOTICE 'v_intakeservicerequestactorid1: %', v_intakeservicerequestactorid1;
    RAISE NOTICE 'v_tprdetailsid2: %', v_tprdetailsid2;

    IF v_tprdetailsid2 IS NOT NULL THEN

        UPDATE cjams.tprdetails
        SET
            intakeserviceid = NULLIF(newtprdetails ->> 'intakeserviceid1', '')::uuid,
            tprrecommendationid = v_tprrecommendationid,
            serveddate = NULLIF(newtprdetails ->> 'serveddate1', '')::timestamp,
            servicetypekey = newtprdetails ->> 'servicetypekey1',
            terminationtypekey = newtprdetails ->> 'terminationtypekey1',
            isappealed = NULLIF(newtprdetails ->> 'isappealed1', '')::int,
            isdssappealed = NULLIF(newtprdetails ->> 'isdssappealed1', '')::int,
            appealdate = NULLIF(newtprdetails ->> 'appealdate1', '')::timestamp,
            appealdecisiontypekey = newtprdetails ->> 'appealdecisiontypekey1',
            decisiondate = NULLIF(newtprdetails ->> 'decisiondate1', '')::timestamp,
            reason = newtprdetails ->> 'reason1',
            servicecaseid = NULLIF(newtprdetails ->> 'servicecaseid', '')::uuid,
            isdenied = NULLIF(newtprdetails ->> 'isdenied1', '')::boolean,
            isgranted = NULLIF(newtprdetails ->> 'isgranted1', '')::boolean,
            tprdecisiondate = NULLIF(newtprdetails ->> 'tprdecisiondate1', '')::timestamp,
            relationshiptypekey = newtprdetails ->> 'relationshiptypekey1',
            tprpetitiondate = NULLIF(newtprdetails ->> 'tprpetitiondate1', '')::timestamp,
            iscontested = NULLIF(newtprdetails ->> 'iscontested1', '')::boolean,
            updatedby = v_securityuserid,
            updatedon = now()
        WHERE tprdetailsid = v_tprdetailsid2;

        RAISE NOTICE 'Updated Parent2 TPR details: %', v_tprdetailsid2;

    ELSE

        INSERT INTO cjams.tprdetails (
            intakeserviceid,
            tprrecommendationid,
            intakeservreqcourtorderid,
            intakeservicerequestactorid,
            serveddate,
            servicetypekey,
            terminationtypekey,
            isappealed,
            isdssappealed,
            appealdate,
            appealdecisiontypekey,
            decisiondate,
            reason,
            activeflag,
            insertedby,
            insertedon,
            updatedby,
            updatedon,
            effectivedate,
            expirationdate,
            old_id,
            servicecaseid,
            isdenied,
            isgranted,
            tprdecisiondate,
            etl_userid,
            etl_load_date,
            relationshiptypekey,
            singleparent,
            tprpetitiondate,
            iscontested
        )
        VALUES (
            NULLIF(newtprdetails ->> 'intakeserviceid1', '')::uuid,
            v_tprrecommendationid,
            NULLIF(newtprdetails ->> 'intakeservreqcourtorderid1', '')::uuid,
            v_intakeservicerequestactorid1,
            NULLIF(newtprdetails ->> 'serveddate1', '')::timestamp,
            newtprdetails ->> 'servicetypekey1',
            newtprdetails ->> 'terminationtypekey1',
            NULLIF(newtprdetails ->> 'isappealed1', '')::int,
            NULLIF(newtprdetails ->> 'isdssappealed1', '')::int,
            NULLIF(newtprdetails ->> 'appealdate1', '')::timestamp,
            newtprdetails ->> 'appealdecisiontypekey1',
            NULLIF(newtprdetails ->> 'decisiondate1', '')::timestamp,
            newtprdetails ->> 'reason1',
            1,
            v_securityuserid,
            now(),
            v_securityuserid,
            now(),
            now(),
            NULL,
            NULL,
            NULLIF(newtprdetails ->> 'servicecaseid', '')::uuid,
            NULLIF(newtprdetails ->> 'isdenied1', '')::boolean,
            NULLIF(newtprdetails ->> 'isgranted1', '')::boolean,
            NULLIF(newtprdetails ->> 'tprdecisiondate1', '')::timestamp,
            NULL,
            NULL,
            newtprdetails ->> 'relationshiptypekey1',
            NULL,
            NULLIF(newtprdetails ->> 'tprpetitiondate1', '')::timestamp,
            NULLIF(newtprdetails ->> 'iscontested1', '')::boolean
        )
        RETURNING tprdetailsid INTO v_tprdetailsid2;

        RAISE NOTICE 'Inserted Parent2 TPR details: %', v_tprdetailsid2;

    END IF;

END IF;

	
    RAISE NOTICE 'v_intakeservicerequestactorid: %', v_intakeservicerequestactorid;
RAISE NOTICE 'v_tprdetailsid: %', v_tprdetailsid;

IF v_tprdetailsid IS NOT NULL THEN

    UPDATE cjams.tprdetails
    SET
        tprrecommendationid = v_tprrecommendationid,
        serveddate = NULLIF(newtprdetails ->> 'serveddate', '')::timestamp,
        servicetypekey = newtprdetails ->> 'servicetypekey',
        terminationtypekey = newtprdetails ->> 'terminationtypekey',
        isappealed = NULLIF(newtprdetails ->> 'isappealed', '')::int,
        isdssappealed = NULLIF(newtprdetails ->> 'isdssappealed', '')::int,
        appealdate = NULLIF(newtprdetails ->> 'appealdate', '')::timestamp,
        appealdecisiontypekey = newtprdetails ->> 'appealdecisiontypekey',
        decisiondate = NULLIF(newtprdetails ->> 'decisiondate', '')::timestamp,
        reason = newtprdetails ->> 'reason',
        servicecaseid = NULLIF(newtprdetails ->> 'servicecaseid', '')::uuid,
        isdenied = NULLIF(newtprdetails ->> 'isdenied', '')::boolean,
        isgranted = NULLIF(newtprdetails ->> 'isgranted', '')::boolean,
        tprdecisiondate = NULLIF(newtprdetails ->> 'tprdecisiondate', '')::timestamp,
        relationshiptypekey = newtprdetails ->> 'relationshiptypekey',
        tprpetitiondate = NULLIF(newtprdetails ->> 'tprpetitiondate', '')::timestamp,
        iscontested = NULLIF(newtprdetails ->> 'iscontested', '')::boolean,
        updatedby = v_securityuserid,
        updatedon = now()
    WHERE tprdetailsid = v_tprdetailsid;

    RAISE NOTICE 'Updated Parent1 TPR details: %', v_tprdetailsid;

ELSE

    INSERT INTO cjams.tprdetails (
        intakeserviceid,
        tprrecommendationid,
        intakeservreqcourtorderid,
        intakeservicerequestactorid,
        serveddate,
        servicetypekey,
        terminationtypekey,
        isappealed,
        isdssappealed,
        appealdate,
        appealdecisiontypekey,
        decisiondate,
        reason,
        activeflag,
        insertedby,
        insertedon,
        updatedby,
        updatedon,
        effectivedate,
        expirationdate,
        old_id,
        servicecaseid,
        isdenied,
        isgranted,
        tprdecisiondate,
        etl_userid,
        etl_load_date,
        relationshiptypekey,
        singleparent,
        tprpetitiondate,
        iscontested
    )
    VALUES (
        NULLIF(newtprdetails ->> 'intakeserviceid', '')::uuid,
        v_tprrecommendationid,
        NULLIF(newtprdetails ->> 'intakeservreqcourtorderid', '')::uuid,
        v_intakeservicerequestactorid,
        NULLIF(newtprdetails ->> 'serveddate', '')::timestamp,
        newtprdetails ->> 'servicetypekey',
        newtprdetails ->> 'terminationtypekey',
        NULLIF(newtprdetails ->> 'isappealed', '')::int,
        NULLIF(newtprdetails ->> 'isdssappealed', '')::int,
        NULLIF(newtprdetails ->> 'appealdate', '')::timestamp,
        newtprdetails ->> 'appealdecisiontypekey',
        NULLIF(newtprdetails ->> 'decisiondate', '')::timestamp,
        newtprdetails ->> 'reason',
        1,
        v_securityuserid,
        now(),
        v_securityuserid,
        now(),
        now(),
        NULL,
        NULL,
        NULLIF(newtprdetails ->> 'servicecaseid', '')::uuid,
        NULLIF(newtprdetails ->> 'isdenied', '')::boolean,
        NULLIF(newtprdetails ->> 'isgranted', '')::boolean,
        NULLIF(newtprdetails ->> 'tprdecisiondate', '')::timestamp,
        NULL,
        NULL,
        newtprdetails ->> 'relationshiptypekey',
        NULL,
        NULLIF(newtprdetails ->> 'tprpetitiondate', '')::timestamp,
        NULLIF(newtprdetails ->> 'iscontested', '')::boolean
    )
    RETURNING tprdetailsid INTO v_tprdetailsid;

    RAISE NOTICE 'Inserted Parent1 TPR details: %', v_tprdetailsid;

END IF;
	
	

	
	returnmsg := returnmsg || ' completed';
	raise notice 'returnmesg %', returnmsg;
      
RETURN v_tprdetailsid;
END;

$function$
;
