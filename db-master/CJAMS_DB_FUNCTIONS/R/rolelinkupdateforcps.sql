DROP FUNCTION IF EXISTS cjams.rolelinkupdateforcps(uuid, character varying, uuid, uuid, uuid);
CREATE OR REPLACE FUNCTION cjams.rolelinkupdateforcps(v_intakeserviceid uuid, v_securityuserid character varying, v_intakeservicerequestactorid uuid, v_personid uuid, v_personroleid uuid)
 RETURNS uuid
 LANGUAGE plpgsql
AS $function$ 
declare
v_intakeservreqactorid uuid;
begin
    if(v_personroleid is not null) then

        INSERT INTO personrole ( personroleid, activeflag, personid, ishouseholdmember, iscollateralcontact, drugexposednewbornflag, drugexposedtypekey,
		otherdrugs, safehavenbabyflag, probationsearchconductedflag, sexoffenderregisteredflag, dangertoself, dangertoselfreason, isdangertoworker, 
		dangertoworkerreason, ismentalillness, mentalillnessdetail, ismentalimpair, mentalimpairdetail, updatedby, updatedon, insertedon, insertedby, intakeserviceid, initialresponse,initialresponseupdatedby,initialresponseupdatedon)
        select gen_random_uuid(), 1, personid, ishouseholdmember, iscollateralcontact, drugexposednewbornflag, drugexposedtypekey,
		otherdrugs, safehavenbabyflag, probationsearchconductedflag, sexoffenderregisteredflag, dangertoself, dangertoselfreason, isdangertoworker, 
		dangertoworkerreason, ismentalillness, mentalillnessdetail, ismentalimpair, mentalimpairdetail, v_securityuserid, now(), now(), v_securityuserid, intakeserviceid, initialresponse,initialresponseupdatedby,initialresponseupdatedon
        from personrole where personroleid = v_personroleid returning personroleid into v_intakeservreqactorid;

        INSERT INTO personroletype ( personroletypeid, activeflag, personroleid, roletype, updatedby, updatedon, isprimary, insertedby, insertedon)
		select gen_random_uuid(), 1, v_intakeservreqactorid, roletype, v_securityuserid, now(), isprimary, v_securityuserid, now()
        from personroletype where personroleid = v_personroleid and activeflag = 1;
        
    end if;

    IF (v_intakeservicerequestactorid is not null) THEN 
        if(v_personid is not null) then
            select ia.intakeservicerequestactorid into v_intakeservreqactorid 
            from intakeservicerequestactor ia 
            inner join cjams.referencevalues rv on rv.ref_key = ia.intakeservicerequestpersontypekey and rv.referencetypeid=176 and rv.activeflag = 1 
            and coalesce(rv.teamtypekey, 'CW') = 'CW' where IA.activeflag = 1 and ia.intakeserviceid = v_intakeserviceid 
            and ia.personid = v_personid order by rv.displayorder asc;
        else 
            INSERT INTO intakeservicerequestactor
            (intakeservicerequestactorid, actorid, intakeservicerequestpersontypekey, insertedon, insertedby, updatedon, updatedby, intakeserviceid,
            reported, isprimary, personid, rcactiveflag, aractiveflag, practiveflag, drugexposednewbornflag,
            sexoffenderregisteredflag, probationsearchconductedflag, fetalalcoholspctrmdisordflag,isheadofhousehold)
            select gen_random_uuid(), actorid, intakeservicerequestpersontypekey, now(),v_securityuserid, now(), v_securityuserid, v_intakeserviceid,
            reported, isprimary, personid, rcactiveflag, aractiveflag, practiveflag, drugexposednewbornflag,
            sexoffenderregisteredflag, probationsearchconductedflag, fetalalcoholspctrmdisordflag, isheadofhousehold
            from intakeservicerequestactor where intakeserviceid=v_intakeserviceid and intakeservicerequestactorid = v_intakeservicerequestactorid returning intakeservicerequestactorid into v_intakeservreqactorid;

            INSERT INTO cjams.actorrelationship
            (actorrelationshipid, relationshiptypekey, insertedby, insertedon, updatedby, updatedon, effectivedate, activeflag, intakeservicerequestactorid, client1id, client2id, person1id, person2id, intakeserviceid)
            select gen_random_uuid(), relationshiptypekey, v_securityuserid, now(), v_securityuserid, now(), now(),1, v_intakeservreqactorid, client1id, client2id, person1id, person2id, v_intakeserviceid
            from actorrelationship ar where ar.intakeservicerequestactorid = v_intakeservicerequestactorid and ar.activeflag = 1;
        end if;

        UPDATE cjams.investigationallegationmaltreators
        SET intakeservicerequestactorid=v_intakeservreqactorid, updatedon= now(), updatedby = v_securityuserid
        WHERE intakeservicerequestactorid=v_intakeservicerequestactorid::uuid;

        UPDATE cjams.investigationfindingtypeperson
        SET intakeservicerequestactorid=v_intakeservreqactorid, updatedon= now(), updatedby = v_securityuserid
        WHERE intakeservicerequestactorid=v_intakeservicerequestactorid::uuid;

        UPDATE cjams.Intakeservicerequestpetitionactor
        SET intakeservicerequestactorid=v_intakeservreqactorid, updatedon= now(), updatedby = v_securityuserid
        WHERE intakeservicerequestactorid=v_intakeservicerequestactorid::uuid;
            
        UPDATE cjams.contactparticipant
        SET intakeservicerequestactorid=v_intakeservreqactorid, updatedon= now(), updatedby = v_securityuserid
        WHERE intakeservicerequestactorid=v_intakeservicerequestactorid::uuid;

        UPDATE cjams.caseassignmentactor
        SET intakeservicerequestactorid=v_intakeservreqactorid, updatedon= now(), updatedby = v_securityuserid
        WHERE intakeservicerequestactorid=v_intakeservicerequestactorid::uuid;

        UPDATE cjams.meetingrecordingactor
        SET intakeservicerequestactorid=v_intakeservreqactorid, updatedon= now(), updatedby = v_securityuserid
        WHERE intakeservicerequestactorid=v_intakeservicerequestactorid::uuid;

        UPDATE cjams.Intakeservicerequestpetitionactor
        SET intakeservicerequestactorid=v_intakeservreqactorid, updatedon= now(), updatedby = v_securityuserid
        WHERE intakeservicerequestactorid=v_intakeservicerequestactorid::uuid;

        UPDATE cjams.assessmentactor
        SET intakeservicerequestactorid=v_intakeservreqactorid, updatedon= now(), updatedby = v_securityuserid
        WHERE intakeservicerequestactorid=v_intakeservicerequestactorid::uuid; 

    END IF;

    return v_intakeservreqactorid;	

end
$function$;