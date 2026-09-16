DROP FUNCTION IF EXISTS cjams.getcasepersonname_expunge(character varying, character varying);
CREATE OR REPLACE FUNCTION cjams.getcasepersonname_expunge(objecttypekey character varying, objectid character varying)
 RETURNS json
 LANGUAGE plpgsql
AS $function$
-------------------------------------------------------------------------------------------
--Revision(s)
--02/03/2026- Manasa Kasula (CIDM-10890): Expungement changes

-------------------------------------------------------------------------------------------

    DECLARE   l_personname json;
    DECLARE l_count bigint;
DECLARE v_objectid CHARACTER VARYING ;
BEGIN        
v_objectid := objectid;

IF (lower(objecttypekey)='intake') THEN

    SELECT COUNT(1) INTO l_count FROM expunge.intakedastaging_expunge WHERE intakenumber = v_objectid AND activeflag =1;
    IF (COALESCE(l_count,0) = 0 ) THEN
        SELECT json_agg(x) INTO l_personname  FROM
        (
            SELECT  DISTINCT concat_ws(' ',coalesce(p.firstname,null),coalesce(p.middlename,null),coalesce(p.lastname,null),coalesce(p.suffix,null) ) :: character varying as personname
            FROM    expunge.intakeservicerequestactor_expunge ISRA  
                    INNER JOIN person p on p.personid = ISRA.personid AND p.activeflag =1
            WHERE   ISRA.activeflag =1  
                    AND ISRA.isheadofhousehold=true  
                    AND ISRA.intakenumber = v_objectid
            ORDER BY 1
        ) x;
    ELSE
       
        SELECT json_agg(x) INTO l_personname
        FROM (
            select concat_ws(' ',coalesce(per.firstname,null),coalesce(per.middlename,null),coalesce(per.lastname,null),coalesce(per.suffix,null)) as personname
            from expunge.intakeservicerequestactor_expunge isra
            join person per on per.personid = isra.personid
            join expunge.actor_expunge act on act.actorid = isra.actorid and act.activeflag = 1  
            where isra.intakenumber = v_objectid and isra.activeflag = 1 and isra.isheadofhousehold = true
        ) x;
    END IF;
ELSE
    SELECT json_agg(x) INTO l_personname 
    FROM (
        SELECT distinct  concat_ws(' ',coalesce(p.firstname,null),coalesce(p.middlename,null),coalesce(p.lastname,null),coalesce(p.suffix,null) ) :: character varying as personname
        FROM  expunge.intakeservicerequestactor_expunge ISRA  
        INNER JOIN person p on p.personid = ISRA.personid AND p.activeflag =1
        INNER JOIN expunge.actor_expunge A ON A.actorid = ISRA.actorid AND A.activeflag =1
        WHERE ISRA.activeflag =1  
        and ISRA.isheadofhousehold=true  
        AND ISRA.intakeserviceid = v_objectid ::uuid
    ) x;
   
END IF;    

 RETURN l_personname;
END;
$function$
;
