DROP FUNCTION  IF EXISTS getreviewtypelist();

CREATE OR REPLACE FUNCTION getreviewtypelist()
 RETURNS TABLE(sequencenumber integer, 
                reviewtypekey character varying, 
                activeflag integer, 
                datavalue integer, 
                editable integer, 
                typedescription character varying,
                effectivedate timestamp)
 LANGUAGE plpgsql
AS $function$
	
BEGIN 

RETURN QUERY 
    SELECT  rt.sequencenumber, 
            rt.reviewtypekey, 
            rt.activeflag, 
            rt.datavalue, 
            rt.editable, 
            rt.typedescription, 
            rt.effectivedate 
    FROM reviewtype rt;
    
END;

$function$

