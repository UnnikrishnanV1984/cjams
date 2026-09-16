 DROP FUNCTION IF EXISTS cjams.ebpservicelogdetails(character varying, character varying);
 CREATE OR REPLACE FUNCTION cjams.ebpservicelogdetails(splanid character varying, casetype character varying)                                                                             
  RETURNS TABLE(servicelog json)                                                                                                            
  LANGUAGE plpgsql                                                                                                                          
 AS $function$                                                                                                                            

------------------------------------------------------------------------------------------------------------
-- Revision(s) 
-- 06/02/2025 - Veera Nadimpalli CIDM-10366 B-216159 EBP Missing Data Short Term Fix
-- 08-18-2026 - Veera Nadimpalli  - CIDM-11600 - Fixing API Server Errors
------------------------------------------------------------------------------------------------------------	                                                                                                                                
                                                                                                                                          
 begin                                                                                                                                    
                                                                                                                                                                                                                                                                                 
                                                                                                                           

If(casetype = 'closure') then                    

 return query  

 select json_agg(x) as data1 from (
            select a.*, p.firstname || ' ' || p.lastname as client_nm  from (
  WITH valid_snapshots AS (
				SELECT 
					s2.*,
					s.serviceplanid,
					sc.servicecaseid,
					sc.servicecasenumber,
					s2.snapshotdata->'involvedpersons' AS involvedpersons
				FROM serviceplan s
				JOIN snapshothist s2 
					ON s2.objectid = s.serviceplanid::varchar 
					AND s2.activeflag = 1
				JOIN servicecase sc 
					ON sc.servicecaseid = s.objectid::uuid 
					AND sc.activeflag = 1 
					AND btrim(lower(sc.statustypekey)) NOT IN ('closed') 
					WHERE s.objectid = splanid AND s.activeflag = 1
					--AND json_typeof(s2.snapshotdata::json->'involvedpersons') = 'array'
				)
				SELECT 
				vs.serviceplanid,
				vs.servicecaseid,
				vs.servicecasenumber,
				ip->>'id' AS clientid,
				(ip->'ebp')->>'isebpreferralmade' AS isebpreferralmade,
				(ip->'ebp')->>'utilized' AS utilized
				FROM valid_snapshots vs
				JOIN LATERAL jsonb_array_elements(
					CASE WHEN jsonb_typeof(vs.involvedpersons) = 'array'
						 THEN vs.involvedpersons
						 ELSE '[]'::jsonb END
				) AS ip ON TRUE
				WHERE ip->'ebp' IS NOT NULL

                ) a, person p 
                where a.isebpreferralmade = 'Yes' and a.utilized = 'Yes' and p.cjamspid = a.clientid::bigint and
               ((select count(*) from tb_service_log tsl
                 join tb_provider_services AS TPS ON TPS.provider_service_id = TSL.provider_service_id AND TSL.provider_service_id IS NOT null
                 JOIN tb_services AS TSR ON TSR.service_id = TPS.service_id 
                where client_id = a.clientid::bigint and tsl.case_id::character varying = a.servicecasenumber and tsl.end_dt is null and TSL.delete_sw='N' and btrim(lower(TSR.service_nm)) like '%ebp%') = 0)
            ) as x      ;   

else If(casetype = 'pending') then 

RETURN QUERY  
SELECT json_agg(x) AS data1 FROM (
    SELECT a.*, p.firstname || ' ' || p.lastname AS client_nm FROM (
       WITH valid_snapshots AS (
				SELECT 
					s2.*,
					s.serviceplanid,
					sc.servicecaseid,
					sc.servicecasenumber,
					s2.snapshotdata->'involvedpersons' AS involvedpersons
				FROM serviceplan s
				JOIN snapshothist s2 
					ON s2.objectid = s.serviceplanid::varchar 
					AND s2.activeflag = 1
          AND s2.approvalstatus = 'Approved'
				JOIN servicecase sc 
					ON sc.servicecaseid = s.objectid::uuid 
					AND sc.activeflag = 1 
					AND btrim(lower(sc.statustypekey)) NOT IN ('closed') 
					WHERE s.objectid = splanid AND s.activeflag = 1
					--AND json_typeof(s2.snapshotdata::json->'involvedpersons') = 'array'
				)
				SELECT 
				vs.serviceplanid,
				vs.servicecaseid,
				vs.servicecasenumber,
				ip->>'id' AS clientid,
				(ip->'ebp')->>'isebpreferralmade' AS isebpreferralmade,
				(ip->'ebp')->>'utilized' AS utilized
				FROM valid_snapshots vs
				JOIN LATERAL jsonb_array_elements(
					CASE WHEN jsonb_typeof(vs.involvedpersons) = 'array'
						 THEN vs.involvedpersons
						 ELSE '[]'::jsonb END
				) AS ip ON TRUE
				WHERE ip->'ebp' IS NOT NULL
    ) a, person p 
    WHERE a.isebpreferralmade = 'Yes' 
      AND a.utilized = 'Yes' 
      AND p.cjamspid = a.clientid::bigint 
      AND (
          SELECT count(*) 
          FROM tb_service_log tsl
          JOIN tb_provider_services TPS ON TPS.provider_service_id = TSL.provider_service_id AND TSL.provider_service_id IS NOT null
          JOIN tb_services TSR ON TSR.service_id = TPS.service_id 
          WHERE client_id = a.clientid::bigint 
            AND tsl.case_id::character varying = a.servicecasenumber 
            AND TSL.delete_sw = 'N' 
            AND btrim(lower(TSR.service_nm)) LIKE '%ebp%'
      ) = 0
) AS x;

else 

RETURN QUERY  
SELECT json_agg(x) AS data1 FROM (
    SELECT a.*, p.firstname || ' ' || p.lastname AS client_nm FROM (
       WITH valid_snapshots AS (
				SELECT 
					s2.*,
					s.serviceplanid,
					sc.servicecaseid,
					sc.servicecasenumber,
					s2.snapshotdata->'involvedpersons' AS involvedpersons
				FROM serviceplan s
				JOIN snapshothist s2 
					ON s2.objectid = s.serviceplanid::varchar 
					AND s2.activeflag = 1
          AND s2.approvalstatus = 'Approved'
				JOIN servicecase sc 
					ON sc.servicecaseid = s.objectid::uuid 
					AND sc.activeflag = 1 
					AND btrim(lower(sc.statustypekey)) NOT IN ('closed') 
					WHERE s.objectid = splanid AND s.activeflag = 1
					--AND json_typeof(s2.snapshotdata::json->'involvedpersons') = 'array'
				)
				SELECT 
				vs.serviceplanid,
				vs.servicecaseid,
				vs.servicecasenumber,
				ip->>'id' AS clientid,
				(ip->'ebp')->>'isebpreferralmade' AS isebpreferralmade,
				(ip->'ebp')->>'utilized' AS utilized
				FROM valid_snapshots vs
				JOIN LATERAL jsonb_array_elements(
					CASE WHEN jsonb_typeof(vs.involvedpersons) = 'array'
						 THEN vs.involvedpersons
						 ELSE '[]'::jsonb END
				) AS ip ON TRUE
				WHERE ip->'ebp' IS NOT NULL
    ) a, person p 
    WHERE a.isebpreferralmade = 'Yes' 
      AND a.utilized = 'Yes' 
      AND p.cjamspid = a.clientid::bigint 
      AND (
          SELECT count(*) 
          FROM tb_service_log tsl
          JOIN tb_provider_services TPS ON TPS.provider_service_id = TSL.provider_service_id AND TSL.provider_service_id IS NOT null
          JOIN tb_services TSR ON TSR.service_id = TPS.service_id 
          WHERE client_id = a.clientid::bigint 
            AND tsl.case_id::character varying = a.servicecasenumber 
            AND TSL.delete_sw = 'N' 
            AND btrim(lower(TSR.service_nm)) LIKE '%ebp%'
      ) = 0
) AS x;

end if;
end if;
                                                                                                                                          
 end;                                                                                                                                     
                                                                                                                                          
                                                                                                                                          
 $function$                                                                                                                                 
