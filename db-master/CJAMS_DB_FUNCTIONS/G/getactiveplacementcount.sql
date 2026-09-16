
CREATE OR REPLACE FUNCTION cjams.getactiveplacementcount(v_providerid CHARACTER VARYING, v_programid CHARACTER VARYING)
  RETURNS text                                                                                                                                                                                                                                                                                                                                              
  LANGUAGE plpgsql                                                                                                                                                                                                                                                                                                                                          
 AS $function$                                                                                                                                                                                                                                                                                                                                              
 
 DECLARE
 	v_placementcount text;                                                                                                                                                                                                                                                                                                                                  
                                                                                                                                                                                                                                                                                                                                                            
 BEGIN
	 
 	IF v_programid IS NULL 
	 THEN
	 SELECT Count(*) INTO v_placementcount
	 	FROM TB_PLACEMENT      
		WHERE TB_PLACEMENT.PROVIDER_ID::CHARACTER VARYING = v_providerid 
		AND TB_PLACEMENT.DELETE_SW = 'N' 
		AND TB_PLACEMENT.ENTRY_DT IS NOT NULL 
		AND TB_PLACEMENT.EXIT_DT IS NULL
		AND ( TB_PLACEMENT.VOID_SW  = 'N' OR TB_PLACEMENT.VOID_SW  IS NULL );
	ELSE
	SELECT  Count(*)
        FROM TB_PLACEMENT INTO v_placementcount    
		WHERE TB_PLACEMENT.CONTRACT_PROGRAM_ID::CHARACTER VARYING = v_programid
        AND TB_PLACEMENT.DELETE_SW = 'N' 
        AND TB_PLACEMENT.ENTRY_DT is NOT NULL 
        AND TB_PLACEMENT.EXIT_DT IS NULL  
        AND ( TB_PLACEMENT.VOID_SW  = 'N' OR TB_PLACEMENT.VOID_SW  IS NULL );

	END IF;

 RETURN v_placementcount;                                                                                                                                                                                                                                                                                                                                                       
 END;                                                                                                                                                                                                                                                                                                                                                
 $function$