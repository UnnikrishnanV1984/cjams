
DROP  FUNCTION IF EXISTS getcaregiverchildinfo(v_intakeserviceid uuid);
CREATE OR REPLACE FUNCTION getcaregiverchildinfo(v_intakeserviceid uuid)
 RETURNS TABLE(message character varying)
 LANGUAGE plpgsql
AS $function$      

-------------------------------------------------------------------------------------------------------
-- 07/05/2024-B-195073- CIDM-9027-add Demographic story -Charan - Dempgraphic information of the chldren 

-------------------------------------------------------------------------------------------------------

DECLARE	

BEGIN  
RETURN QUERY 
select distinct
(' Youth (Child name Youth/CJAMD PID: ' || p.firstname || ' ' || p.lastname || '/' || p.cjamspid || 
') Currently Parenting. Please add the Child(ren) as part of the case ' ||  sc.servicecasenumber || 
' and identify the Relationship to at least one child as Caregiver.') ::character varying  as message
    
from actor ac,
    personsexualinfo psx,
    person p,
    servicecase sc
where ac.servicecaseid = v_intakeserviceid
    and ac.personid = psx.personid
    and psx.personid = p.personid
    and ac.servicecaseid = sc.servicecaseid
    and ac.activeflag = 1
    and psx.activeflag = 1
    and p.activeflag = 1
    and sc.activeflag = 1
    and coalesce(psx.currentlyparenting, false) = true -- Youth Currently parenting the child?
    -- Not a Caregiver 
    and (select count(*) 
            from actorrelationship ar
        where ar.activeflag=1 
            and ar.intakeservicerequestactorid 
                in (SELECT ira.intakeservicerequestactorid 
                        FROM intakeservicerequestactor ira
                    WHERE ira.intakeserviceid = v_intakeserviceid 
                        and ira.activeflag=1
                    union
                    SELECT ira.intakeservicerequestactorid 
                        FROM intakeservicerequestactor ira
                    where ira.servicecaseid = v_intakeserviceid 
                        and ira.activeflag=1
                        ) 
        and ar.caregiverflag = 1
        and ar.person1id = ac.personid
        ) = 0 ;
        
       END;

$function$;

;
