CREATE OR REPLACE FUNCTION cjams.validatecontactnote(v_contactdate date, v_servicecaseid uuid, v_personids uuid[])
 RETURNS TABLE(message character varying, success boolean)
 LANGUAGE plpgsql
AS $function$              
 
 /*
        B-119350 - REFINEMENT of User Story B-108258: Reopening a Closed Service Case 
 */
  DECLARE                                                                                                                                                                             
         statusid_v character varying; 
         reopenreasonkey_v character varying;
         assignmentcounts_v integer;
 
  BEGIN        
            
            SELECT scp.intakeserreqstatustypekey, reopenreasonkey INTO statusid_v, reopenreasonkey_v
            FROM servicecasedisposition scp 
            INNER JOIN routing r on r.objectid = scp.servicecasedispositionid:: character varying AND scp.activeflag = 1 and r.activeflag = 1
            WHERE scp.servicecaseid = v_servicecaseid and r.routingstatustypeid = 16
                ORDER BY scp.insertedon desc 
                LIMIT 1;
                
                IF(statusid_v = 'Reopen' AND reopenreasonkey_v = 'EACN') THEN
                                
                                -- SELECT count(p.personprogramid) INTO assignmentcounts_v
                                -- FROM personprogramarea p 
                                -- WHERE p.objecttypekey = 'servicecase' 
                                --                 AND p.objectid = v_servicecaseid:: character varying
                                --                 AND p.enddate IS NOT NULL
                                --                 AND p.activeflag = 1
                                --                 AND date(v_contactdate) BETWEEN date(startdate) and date(enddate) 
                                --                 AND personid in (SELECT i.personid
                                --                                         FROM intakeservreqchildremoval i
                                --                                         INNER JOIN routing r ON r.objectid= i.intakeservreqchildremovalid::character varying  
                                --                                         WHERE i.servicecaseid = v_servicecaseid
                                --                                         --AND i.exitdate is null
                                --                                         AND i.personid = any(v_personids)
                                --                                         AND r.activeflag = 1 and r.routingstatustypeid = 16
                                --                                 );
                                -- IF(assignmentcounts_v > 0) THEN   
                                --         RETURN QUERY SELECT 'Contact notes can be added to this servicecase'::character varying, true;  
                                -- ELSE
                                --         RETURN QUERY SELECT 'There is no program assignment on the selected contact note date. Please change the date and submit'::character varying, false;    
                                -- END IF;
                select sum((case when tab.pp_count > 0 then 0 else 1 end)) into assignmentcounts_v 
                from 
                (
                        select p.personid, 
                        (
                                SELECT 
                                count(pp.personprogramid) 
                                FROM 
                                personprogramarea pp 
                                WHERE 
                                pp.personid = p.personid 
                                and pp.objecttypekey = 'servicecase' 
                                AND pp.objectid = v_servicecaseid :: character varying 
                                AND pp.activeflag = 1 
                                AND date(v_contactdate) BETWEEN date(pp.startdate) and date(coalesce(pp.enddate, v_contactdate))
                        ) as pp_count 
                from 
                person p 
                where 
                p.personid = any(v_personids) 
                ) tab;
                IF(assignmentcounts_v = 0) THEN  
                        RETURN QUERY SELECT 'Contact notes can be added to this servicecase'::character varying, true; 
                ELSE
                        RETURN QUERY SELECT 'There is no program assignment on the selected contact note date. Please change the date and submit'::character varying, false;      
                END IF;            
                ELSE
                                RETURN QUERY SELECT 'Contact notes can be added to this servicecase'::character varying, true;  
                END IF;
                
                -- Handling exceptions
                EXCEPTION WHEN OTHERS THEN
                        BEGIN   
                                RAISE NOTICE 'Internal error: %', sqlerrm;
                                RETURN QUERY SELECT 'Unable to process validate contact note. Please try again later.'::character varying, false;   
                        END; 

   END;
   $function$ ;
   