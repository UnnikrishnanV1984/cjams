
DROP FUNCTION if exists deleteinvolvedperson(uuid,uuid,character varying, boolean);

DROP FUNCTION if exists deleteinvolvedperson(uuid,uuid,character varying, boolean,uuid);

DROP FUNCTION if exists deleteinvolvedperson(uuid,uuid,character varying, boolean, uuid, character varying);

CREATE OR REPLACE FUNCTION cjams.deleteinvolvedperson(v_personid uuid, v_intakeserviceid uuid DEFAULT NULL::uuid, v_intakenumber character varying DEFAULT NULL::character varying, v_iscase boolean DEFAULT false, v_servicecaseid uuid DEFAULT NULL::uuid, v_securityuserid character varying DEFAULT NULL::character varying)
 RETURNS text
 LANGUAGE plpgsql
AS $function$
 declare 
   _offset integer; 
   v_actorid uuid;
   v_personcount integer;
   v_personadoptioncount integer;
   vd_intakeserviceid character varying;
   vd_servicecaseid character varying;
   vd_senchild integer;
   v_person json;
   v_exposednewborn bool;

begin

	if(v_iscase = true)
	then 
		update actor set activeflag = 0 where personid = v_personid and intakeserviceid = v_intakeserviceid;
		update intakeservicerequestactor set activeflag=0, updatedby = v_securityuserid, updatedon = now()  where personid = v_personid and intakeserviceid = v_intakeserviceid;
		select actorid, servicecaseid::varchar into v_actorid , vd_servicecaseid from actor where  personid = v_personid and intakeserviceid = v_intakeserviceid limit 1;
		update intakeservicerequestactor set activeflag=0, updatedby = v_securityuserid, updatedon = now()  where actorid=v_actorid;
        update personrole set activeflag = 0, updatedby = v_securityuserid, updatedon = now()  where  personid = v_personid and intakeserviceid = v_intakeserviceid; 
		UPDATE cjams.personprogramarea
		SET updatedby = v_securityuserid, updatedon = now(), datatransferflag='D'::character varying, activeflag = 0
		where personid=v_personid and objectid in (v_intakeserviceid::varchar, vd_servicecaseid);
	
   else	
		update actor set activeflag = 0, updatedby = v_securityuserid, updatedon = now()  where personid = v_personid and intakenumber = v_intakenumber;
        update intakeservicerequestactor set activeflag=0, updatedby = v_securityuserid, updatedon = now() where personid = v_personid and intakenumber = v_intakenumber;
        update personrole set activeflag = 0, updatedby = v_securityuserid, updatedon = now() where  personid = v_personid and intakenumber = v_intakenumber;
		select actorid into v_actorid from actor where  personid = v_personid and 
				intakenumber = v_intakenumber limit 1;
		update intakeservicerequestactor set activeflag=0, updatedby = v_securityuserid, updatedon = now() where actorid=v_actorid;
	
		--updating isnegrh_exposednewborn after deleting person
		select count(substanceexposednewbornflag) into vd_senchild from person p where personid 
		in (select distinct personid from actor where intakenumber = v_intakenumber and activeflag = 1 and personid != v_personid)
		and p.substanceexposednewbornflag = 1 and p.activeflag = 1;
		
		select jsondata into v_person from intakedastaging where intakenumber = v_intakenumber and activeflag=1;
		select v_person ->  'sdm' -> 'riskofHarm' -> 'isnegrh_exposednewborn' into v_exposednewborn;
	
		IF  vd_senchild = 0 and v_exposednewborn = true then		
			UPDATE intakedastaging
			SET jsondata = jsonb_set(jsondata, '{sdm}', jsonb_set(jsondata->'sdm', '{isnegrh_exposednewborn}', 'false'))
				, updatedby = v_securityuserid
				, updatedon = now()
			WHERE intakenumber = v_intakenumber AND activeflag=1;
		
			UPDATE intakedastaging 
			SET jsondata = replace(jsondata::text, '"isnegrh_exposednewborn": true', '"isnegrh_exposednewborn": false')::json
				, updatedby = v_securityuserid
				, updatedon = now()
			WHERE intakenumber = v_intakenumber AND activeflag = 1;
		END IF;

   END IF;
  
  if(v_servicecaseid is not null) then

		update actor set activeflag = 0, updatedby = v_securityuserid, updatedon = now() where personid = v_personid and servicecaseid = v_servicecaseid;
		update intakeservicerequestactor set activeflag=0, updatedby = v_securityuserid, updatedon = now() where personid = v_personid and servicecaseid = v_servicecaseid;
        update personrole set activeflag = 0, updatedby = v_securityuserid, updatedon = now() where  personid = v_personid and  servicecaseid = v_servicecaseid;
		select actorid, intakeserviceid::varchar into v_actorid, vd_intakeserviceid  from actor where  personid = v_personid and 
				servicecaseid = v_servicecaseid limit 1;
		update intakeservicerequestactor set activeflag=0,updatedby = v_securityuserid, updatedon = now() where actorid=v_actorid;

		UPDATE cjams.personprogramarea
		SET updatedby = v_securityuserid, updatedon = now(), datatransferflag='D'::character varying, activeflag = 0
		where personid=v_personid and objectid in (v_servicecaseid::varchar, vd_intakeserviceid);
  
  	end if;

	select count(*) into v_personcount from intakeservicerequestactor where personid = v_personid and activeflag = 1;

	select count(*) into v_personadoptioncount from adoptioncaseactor where personid = v_personid and activeflag = 1;

	if(v_personcount = 0 and v_personadoptioncount = 0)
	then 
		update person set activeflag = 0, updatedby = v_securityuserid, updatedon = now() where personid = v_personid;
	end if;
  
  return 'SUCCESS';
end;


$function$;