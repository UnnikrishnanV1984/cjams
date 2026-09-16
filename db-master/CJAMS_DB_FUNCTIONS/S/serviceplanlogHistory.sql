CREATE OR REPLACE FUNCTION cjams.serviceplanloghistory(splanid uuid)
 RETURNS TABLE(servicelog json)
 LANGUAGE plpgsql
AS $function$                                                                                                                            
/* 
CDM-33164 Adding requestedby to return json to stop the approval by the same person who submitted the service plan version
CIDM-8281-Charan sai-Candidacy Determination Enhancement- Added new column versionupdatedby
-- CIDM-10405 - To get approved date from routing table - Veera 04/16/2025
  */

begin                                                                                                                                           
                                                                                                                                                                                                                                                                                  
 return query                                                                                                                             

select json_agg(item.*) as servicelog from                                                                                            
 (select ss.objectid,ss.objecttype,ss.updatedon,ss.approvaldate,ss.id,ss.insertedon,coalesce(ss.requestedby,ss.insertedby)as requestedby, 
 ( select insertedon from routing where objectid = ss.id::character varying and routingstatustypeid = 16 and eventcode = 'CPLAN2' and activeflag = 1 order by insertedon desc limit 1) as approveddate,
 ss.snapshotdata, ss.approvalstatus, ss.signatures, ss.fromdate, ss.todate, ss.personid,ss."comments" , up.fullname as approvedby, upf.fullname as versionupdatedby
 from snapshothist ss
 left join userprofile up on up.securityusersid = COALESCE(ss.approvedby,ss.updatedby)
 left join userprofile upf on upf.securityusersid = ss.versionupdatedby
 where ss.objectid::UUID = splanid and ss.activeflag = 1
 ) item;-- limit 1;                                                                                     
                                                                                                                    
 end;                                                                                                                                     
                                                                                                                                          
                                                                                                                                        
 $function$
;