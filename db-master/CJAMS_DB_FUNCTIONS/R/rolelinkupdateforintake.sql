DROP FUNCTION IF EXISTS cjams.rolelinkupdateforintake(character varying, character varying, uuid, uuid);
CREATE OR REPLACE FUNCTION cjams.rolelinkupdateforintake(v_intakeNumber character varying, v_securityuserid character varying, v_intakeservicerequestactorid uuid, v_personroleid uuid)
 RETURNS uuid
 LANGUAGE plpgsql
AS $function$ 
declare
v_intakeservreqactorid uuid;
begin
    IF(v_intakeservicerequestactorid is not null) THEN
        INSERT INTO intakeservicerequestactor
        (intakeservicerequestactorid, actorid, intakeservicerequestpersontypekey, insertedon, insertedby, updatedon, updatedby, intakenumber,
        reported, isprimary, personid, rcactiveflag, aractiveflag, practiveflag, drugexposednewbornflag,
        sexoffenderregisteredflag, probationsearchconductedflag,servicecaseid, fetalalcoholspctrmdisordflag,isheadofhousehold)
        select gen_random_uuid(), actorid, intakeservicerequestpersontypekey, now(),v_securityuserid, now(), v_securityuserid, v_intakeNumber,
        reported, isprimary, personid, rcactiveflag, aractiveflag, practiveflag, drugexposednewbornflag,
        sexoffenderregisteredflag, probationsearchconductedflag, null , fetalalcoholspctrmdisordflag, isheadofhousehold
        from intakeservicerequestactor where intakenumber=v_intakeNumber and intakeservicerequestactorid = v_intakeservicerequestactorid returning intakeservicerequestactorid into v_intakeservreqactorid;

        INSERT INTO cjams.actorrelationship
        (actorrelationshipid, relationshiptypekey, insertedby, insertedon, updatedby, updatedon, effectivedate, activeflag, intakeservicerequestactorid, client1id, client2id, person1id, person2id, intakenumber)
        select gen_random_uuid(), relationshiptypekey, v_securityuserid, now(), v_securityuserid, now(), now(),1, v_intakeservreqactorid, 
        client1id, client2id, person1id, person2id, v_intakeNumber
        from actorrelationship ar where ar.intakeservicerequestactorid = v_intakeservicerequestactorid and ar.activeflag = 1;
    END IF;

    IF(v_personroleid is not null) THEN

        INSERT INTO personrole ( personroleid, activeflag, personid, ishouseholdmember, iscollateralcontact, drugexposednewbornflag, drugexposedtypekey,
		otherdrugs, safehavenbabyflag, probationsearchconductedflag, sexoffenderregisteredflag, dangertoself, dangertoselfreason, isdangertoworker, 
		dangertoworkerreason, ismentalillness, mentalillnessdetail, ismentalimpair, mentalimpairdetail, insertedon, insertedby, updatedby, updatedon, intakenumber, initialresponse,initialresponseupdatedby,initialresponseupdatedon)
        select gen_random_uuid(), 1, personid, ishouseholdmember, iscollateralcontact, drugexposednewbornflag, drugexposedtypekey,
		otherdrugs, safehavenbabyflag, probationsearchconductedflag, sexoffenderregisteredflag, dangertoself, dangertoselfreason, isdangertoworker, 
		dangertoworkerreason, ismentalillness, mentalillnessdetail, ismentalimpair, mentalimpairdetail, now(), v_securityuserid, v_securityuserid, now(), intakenumber, initialresponse,initialresponseupdatedby,initialresponseupdatedon
        from personrole where personroleid = v_personroleid returning personroleid into v_intakeservreqactorid;

        INSERT INTO personroletype ( personroletypeid, activeflag, personroleid, roletype, updatedby, updatedon, isprimary, insertedby, insertedon)
		select gen_random_uuid(), 1, v_intakeservreqactorid, roletype, v_securityuserid, now(), isprimary, v_securityuserid, now()
        from personroletype where personroleid = v_personroleid and activeflag = 1;

    END IF;

    return v_intakeservreqactorid;	

end;
$function$;