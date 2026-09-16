DROP FUNCTION IF EXISTS cjams.updateJiraStatus1(json);
CREATE OR REPLACE FUNCTION cjams.updateJiraStatus1(jsonresp json)
RETURNS text
LANGUAGE plpgsql 
AS $function$     
 DECLARE   
                                                                                                                                                                                                      
 returnStatus text;   
i json ;
v_supportno    character    varying; 
v_jirano    character    varying; 
v_status    character    varying; 

BEGIN

For    i    in   ( SELECT    *    FROM    json_array_elements(jsonresp::json))
loop
	RAISE NOTICE  'Key value %',  i->>'key'; 
	RAISE NOTICE   'Support %',     i-> 'fields' ->> 'customfield_13300'; 
	RAISE NOTICE   'Status %',     i-> 'fields' -> 'status' ->> 'name'; 

v_supportno :=   i-> 'fields' ->> 'customfield_13300'; 
v_jirano  :=   i->>'key'; 
v_status  :=  i-> 'fields' -> 'status' ->> 'name'; 


IF EXISTS (SELECT * FROM   defecttracking.supportlog WHERE  supportno =v_supportno) THEN
	UPDATE defecttracking.supportlog SET    status = v_status, jirarequestno = v_jirano WHERE  supportno =v_supportno;
END IF;

END  LOOP;     
                                                                                                                                                                                                    
 returnStatus:= 'Success';                                                                                                                                                                                                             
 RETURN returnStatus;  
                                                                                                                                                                                                                     
 END;                                                                                                                                                                                                                
                                                                                                                                                                                                                     
 $function$    
