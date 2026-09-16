DROP  FUNCTION IF EXISTS cjams.getcaregiverpersonchildinfo(v_intakeserviceid uuid, v_person1id uuid);
CREATE OR REPLACE FUNCTION cjams.getcaregiverpersonchildinfo(v_intakeserviceid uuid, v_person1id uuid)
 RETURNS TABLE(personid uuid,firstname character varying, middlename character varying, lastname character varying, gendertypekey character varying,
 dob TIMESTAMP WITHOUT TIME zone,racetypekey  character varying )
 LANGUAGE plpgsql
AS $function$      

-------------------------------------------------------------------------------------------------------
-- 07/05/2024-B-195073- CIDM-9027-add Demographic story -Charan - Dempgraphic information of the chldren 
--2/28/2024-Sai Teja Chintha - CDM-44264-Health-Reproductive-Health
-------------------------------------------------------------------------------------------------------

DECLARE	

BEGIN  
RETURN QUERY 
select p.personid,p.firstname,p.middlename,p.lastname,p.gendertypekey,
p.dob,(select STRING_AGG(race.description, ', ')
          from personracetypemap prt,
             referencevalues race
          where race.ref_key = prt.racetypekey
          and prt.personid =  p.personid
            and prt.activeflag = 1 and race.referencetypeid = 171)::character varying  as racetypekey
          from person p
          where  p.personid in (select ar.person2id from actorrelationship ar
          where ar.activeflag=1 and ar.relationshiptypekey ='BGMTHR'
          and ar.intakeservicerequestactorid
          in (SELECT ira.intakeservicerequestactorid
                           FROM intakeservicerequestactor ira
                        WHERE ira.intakeserviceid = v_intakeserviceid and ira.activeflag=1
                        union
                        SELECT ira.intakeservicerequestactorid
                            FROM intakeservicerequestactor ira
                        where ira.servicecaseid = v_intakeserviceid and ira.activeflag=1
                        ) and ar.caregiverflag=1
           and ar.person1id=v_person1id );
 END;

$function$;

;
