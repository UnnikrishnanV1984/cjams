DROP FUNCTION IF EXISTS cjams.getallpersonrelationbyprovidedpersonid(v_objectid CHARACTER VARYING, v_personid character varying,varchar, int4, int4) ;
DROP FUNCTION IF EXISTS cjams.getallpersonrelationbyprovidedpersonid( character varying,  character varying,  integer, character varying );
DROP FUNCTION IF EXISTS cjams.getallpersonrelationbyprovidedpersonid( character varying,  character varying);
DROP FUNCTION IF EXISTS cjams.getallpersonrelationbyprovidedpersonid( character varying, character varying, integer , character varying, integer);
DROP FUNCTION IF EXISTS cjams.getallpersonrelationbyprovidedpersonid( character varying, character varying, integer, integer);
CREATE OR REPLACE FUNCTION cjams.getallpersonrelationbyprovidedpersonid(v_objectid character varying, v_personid character varying, v_isExpungementSuperUser integer DEFAULT 0 , isexpunged integer DEFAULT 0::integer)
 RETURNS json
 LANGUAGE plpgsql
AS $function$
 
  DECLARE                    
v_relationships json ;
v_uuidornot character varying(50);
 v_isexpunged integer;

 BEGIN                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
                   
  SELECT * into v_uuidornot from uuid_or_null(v_objectid);
  v_isexpunged = 0;
  IF v_isExpungementSuperUser = 1 THEN
    v_isexpunged = isexpunged;
  END IF;

  IF v_isexpunged = 1 THEN 

      SELECT json_agg(a) INTO v_relationships FROM (
        SELECT
        DISTINCT
        p.personid,
        ar.actorrelationshipid,
        ar.caregiverflag,
        ar.intakeservicerequestactorid,
        ar.relationshiptypekey,
        COALESCE(rt.description,'Unknown') relation,
        ar.intakeserviceid,p.firstname,
        p.lastname,
        p.userphoto,
        p.dob,
        p.gendertypekey,
        (CASE WHEN EXTRACT(YEAR FROM age(now(), p.dob)) <= 0 THEN
        CASE WHEN EXTRACT(MONTH FROM age(now(), p.dob)) <= 0 THEN
        CONCAT (EXTRACT(DAY FROM age(now(), p.dob)) :: CHARACTER varying, ' ', 'Day(s)')
        ELSE CONCAT (EXTRACT(MONTH FROM age(now(), p.dob)) :: CHARACTER varying, ' ', 'Month(s)')
        END
        ELSE CONCAT (EXTRACT(YEAR FROM age(now(), p.dob)) :: CHARACTER varying,' ', 'Yrs') end)::character varying AS age,
        ar.person1id person2id,
        ar.person2id person1id,
        ar.updatedon
        FROM expunge.actor_expunge a
        INNER JOIN expunge.intakeservicerequestactor_expunge isa ON isa.actorid = a.actorid
        INNER JOIN person p ON p.personid =  a.personid
        LEFT JOIN actorrelationship ar ON ar.person2id = p.personid
        LEFT JOIN relationshiptype rt on rt.relationshiptypekey= ar.relationshiptypekey  AND rt.activeflag=1
        WHERE a.activeflag=1 and isa.activeflag=1
        AND CASE WHEN v_uuidornot IS NOT NULL THEN
          ar.intakeservicerequestactorid in (SELECT intakeservicerequestactorid FROM expunge.intakeservicerequestactor_expunge WHERE
          intakeserviceid = v_objectid::uuid and activeflag=1
          union
          SELECT intakeservicerequestactorid FROM expunge.intakeservicerequestactor_expunge where
          servicecaseid = v_objectid::uuid and activeflag=1)
          ELSE
          ar.intakeservicerequestactorid in (SELECT intakeservicerequestactorid FROM  expunge.intakeservicerequestactor_expunge WHERE
          intakenumber = v_objectid and activeflag=1)
          END
          AND ar.person2id = v_personid::uuid
          ORDER BY ar.updatedon DESC
    ) a;

  ELSIF v_isexpunged = 2 THEN 

  SELECT json_agg(a) INTO v_relationships FROM (
    SELECT
        DISTINCT
        p.personid,
        ar.actorrelationshipid,
        ar.caregiverflag,
        ar.intakeservicerequestactorid,
        ar.relationshiptypekey,
        COALESCE(rt.description,'Unknown') relation,
        ar.intakeserviceid,p.firstname,
        p.lastname,
        p.userphoto,
        p.dob,
        p.gendertypekey,
        (CASE WHEN EXTRACT(YEAR FROM age(now(), p.dob)) <= 0 THEN
        CASE WHEN EXTRACT(MONTH FROM age(now(), p.dob)) <= 0 THEN
        CONCAT (EXTRACT(DAY FROM age(now(), p.dob)) :: CHARACTER varying, ' ', 'Day(s)')
        ELSE CONCAT (EXTRACT(MONTH FROM age(now(), p.dob)) :: CHARACTER varying, ' ', 'Month(s)')
        END
        ELSE CONCAT (EXTRACT(YEAR FROM age(now(), p.dob)) :: CHARACTER varying,' ', 'Yrs') end)::character varying AS age,
        ar.person1id person2id,
        ar.person2id person1id,
        ar.updatedon
    FROM actor a
        INNER JOIN (
            select actorid 
                from intakeservicerequestactor where activeflag = 1
            union all
            select actorid
                from expunge.intakeservicerequestactor_expunge where activeflag = 1
          ) isa ON isa.actorid = a.actorid
        INNER JOIN person p ON p.personid = a.personid
        LEFT JOIN actorrelationship ar ON ar.person2id = p.personid
        LEFT JOIN relationshiptype rt on rt.relationshiptypekey= ar.relationshiptypekey  AND rt.activeflag=1
    WHERE CASE WHEN v_uuidornot IS NOT NULL THEN
              ar.intakeservicerequestactorid
              in (
                  SELECT intakeservicerequestactorid 
                      FROM intakeservicerequestactor 
                  where (intakeserviceid = v_objectid::uuid or servicecaseid = v_objectid::uuid) and activeflag=1
                  union 
                  SELECT intakeservicerequestactorid 
                      FROM expunge.intakeservicerequestactor_expunge 
                  where (intakeserviceid = v_objectid::uuid or servicecaseid = v_objectid::uuid) and activeflag=1
                  )
          ELSE
                ar.intakeservicerequestactorid 
                in (SELECT intakeservicerequestactorid 
                        FROM intakeservicerequestactor 
                    where intakenumber::character varying = v_objectid and activeflag=1
                        union
                        SELECT intakeservicerequestactorid 
                        FROM expunge.intakeservicerequestactor_expunge
                    where intakenumber = v_objectid and activeflag=1
                  )
          END
      AND ar.person2id = v_personid::uuid
      ORDER BY ar.updatedon DESC
      ) a;
ELSE

  SELECT json_agg(a) INTO v_relationships FROM (
             SELECT
            DISTINCT
            p.personid,
            ar.actorrelationshipid,
            ar.caregiverflag,
            ar.intakeservicerequestactorid,
            ar.relationshiptypekey,
            COALESCE(rt.description,'Unknown') relation,
            ar.intakeserviceid,p.firstname,
            p.lastname,
            p.userphoto,
            p.dob,
            p.gendertypekey,
            (CASE WHEN EXTRACT(YEAR FROM age(now(), p.dob)) <= 0 THEN
            CASE WHEN EXTRACT(MONTH FROM age(now(), p.dob)) <= 0 THEN
            CONCAT (EXTRACT(DAY FROM age(now(), p.dob)) :: CHARACTER varying, ' ', 'Day(s)')
            ELSE CONCAT (EXTRACT(MONTH FROM age(now(), p.dob)) :: CHARACTER varying, ' ', 'Month(s)')
            END
            ELSE CONCAT (EXTRACT(YEAR FROM age(now(), p.dob)) :: CHARACTER varying,' ', 'Yrs') end)::character varying AS age,
            ar.person1id person2id,
            ar.person2id person1id,
            ar.updatedon
            FROM actor a
            INNER JOIN intakeservicerequestactor isa ON isa.actorid = a.actorid
            INNER JOIN person p ON p.personid = a.personid
            LEFT JOIN actorrelationship ar ON ar.person2id = p.personid
            LEFT JOIN relationshiptype rt on rt.relationshiptypekey= ar.relationshiptypekey  AND rt.activeflag=1
            WHERE a.activeflag=1 and isa.activeflag=1
            AND CASE WHEN v_uuidornot IS NOT NULL THEN
            ar.intakeservicerequestactorid in (SELECT intakeservicerequestactorid FROM intakeservicerequestactor WHERE
                intakeserviceid = v_objectid::uuid and activeflag=1
                union
                SELECT intakeservicerequestactorid FROM intakeservicerequestactor where
                servicecaseid = v_objectid::uuid and activeflag=1)
            ELSE
            ar.intakeservicerequestactorid in (SELECT intakeservicerequestactorid FROM intakeservicerequestactor WHERE
             intakenumber::character varying = v_objectid and activeflag=1)
            END
            AND ar.person2id = v_personid::uuid
            ORDER BY ar.updatedon DESC
) a;

END IF;
   
RETURN v_relationships;
 END;

 $function$
;