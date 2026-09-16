DROP FUNCTION IF EXISTS safecareplandetailsforprint(CHARACTER varying,CHARACTER varying);
CREATE OR REPLACE FUNCTION safecareplandetailsforprint( v_objectid CHARACTER varying, v_objecttypekey CHARACTER varying,v_safecareplanid UUID)                                                                             
  RETURNS TABLE(safecareplandetails json)                                                                                                            
  LANGUAGE plpgsql                                                                                                                          
 AS $function$       
 ------------------------------------------------------------------------------------------------------------
-- Revision(s)
-- 8/8/2025 Smitha SOmasekharan- CIDM-10625-POSC Enhancement userstory chnages.
-- 01/21/2026 - Vineet Tirodkar - To add consider active records only (activeflag = 1) - CIDM-10978
------------------------------------------------------------------------------------------------------------                                                                                                                     
begin                                                                                                                                           
                                                                                                                                                                                                                                                                                  
 return query                                                                                                                             

select json_agg(item.*) as safecareplandetails from                                                                                            
 ( select * , (select fullname from userprofile vu where vu.securityusersid = scp.updatedby::character varying limit 1) as requestedby
                          , to_char(scp.updatedon, 'MM/DD/YYYY HH:MI AM') as requestedon 
                          , (select fullname from userprofile vu where vu.securityusersid = scp.insertedby::character varying limit 1) as caseworkername
                          , (select fullname from v_userprofile where securityusersid = 
                                     (select fromsecurityusersid from routing 
                                     where objectid = scp.safecareplanid::character varying and routingstatustypeid in (16, 17) order by updatedon desc limit 1)
                              ) as supervisorname
                          , (select routingstatustypeid from routing where objectid = scp.safecareplanid:: character varying and activeflag = 1 order by insertedon desc limit 1) as approvalstatus
                    from safecareplan scp
                    where objectid = v_objectid 
						and v_objecttypekey = $2 
						and safecareplanid :: uuid = v_safecareplanid
						and scp.activeflag = 1

 ) item;-- limit 1;                                                                                     
                                                                                                                    
 end;                                                                                                                                     
                                                                                                                                          
                                                                                                                                          
 $function$                                                                                                                                 

