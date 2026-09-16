DROP FUNCTION IF EXISTS cjams.insertupdatepersonrole(json, uuid, character varying, uuid, json, uuid, character varying);
CREATE OR REPLACE FUNCTION cjams.insertupdatepersonrole(v_personrole json, v_intakeserviceid uuid, v_intakenumber character varying, v_personid uuid, v_person json, v_personroleid uuid, v_securityuserid character varying, v_isheadofhousehold boolean)
 RETURNS text
 LANGUAGE plpgsql
AS $function$ 
declare
v_ractor record;
v_intakeservreactorid_rec record;
v_tempj record;
v_role json;
v_flag boolean default false;
v_tflag boolean default false;
v_actorid uuid;
v_personroletypeid uuid;
v_intakeservicerequestactorid uuid;
v_date timestamp without time zone;
v_servicecaseid uuid;
v_isadoptioncase boolean default false;
v_deletedactorids json;
v_result text;
v_rolelinkupdateforintake character varying;
v_rolelinkupdateforcps character varying;
v_rolelinkupdateforservicecase character varying;
v_fetalalcoholspctrmdisordflag int;
v_sexoffenderregisteredflag int;

-------------------------------------------------------------------------------------------------------
-- 04/01/2025 Veera Nadimpalli - CDM-44308 Bug in removing Investingation finding when multiple maltreatment types
-------------------------------------------------------------------------------------------------------

begin

v_date = now();

-- Adoption case flag
IF EXISTS (SELECT * FROM adoptioncase WHERE adoptioncaseid=v_intakeserviceid) THEN
	return 'success';
END IF;

CREATE TEMP TABLE IF NOT EXISTS
Temp_delete_person_role (
intakeservreactorid uuid, 
intakeservreqpersontypekey character varying
); 	

CREATE TEMP TABLE IF NOT EXISTS
Temp_update_person_role (
intakeservreactorid uuid, 
intakeservreqpersontypekey character varying
); 

v_servicecaseid = (v_person  ->> 'servicecaseid' ):: uuid;
IF v_servicecaseid IS NULL  and 'servicecase' = (v_person  ->> 'objecttype' ) THEN
  v_servicecaseid  = (v_person  ->> 'objectid') :: uuid;
END IF;

--Make sure the correct actor is filtered based on service case, intake etc.
--Migrated data will have 3 separate rows in actor each for service case, intake servcice request or intake
IF v_servicecaseid IS NOT NULL THEN
	v_intakeserviceid = NULL;
	v_intakenumber = NULL;
END IF;

IF v_intakeserviceid IS NOT NULL THEN
	v_intakenumber = NULL;
END IF;
v_fetalalcoholspctrmdisordflag = case when (v_person  -> 'drugexposedtypekey')::jsonb ? 'FASD' then 1 else 0 end;
v_sexoffenderregisteredflag = case when v_person  ->> 'sexoffenderregisteredflag' = 'true' THEN 1 else 0 END;

select ac.actorid into v_actorid from actor ac where   ac.personid = v_personid and (ac.intakeserviceid = v_intakeserviceid or ac.intakenumber= v_intakenumber or ac.servicecaseid = v_servicecaseid ) and ac.activeflag = 1;
	
FOR v_ractor IN select * from intakeservicerequestactor where personid = v_personid and (intakeserviceid = v_intakeserviceid or intakenumber = v_intakenumber or servicecaseid = v_servicecaseid ) and activeflag = 1
loop
	v_flag = false;
	FOR v_role IN SELECT * FROM json_array_elements(v_personrole)
	loop
		raise notice '%',  v_role  ->> 'roletype';
		if (v_ractor.intakeservicerequestpersontypekey = v_role  ->> 'roletype')
		then
			Insert into Temp_update_person_role (intakeservreactorid , intakeservreqpersontypekey)
			values (v_ractor.intakeservicerequestactorid,v_ractor.intakeservicerequestpersontypekey);
			IF(v_ractor.isheadofhousehold = v_isheadofhousehold and v_ractor.isprimary = (v_role  ->> 'isprimary')::boolean and v_ractor.drugexposednewbornflag = (v_person  ->> 'drugexposednewbornflag')::int4 and v_ractor.probationsearchconductedflag = (v_person  ->> 'probationsearchconductedflag')::int4
			and v_ractor.fetalalcoholspctrmdisordflag = v_fetalalcoholspctrmdisordflag and v_ractor.sexoffenderregisteredflag =v_sexoffenderregisteredflag) then 
				update intakeservicerequestactor set isprimary = (v_role  ->> 'isprimary')::boolean ,isheadofhousehold = v_isheadofhousehold, drugexposednewbornflag = (v_person  ->> 'drugexposednewbornflag')::int4,sexoffenderregisteredflag =v_sexoffenderregisteredflag ,probationsearchconductedflag = (v_person  ->> 'probationsearchconductedflag')::int4,
				fetalalcoholspctrmdisordflag = v_fetalalcoholspctrmdisordflag, updatedby = v_securityuserid, updatedon = now() where intakeservicerequestactorid = (v_ractor.intakeservicerequestactorid)::uuid;
			ELSE
				IF(v_servicecaseid is not null and (v_ractor.intakenumber is not null or v_ractor.intakeserviceid is not null)) then 
					INSERT INTO intakeservicerequestactor_history 
					SELECT gen_random_uuid (), *
					FROM intakeservicerequestactor 
					WHERE intakeservicerequestactorid = (v_ractor.intakeservicerequestactorid)::uuid;	
					IF(v_ractor.intakenumber is not null and v_ractor.intakeserviceid is not null) then 
						select rolelinkupdateforintake into v_rolelinkupdateforintake from cjams.rolelinkupdateforintake(v_ractor.intakenumber, v_securityuserid, v_ractor.intakeservicerequestactorid,null);
						select rolelinkupdateforcps into v_rolelinkupdateforcps from cjams.rolelinkupdateforcps(v_ractor.intakeserviceid, v_securityuserid, v_ractor.intakeservicerequestactorid,null,null);
						update intakeservicerequestactor set intakenumber = null, intakeserviceid = null, isprimary = (v_role  ->> 'isprimary')::boolean ,isheadofhousehold = v_isheadofhousehold, drugexposednewbornflag = (v_person  ->> 'drugexposednewbornflag')::int4,sexoffenderregisteredflag = v_sexoffenderregisteredflag,probationsearchconductedflag = (v_person  ->> 'probationsearchconductedflag')::int4,
						fetalalcoholspctrmdisordflag = v_fetalalcoholspctrmdisordflag, updatedby = v_securityuserid, updatedon = now() where intakeservicerequestactorid = (v_ractor.intakeservicerequestactorid)::uuid;
					elseif(v_ractor.intakenumber is not null) then 

						select rolelinkupdateforintake into v_rolelinkupdateforintake from cjams.rolelinkupdateforintake(v_ractor.intakenumber, v_securityuserid, v_ractor.intakeservicerequestactorid,null);
						update intakeservicerequestactor set intakenumber = null, isprimary = (v_role  ->> 'isprimary')::boolean ,isheadofhousehold = v_isheadofhousehold, drugexposednewbornflag = (v_person  ->> 'drugexposednewbornflag')::int4,sexoffenderregisteredflag = v_sexoffenderregisteredflag,probationsearchconductedflag = (v_person  ->> 'probationsearchconductedflag')::int4,
						fetalalcoholspctrmdisordflag = v_fetalalcoholspctrmdisordflag, updatedby = v_securityuserid, updatedon = now() where intakeservicerequestactorid = (v_ractor.intakeservicerequestactorid)::uuid;
						
					elseif(v_ractor.intakeserviceid is not null) then 
						select rolelinkupdateforcps into v_rolelinkupdateforcps from cjams.rolelinkupdateforcps(v_ractor.intakeserviceid, v_securityuserid, v_ractor.intakeservicerequestactorid,null,null);
						update intakeservicerequestactor set intakeserviceid = null, isprimary = (v_role  ->> 'isprimary')::boolean ,isheadofhousehold = v_isheadofhousehold, drugexposednewbornflag = (v_person  ->> 'drugexposednewbornflag')::int4,sexoffenderregisteredflag = v_sexoffenderregisteredflag,probationsearchconductedflag = (v_person  ->> 'probationsearchconductedflag')::int4,
						fetalalcoholspctrmdisordflag = v_fetalalcoholspctrmdisordflag, updatedby = v_securityuserid, updatedon = now() where intakeservicerequestactorid = (v_ractor.intakeservicerequestactorid)::uuid;	
					END If;

				ELSEIF(v_intakeserviceid is not null and (v_ractor.intakenumber is not null or v_ractor.servicecaseid is not null)) then
					INSERT INTO intakeservicerequestactor_history 
					SELECT gen_random_uuid (), *
					FROM intakeservicerequestactor 
					WHERE intakeservicerequestactorid = (v_ractor.intakeservicerequestactorid)::uuid;	
					IF(v_ractor.intakenumber is not null and v_ractor.servicecaseid is not null) then 
						select rolelinkupdateforintake into v_rolelinkupdateforintake from cjams.rolelinkupdateforintake(v_ractor.intakenumber, v_securityuserid, v_ractor.intakeservicerequestactorid,null);
						select rolelinkupdateforcps into v_rolelinkupdateforcps from cjams.rolelinkupdateforcps(v_intakeserviceid, v_securityuserid, v_ractor.intakeservicerequestactorid,null,null);
						update intakeservicerequestactor set intakenumber = null, intakeserviceid = null, updatedby = v_securityuserid, updatedon = now() where intakeservicerequestactorid = (v_ractor.intakeservicerequestactorid)::uuid;	
						update intakeservicerequestactor set isprimary = (v_role  ->> 'isprimary')::boolean ,isheadofhousehold = v_isheadofhousehold, drugexposednewbornflag = (v_person  ->> 'drugexposednewbornflag')::int4,sexoffenderregisteredflag = v_sexoffenderregisteredflag,probationsearchconductedflag = (v_person  ->> 'probationsearchconductedflag')::int4,
						fetalalcoholspctrmdisordflag = v_fetalalcoholspctrmdisordflag, updatedby = v_securityuserid, updatedon = now() where intakeservicerequestactorid = v_rolelinkupdateforcps::uuid;	
					elseif(v_ractor.intakenumber is not null) then 

						select rolelinkupdateforintake into v_rolelinkupdateforintake from cjams.rolelinkupdateforintake(v_ractor.intakenumber, v_securityuserid, v_ractor.intakeservicerequestactorid,null);
						update intakeservicerequestactor set intakenumber = null, isprimary = (v_role  ->> 'isprimary')::boolean ,isheadofhousehold = v_isheadofhousehold, drugexposednewbornflag = (v_person  ->> 'drugexposednewbornflag')::int4,sexoffenderregisteredflag = v_sexoffenderregisteredflag,probationsearchconductedflag = (v_person  ->> 'probationsearchconductedflag')::int4,
						fetalalcoholspctrmdisordflag = v_fetalalcoholspctrmdisordflag, updatedby = v_securityuserid, updatedon = now() where intakeservicerequestactorid = (v_ractor.intakeservicerequestactorid)::uuid;
						
					elseif(v_ractor.servicecaseid is not null) then 
						select * into v_rolelinkupdateforcps from cjams.rolelinkupdateforcps(v_intakeserviceid, v_securityuserid, v_ractor.intakeservicerequestactorid,null,null);
						update intakeservicerequestactor set intakeserviceid = null, updatedby = v_securityuserid, updatedon = now() where intakeservicerequestactorid = (v_ractor.intakeservicerequestactorid)::uuid;	
						update intakeservicerequestactor set isprimary = (v_role  ->> 'isprimary')::boolean ,isheadofhousehold = v_isheadofhousehold, drugexposednewbornflag = (v_person  ->> 'drugexposednewbornflag')::int4,sexoffenderregisteredflag = v_sexoffenderregisteredflag,probationsearchconductedflag = (v_person  ->> 'probationsearchconductedflag')::int4,
						fetalalcoholspctrmdisordflag = v_fetalalcoholspctrmdisordflag, updatedby = v_securityuserid, updatedon = now() where intakeservicerequestactorid = v_rolelinkupdateforcps::uuid;	
					END If;
					
				ELSEIF(v_intakenumber is not null and (v_ractor.intakeserviceid is not null or v_ractor.servicecaseid is not null)) then 
					INSERT INTO intakeservicerequestactor_history 
					SELECT gen_random_uuid (), *
					FROM intakeservicerequestactor 
					WHERE intakeservicerequestactorid = (v_ractor.intakeservicerequestactorid)::uuid;	
					IF(v_ractor.intakeserviceid is not null and v_ractor.servicecaseid is not null) then 
						select rolelinkupdateforintake into v_rolelinkupdateforintake from cjams.rolelinkupdateforintake(v_intakenumber, v_securityuserid, v_ractor.intakeservicerequestactorid,null);
						select rolelinkupdateforcps into v_rolelinkupdateforcps from cjams.rolelinkupdateforcps(v_ractor.intakeserviceid, v_securityuserid, v_ractor.intakeservicerequestactorid,null,null);
						update intakeservicerequestactor set intakenumber = null, intakeserviceid = null, updatedby = v_securityuserid, updatedon = now() where intakeservicerequestactorid = (v_ractor.intakeservicerequestactorid)::uuid;	
						update intakeservicerequestactor set isprimary = (v_role  ->> 'isprimary')::boolean ,isheadofhousehold = v_isheadofhousehold, drugexposednewbornflag = (v_person  ->> 'drugexposednewbornflag')::int4,sexoffenderregisteredflag = v_sexoffenderregisteredflag,probationsearchconductedflag = (v_person  ->> 'probationsearchconductedflag')::int4,
						fetalalcoholspctrmdisordflag = v_fetalalcoholspctrmdisordflag, updatedby = v_securityuserid, updatedon = now() where intakeservicerequestactorid = v_rolelinkupdateforintake::uuid;	
					elseif(v_ractor.intakeserviceid is not null) then 
						select rolelinkupdateforintake into v_rolelinkupdateforintake from cjams.rolelinkupdateforintake(v_intakenumber, v_securityuserid, v_ractor.intakeservicerequestactorid,null);
						update intakeservicerequestactor set intakenumber = null, updatedby = v_securityuserid, updatedon = now() where intakeservicerequestactorid = (v_ractor.intakeservicerequestactorid)::uuid;	
						update intakeservicerequestactor set isprimary = (v_role  ->> 'isprimary')::boolean ,isheadofhousehold = v_isheadofhousehold, drugexposednewbornflag = (v_person  ->> 'drugexposednewbornflag')::int4,sexoffenderregisteredflag = v_sexoffenderregisteredflag,probationsearchconductedflag = (v_person  ->> 'probationsearchconductedflag')::int4,
						fetalalcoholspctrmdisordflag = v_fetalalcoholspctrmdisordflag, updatedby = v_securityuserid, updatedon = now() where intakeservicerequestactorid = v_rolelinkupdateforintake::uuid;							
					elseif(v_ractor.servicecaseid is not null) then 
						select rolelinkupdateforintake into v_rolelinkupdateforintake from cjams.rolelinkupdateforintake(v_intakenumber, v_securityuserid, v_ractor.intakeservicerequestactorid,null);
						update intakeservicerequestactor set intakenumber = null, updatedby = v_securityuserid, updatedon = now() where intakeservicerequestactorid = (v_ractor.intakeservicerequestactorid)::uuid;	
						update intakeservicerequestactor set isprimary = (v_role  ->> 'isprimary')::boolean ,isheadofhousehold = v_isheadofhousehold, drugexposednewbornflag = (v_person  ->> 'drugexposednewbornflag')::int4,sexoffenderregisteredflag = v_sexoffenderregisteredflag,probationsearchconductedflag = (v_person  ->> 'probationsearchconductedflag')::int4,
						fetalalcoholspctrmdisordflag = v_fetalalcoholspctrmdisordflag, updatedby = v_securityuserid, updatedon = now() where intakeservicerequestactorid = v_rolelinkupdateforintake::uuid;	
					END If;		
				Else			
					update intakeservicerequestactor set isprimary = (v_role  ->> 'isprimary')::boolean ,isheadofhousehold = v_isheadofhousehold, drugexposednewbornflag = (v_person  ->> 'drugexposednewbornflag')::int4,sexoffenderregisteredflag = v_sexoffenderregisteredflag,probationsearchconductedflag = (v_person  ->> 'probationsearchconductedflag')::int4,
					fetalalcoholspctrmdisordflag = v_fetalalcoholspctrmdisordflag, updatedby = v_securityuserid, updatedon = now() where intakeservicerequestactorid = (v_ractor.intakeservicerequestactorid)::uuid;
				END IF;
			END IF;
			if ((v_role  ->> 'isprimary') :: integer = 1)  then
			update actor 
				set actortype = v_role  ->> 'roletype', ishouseholdmember = (v_person  ->> 'ishousehold')::int, updatedby = v_securityuserid,
				  updatedon = now() where actorid = v_actorid;
			end if;			
			v_flag = true;
		end if;		
	end loop;
	
	if v_flag = false
	then
			
		IF(v_servicecaseid is not null and (v_ractor.intakenumber is not null or v_ractor.intakeserviceid is not null)) then 
			INSERT INTO intakeservicerequestactor_history 
			SELECT gen_random_uuid (), *
			FROM intakeservicerequestactor 
			WHERE intakeservicerequestactorid = (v_ractor.intakeservicerequestactorid)::uuid;	
			select rolelinkupdateforservicecase into v_rolelinkupdateforservicecase from cjams.rolelinkupdateforservicecase(v_servicecaseid, v_securityuserid, v_ractor.intakeservicerequestactorid,v_personid,null);	
			update intakeservicerequestactor set servicecaseid = null, updatedby = v_securityuserid, updatedon = now() where intakeservicerequestactorid = (v_ractor.intakeservicerequestactorid)::uuid;
		ELSEIF(v_intakeserviceid is not null and (v_ractor.intakenumber is not null or v_ractor.servicecaseid is not null)) then
			INSERT INTO intakeservicerequestactor_history 
			SELECT gen_random_uuid (), *
			FROM intakeservicerequestactor 
			WHERE intakeservicerequestactorid = (v_ractor.intakeservicerequestactorid)::uuid;	 
			select rolelinkupdateforcps into v_rolelinkupdateforcps from cjams.rolelinkupdateforcps(v_intakeserviceid, v_securityuserid, v_ractor.intakeservicerequestactorid,v_personid,null);
			update intakeservicerequestactor set intakeserviceid = null, updatedby = v_securityuserid, updatedon = now() where intakeservicerequestactorid = (v_ractor.intakeservicerequestactorid)::uuid;
			if(v_ractor.intakeservicerequestpersontypekey = 'AV') then 
				update investigationmaltreatment
				set activeflag = 0, updatedby = v_securityuserid, updatedon = now()		
				where maltreatmentid = (select im.maltreatmentid
				from intakeservicerequest isr
				join investigation inv on inv.intakeserviceid = isr.intakeserviceid and inv.activeflag=1
				join investigationmaltreatment im on im.investigationid = inv.investigationid and im.activeflag=1
				join investigationmaltreatmentactor ima on ima.maltreatmentid = im.maltreatmentid and ima.activeflag=1
				join intakeservicerequestactor isra on isra.intakeservicerequestactorid = ima.intakeservicerequestactorid
				join person p on p.personid = isra.personid and p.activeflag = 1
				where isr.intakeserviceid = v_intakeserviceid and p.personid = v_personid and isr.activeflag=1 order by im.updatedon desc limit 1);
			end if;
		ELSEIF(v_intakenumber is not null and (v_ractor.intakeserviceid is not null or v_ractor.servicecaseid is not null)) then 
			INSERT INTO intakeservicerequestactor_history 
			SELECT gen_random_uuid (), *
			FROM intakeservicerequestactor 
			WHERE intakeservicerequestactorid = (v_ractor.intakeservicerequestactorid)::uuid;	
			update intakeservicerequestactor set intakenumber = null, updatedby = v_securityuserid, updatedon = now() where intakeservicerequestactorid = (v_ractor.intakeservicerequestactorid)::uuid; 
		ELSE 
			update intakeservicerequestactor set activeflag = 0, updatedby = v_securityuserid, updatedon = now() where intakeservicerequestactorid = (v_ractor.intakeservicerequestactorid)::uuid;
			update personroletype set activeflag = 0, updatedby = v_securityuserid, updatedon = now() where personroleid = (v_person ->> 'personroleid')::uuid and roletype = v_ractor.intakeservicerequestpersontypekey ;

			Insert into Temp_delete_person_role (intakeservreactorid,intakeservreqpersontypekey)
			values (v_ractor.intakeservicerequestactorid,v_ractor.intakeservicerequestpersontypekey);
  
			if(v_ractor.intakeservicerequestpersontypekey = 'AV') then 
				update investigationmaltreatment
				set activeflag = 0, updatedby = v_securityuserid, updatedon = now()		
				where maltreatmentid in (select im.maltreatmentid
				from intakeservicerequest isr
				join investigation inv on inv.intakeserviceid = isr.intakeserviceid and inv.activeflag=1
				join investigationmaltreatment im on im.investigationid = inv.investigationid and im.activeflag=1
				join investigationmaltreatmentactor ima on ima.maltreatmentid = im.maltreatmentid and ima.activeflag=1
				join intakeservicerequestactor isra on isra.intakeservicerequestactorid = ima.intakeservicerequestactorid
				join person p on p.personid = isra.personid and p.activeflag = 1
				where isr.intakeserviceid = v_intakeserviceid and p.personid = v_personid and isr.activeflag=1 order by im.updatedon desc);
			end if;
		END IF;
	end if;
end loop;

FOR v_role IN SELECT * FROM json_array_elements(v_personrole)
loop
	v_tflag = false;
	for v_tempj in SELECT * from Temp_update_person_role 
	loop
		if v_role ->> 'roletype' = v_tempj.intakeservreqpersontypekey then
			v_tflag = true;
		end if;
	end loop;
	if v_tflag = false then
		v_personroletypeid = gen_random_uuid();
		v_intakeservicerequestactorid = NULL;
		
		INSERT INTO personroletype ( personroletypeid, activeflag, personroleid, roletype, updatedby, updatedon, isprimary )
		VALUES (
		v_personroletypeid,
		1,
		v_personroleid,
		v_role  ->> 'roletype',
		v_securityuserid, 
		v_date,
		v_role  ->> 'isprimary');	
		
		if ((v_role  ->> 'isprimary') :: integer = 1)  then
			if v_actorid is null   
			then
				v_actorid = gen_random_uuid();
				INSERT INTO actor
				(actorid, activeflag, personid, actortype,insertedby, insertedon, updatedby, updatedon, "timestamp", medicaideligibility, blockgranteligibility, recipientstatus, manualupdateflag, intakeserviceid, iscollateralcontact, ismentalillness,mentalillnessdetail, ismentalimpair,mentalimpairdetail, ishouseholdmember, isdangertoworker,dangertoworkerreason,  sexoffenderregisteredflag, probationsearchconductedflag, drugexposednewbornflag, otherdrugs, personroletypeid, drugexposedkey,
				intakenumber,servicecaseid)
				values (
				v_actorid, 1, v_personid, v_role  ->> 'roletype', v_securityuserid, now(), v_securityuserid, now(),null, true, true, true,
				'N'::bpchar, v_intakeserviceid, (v_person  ->> 'iscollateralcontact')::int4, (v_person  ->> 'ismentalillness')::int4,v_person  ->> 'ismentalillnessReason',
				(v_person  ->> 'ismentalimpair')::int4,v_person  ->> 'ismentalimpairReason',(v_person  ->> 'ishousehold')::int, (v_person  ->> 'Dangerousworker')::int4,
				v_person  ->> 'DangerousWorkerReason',  case when v_person  ->> 'sexoffenderregisteredflag' = 'true' THEN 1 else 0 END, (v_person  ->> 'probationsearchconductedflag')::int4, 
				(v_person  ->> 'drugexposednewbornflag')::int4, v_person  ->> 'otherdrugs', v_personroletypeid, v_person  ->> 'drugexposedkey',v_intakenumber,v_servicecaseid);
			else 
				UPDATE actor  -- D-12021/ When person-profile-role is changed from 'collateral' to 'household' (vice versa), then 'actor' table needs to be updated.
				SET actortype = v_role  ->> 'roletype'  			
			     ,iscollateralcontact = (v_person  ->> 'iscollateralcontact')::int4
				 ,ishouseholdmember = (v_person  ->> 'ishousehold')::int
				 ,updatedby = v_securityuserid
				 ,updatedon = now()				
				WHERE actorid = v_actorid;
			end if;
		end if ;
		raise notice 'v_isheadofhousehold %',v_isheadofhousehold;
	    

		   	v_intakeservicerequestactorid = gen_random_uuid();	

		  	INSERT INTO intakeservicerequestactor
			(intakeservicerequestactorid, actorid, intakeservicerequestpersontypekey, insertedon, insertedby, updatedon, updatedby, intakeserviceid,
			reported, isprimary, personid, rcactiveflag, aractiveflag, practiveflag, drugexposednewbornflag,
			sexoffenderregisteredflag, probationsearchconductedflag,intakenumber,servicecaseid, fetalalcoholspctrmdisordflag,isheadofhousehold)
			VALUES(v_intakeservicerequestactorid, v_actorid, v_role  ->> 'roletype', now(),v_securityuserid, now(), v_securityuserid, v_intakeserviceid,
			true, (v_role  ->> 'isprimary')::boolean, v_personid, 1, 1, 1, (v_person  ->> 'drugexposednewbornflag')::int4,
			case when v_person  ->> 'sexoffenderregisteredflag' = 'true' THEN 1 else 0 END, (v_person  ->> 'probationsearchconductedflag')::int4,
			v_intakenumber,v_servicecaseid , case when (v_person  -> 'drugexposedtypekey')::jsonb ? 'FASD' then 1 else 0 end, v_isheadofhousehold );
			
			INSERT INTO actorrelationship
			(actorrelationshipid, relationshiptypekey, insertedby, insertedon, updatedby, updatedon, "timestamp", intakeserviceid, activeflag, intakeservicerequestactorid, effectivedate,intakenumber)
			VALUES(gen_random_uuid(), 'SELF', v_securityuserid, now(), v_securityuserid, now(), null,v_intakeserviceid, 1, v_intakeservicerequestactorid, now(),(v_person  ->> 'intakenumber'));
		
	end if;
end loop;

SELECT json_agg(ia)::json into v_deletedactorids FROM 
(select intakeservreactorid as intakeservicerequestactorid from Temp_delete_person_role) ia;

select * into v_result from updateintakeservicerequestactor(v_deletedactorids, v_intakeserviceid, v_intakenumber, v_personid, v_securityuserid, v_servicecaseid);

DROP TABLE Temp_update_person_role;
DROP TABLE Temp_delete_person_role;
return 'success';	
end
 $function$;
 