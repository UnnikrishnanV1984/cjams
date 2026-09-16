DROP FUNCTION IF EXISTS cjams.updateintakeservicerequestactor(json, uuid, varchar, uuid, varchar, uuid);
CREATE OR REPLACE FUNCTION cjams.updateintakeservicerequestactor(v_deletedactorids json, v_intakeserviceid uuid, v_intakenumber character varying, v_personid uuid, v_securityuserid character varying, v_servicecaseid uuid)
 RETURNS text
 LANGUAGE plpgsql
AS $function$ 
-- Tables impacted
-- child Removal; TPR Recommendation; tprdetails; caseclosureparticipant; actorrelationship; adoptionemotionaldetails
-- contactparticipant; investigationallegationmaltreators; caseassignmentactor; adoptionplanning; meetingrecordingactor;
-- Intakeservicerequestpetitionactor;  investigationfindingtypeperson; permanencyplan;
declare

v_date timestamp without time zone;
v_deletedrole json;
v_activeactorid uuid;

BEGIN

select ia.intakeservicerequestactorid into v_activeactorid 
from intakeservicerequestactor ia 
inner join cjams.referencevalues rv on rv.ref_key = ia.intakeservicerequestpersontypekey and rv.referencetypeid=176 and rv.activeflag = 1 
and coalesce(rv.teamtypekey, 'CW') = 'CW' where IA.activeflag = 1 and (ia.servicecaseid = v_servicecaseid or ia.intakeserviceid = v_intakeserviceid 
or ia.intakenumber = v_intakenumber) and ia.personid = v_personid order by rv.displayorder asc;

v_date = now();
FOR v_deletedrole IN SELECT * FROM json_array_elements(v_deletedactorids)
loop
    raise notice '%v_deletedrole',  v_deletedrole;
    IF(v_deletedrole ->> 'intakeservicerequestactorid' is not null) THEN 
    
        UPDATE cjams.intakeservreqchildremoval
        SET intakeservicerequestactorid=v_activeactorid, updatedon= now(), updatedby = v_securityuserid
        WHERE intakeservicerequestactorid=(v_deletedrole ->> 'intakeservicerequestactorid')::uuid;

        UPDATE cjams.tprrecommendation
        SET intakeservicerequestactorid=v_activeactorid, updatedon= now(), updatedby = v_securityuserid
        WHERE intakeservicerequestactorid=(v_deletedrole ->> 'intakeservicerequestactorid')::uuid;        
 
        UPDATE cjams.tprdetails
        SET intakeservicerequestactorid=v_activeactorid, updatedon= now(), updatedby = v_securityuserid
        WHERE intakeservicerequestactorid=(v_deletedrole ->> 'intakeservicerequestactorid')::uuid;

        UPDATE cjams.caseclosureparticipant
        SET intakeservicerequestactorid=v_activeactorid, updatedon= now(), updatedby = v_securityuserid
        WHERE intakeservicerequestactorid=(v_deletedrole ->> 'intakeservicerequestactorid')::uuid;

        UPDATE cjams.actorrelationship
        SET intakeservicerequestactorid=v_activeactorid, updatedon= now(), updatedby = v_securityuserid
        WHERE intakeservicerequestactorid=(v_deletedrole ->> 'intakeservicerequestactorid')::uuid;

        UPDATE cjams.adoptionemotionaldetails
        SET intakeservicerequestactorid=v_activeactorid, updatedon= now(), updatedby = v_securityuserid
        WHERE intakeservicerequestactorid=(v_deletedrole ->> 'intakeservicerequestactorid')::uuid;
        
        UPDATE cjams.contactparticipant
        SET intakeservicerequestactorid=v_activeactorid, updatedon= now(), updatedby = v_securityuserid
        WHERE intakeservicerequestactorid=(v_deletedrole ->> 'intakeservicerequestactorid')::uuid;

        -- UPDATE cjams.investigationallegationmaltreators
        -- SET intakeservicerequestactorid=v_activeactorid, updatedon= now(), updatedby = v_securityuserid
        -- WHERE intakeservicerequestactorid=(v_deletedrole ->> 'intakeservicerequestactorid')::uuid;

        UPDATE cjams.caseassignmentactor
        SET intakeservicerequestactorid=v_activeactorid, updatedon= now(), updatedby = v_securityuserid
        WHERE intakeservicerequestactorid=(v_deletedrole ->> 'intakeservicerequestactorid')::uuid;

        UPDATE cjams.adoptionplanning
        SET intakeservicerequestactorid=v_activeactorid, updatedon= now(), updatedby = v_securityuserid
        WHERE intakeservicerequestactorid=(v_deletedrole ->> 'intakeservicerequestactorid')::uuid;

        UPDATE cjams.meetingrecordingactor
        SET intakeservicerequestactorid=v_activeactorid, updatedon= now(), updatedby = v_securityuserid
        WHERE intakeservicerequestactorid=(v_deletedrole ->> 'intakeservicerequestactorid')::uuid;

        UPDATE cjams.Intakeservicerequestpetitionactor
        SET intakeservicerequestactorid=v_activeactorid, updatedon= now(), updatedby = v_securityuserid
        WHERE intakeservicerequestactorid=(v_deletedrole ->> 'intakeservicerequestactorid')::uuid;

        UPDATE cjams.investigationfindingtypeperson
        SET intakeservicerequestactorid=v_activeactorid, updatedon= now(), updatedby = v_securityuserid
        WHERE intakeservicerequestactorid=(v_deletedrole ->> 'intakeservicerequestactorid')::uuid;

        UPDATE cjams.permanencyplan
        SET intakeservicerequestactorid=v_activeactorid, updatedon= now(), updatedby = v_securityuserid
        WHERE intakeservicerequestactorid=(v_deletedrole ->> 'intakeservicerequestactorid')::uuid;    

        UPDATE cjams.assessmentactor
        SET intakeservicerequestactorid=v_activeactorid, updatedon= now(), updatedby = v_securityuserid
        WHERE intakeservicerequestactorid=(v_deletedrole ->> 'intakeservicerequestactorid')::uuid;        

    END IF;
end loop;

return 'success';	
end
 $function$;
 