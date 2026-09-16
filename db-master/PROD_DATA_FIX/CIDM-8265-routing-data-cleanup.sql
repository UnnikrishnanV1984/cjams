
-- CIDM-8265 - Routing Data Clean-Up - Assessments
/* Issue Description:Routing Data Clean-Up - Assessments.

-- Category/ Module:Data cleanup - Assessments

-- Root cause: Need analysis on supervisors with pending intake requests and make them inactive.
-- Fix Provided: Datafix has been updated for deleted supervisors to not to show up 
-- Pull request# N/A
*/


select *
from (
select * 
    from routing r
where r.eventcode = 'ASST'
    and r.activeflag = 1 
    and r.routingstatustypeid = 15     
) tab    
where  ( select count(*)
          from assessment asm
        where asm.assessmentid = tab.objectid::uuid
            and asm.activeflag = 0
          ) > 0 ;   
         
         
UPDATE routing
SET activeflag = 0, updatedby='CIDM-8265', updatedon=now()
WHERE eventcode = 'ASST'
    AND activeflag = 1
    AND routingstatustypeid = 15
    AND objectid::uuid IN (
        SELECT asm.assessmentid
        FROM assessment asm
        WHERE asm.assessmentid = routing.objectid::uuid
            AND asm.activeflag = 0
    );  
    
    
select * 
    from routing r
where r.eventcode = 'ASST'
    and r.activeflag = 1 
    and r.routingstatustypeid = 15 
    and r.objectid    
        in ( select asm.assessmentid::character varying
                from assessment asm,
                    servicecase sc
            where asm.objectid = sc.servicecaseid
                and asm.activeflag = 1
                and sc.activeflag = 1
                and asm.servicecaseid is null
          ) ;
          
 update routing r set activeflag = 0, updatedby='CIDM-8265', updatedon=now()
 where r.eventcode = 'ASST'
    and r.activeflag = 1 
    and r.routingstatustypeid = 15 
    and r.objectid    
        in ( select asm.assessmentid::character varying
                from assessment asm,
                    servicecase sc
            where asm.objectid = sc.servicecaseid
                and asm.activeflag = 1
                and sc.activeflag = 1
                and asm.servicecaseid is null
          ) ;