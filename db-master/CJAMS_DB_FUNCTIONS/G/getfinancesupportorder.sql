-- FUNCTION: getfinancesupportorder( uuid);

-- DROP FUNCTION getfinancesupportorder( uuid);

CREATE OR REPLACE FUNCTION getfinancesupportorder( personid uuid)
    RETURNS json 
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
AS $BODY$



DECLARE
    
    v_personid uuid;
	v_result json;

	
BEGIN
    
    v_personid := personid :: uuid;

SELECT json_agg(pso) into v_result FROM 
	(
	select 

    cso.csesclientsupportorderid,    
    cso.personid,                    
    cso.socounty,                    
    cso.socityname,                  
    cso.sostate,                     
    cso.sonumber,                    
    cso.sodate,                      
    cso.sostatusdate,                
    cso.sostatustypekey,             
    cso.sopaymentamount,             
    cso.sopaymentfreqtypekey,        
    cso.sodatasource                
 
   from csesclientsupportorder cso where cso.personid = v_personid and cso.activeflag = 1    
		
	) pso;
	
RETURN v_result;

END;



$BODY$;

ALTER FUNCTION getfinancesupportorder( personid uuid)
    OWNER TO welfareadmin;
