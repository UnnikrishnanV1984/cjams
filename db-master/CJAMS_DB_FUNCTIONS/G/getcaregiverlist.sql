CREATE OR REPLACE FUNCTION cjams.getcaregiverlist(v_personid character varying)
 RETURNS json
 LANGUAGE plpgsql
AS $function$                                                                                                                                                                                                                                                                                                                                              
 ------------------------------------------------------------------------------------------------
-- Revisions:
-- Chandra/Palani - 02/15/2024 - Query tuning (CIDM-8409)
-- Yogeshvar      - 08/26/2024 - Query tuning (CIDM-9346)
------------------------------------------------------------------------------------------------
 DECLARE
  v_response json;                                                                                                                                                                                                                                                                                                                                  
                                                                                                                                                                                                                                                                                                                                                           
 BEGIN
  SELECT jsonb_agg(json_build_object('personid', ar.person1id, 'personname', concat( p.prefx, ' ', p.firstname, ' ', p.middlename, ' ', p.lastname, ' ', p.suffix))) into v_response from actorrelationship ar join person p on p.personid = ar.person1id where ar.caregiverflag = 1 and
   ar.person2id = v_personid::uuid;

 RETURN v_response;                                                                                                                                                                                                                                                                                                                                                      
 END;                                                                                                                                                                                                                                                                                                                                                
 $function$
;
