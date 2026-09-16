CREATE OR REPLACE FUNCTION cjams.listprognotetypes(prognotetypekey character varying, v_teamtypekey character varying DEFAULT ''::character varying)
 RETURNS TABLE(progressnotetypeid uuid, progressnotetypekey character varying, description text)
 LANGUAGE plpgsql
AS $function$
BEGIN

IF UPPER(v_teamtypekey)='LDSS' THEN
    v_teamtypekey = 'CW';
ELSEIF  UPPER(v_teamtypekey)='OLM' THEN
    v_teamtypekey = 'CW';    
ELSEIF  UPPER(v_teamtypekey)='FNS' THEN
    v_teamtypekey = 'CW'; 
END IF;

IF COALESCE(v_teamtypekey,'') ='' THEN 
RETURN query  
    SELECT A.progressnotetypeid, 
           A.progressnotetypekey, 
           a.description 
    FROM   progressnotetype AS A 
    WHERE  Lower(A.progressnoteclassificationtypekey) = 'user' 
           AND A.parentid IS NULL 
           AND A.activeflag = 1 ;
ELSE
    RETURN query  
    SELECT A.progressnotetypeid, 
           A.progressnotetypekey, 
           a.description 
    FROM   progressnotetype AS A 
    WHERE  Lower(A.progressnoteclassificationtypekey) = 'user' 
           AND A.parentid IS NULL 
           AND A.activeflag = 1 
           AND a.progressnotetypekey IN(SELECT PNTC.progressnotetypekey 
                                        FROM   progressnotetypeconfig AS PNTC 
                                        WHERE  PNTC.teamtypekey = v_teamtypekey) 
    ORDER  BY a.description ASC; 
END IF;

END;
$function$
;
