drop function if exists mdmpersonaddupdate(json,character varying);
CREATE OR REPLACE FUNCTION mdmpersonaddupdate(mdmpersondetails json, v_securityusersid character varying)
 RETURNS TABLE(cjamspid bigint, mdm_id character varying, message character varying)
 LANGUAGE plpgsql
AS $function$

	DECLARE
	v_mdmpersondetails json;
    v_mdmId varchar(50);
    v_personid uuid;
    v_mdmcount integer;
    v_personnames json;
    v_personaddress json;
    v_personphones json;
    v_personemail json;
    v_mdmgolderpersondetailsid uuid ;
    v_nameeffectivestartdate varchar(50);
    v_nameeffectiveenddate  varchar(50); 
    v_addresseffectivebegindate varchar(50);
    v_addresseffectiveenddate varchar(50);
    v_phoneeffectivebegindate varchar(50);
    v_phoneeffectiveenddate varchar(50);
    v_emaileffectivebegindate varchar(50);
    v_emaileffectiveenddate varchar(50);
    v_cjamspid int8;
    v_message varchar(50);
  
	
	
	BEGIN 
		
	v_mdmpersondetails := mdmpersondetails;
	v_mdmId :=  v_mdmpersondetails ->>'mdmId';
    v_personnames := v_mdmpersondetails-> 'names';
    v_personaddress := v_mdmpersondetails-> 'addresses';
    v_personphones := v_mdmpersondetails-> 'phones';
    v_personemail := v_mdmpersondetails-> 'emailAddresses';
	v_cjamspid := v_mdmpersondetails-> 'sourceKey';
   
   INSERT INTO mdmlog
( typeofpayload, payload, mdmid, activeflag, insertedby, insertedon, updatedby, updatedon, servicetype)
VALUES( 'request', v_mdmpersondetails::json, v_mdmId, 1, v_securityusersid, now(), v_securityusersid, now(), 'mdmgolden record');

 
	
	--select personid into v_personid from personidentifier  where personidentifiertypekey='MDM_ID' 
   -- and activeflag=1 and personidentifiervalue=v_mdmId order by insertedon desc limit 1;

   select p.personid into v_personid from person p where p.cjamspid = v_cjamspid 
   and activeflag=1 order by insertedon desc limit 1;

   select p.cjamspid into v_cjamspid from person p where p.personid=v_personid and p.activeflag=1 limit 1;
   
    select count(*) into v_mdmcount  from mdmgoldenpersondetails where personid=v_personid and mdmid=v_mdmId 
    and activeflag=1  limit 1;
	
  /*
	IF  (v_mdmcount > 0) THEN 
	  
	update mdmgoldenpersondetails set activeflag=0 where mdmid=v_mdmId;
    update mdmgoldenpersonaddress set activeflag=0 where mdmid=v_mdmId;
    update mdmgoldenpersonphones set activeflag=0 where mdmid=v_mdmId;
    update mdmgoldenpersonemails set activeflag=0 where mdmid=v_mdmId;
	 
	 END IF;
	
	*/
	
	INSERT INTO cjams.mdmgoldenpersondetails
	( mdmid, personid, sourcesystem, sourcekey, rolekey,
	dob, ssnno, tinnumber, aliennumber,
	ssnreferralcd, ssnverificationdate,
	eyecolortypekey, haircolortypekey, racetypekey,ethnicgrouptypekey,
	gendertypekey, maritalstatustypekey, domesticviolenceind,incarcerationind,
	dateofdeath, deathstatecd, deceasedindicator,ssnverificationcd,
	idfctnbirthdistinct, hearingimpaircd,visualimpaircd, dateofentry,
	languagecd, immigrationstatuscd,isuscitizen, driverlicensenumber,
	veteranstatus, driverlicensestate,irn,maid,
	maidsuffix, medicaidindicator, activeflag, updatedby, updatedon,
	insertedby, insertedon, effectivedate, expirationdate, old_id)
	VALUES( v_mdmId, (v_personid)::uuid, (v_mdmpersondetails->>'sourceSystem'),(v_mdmpersondetails->>'sourceKey'),(v_mdmpersondetails->>'role'),
	(v_mdmpersondetails->>'dateOfBirth')::date,(v_mdmpersondetails->>'ssn'),(v_mdmpersondetails->>'tinNumber'),(v_mdmpersondetails->>'alienNumber'),
	(v_mdmpersondetails->>'ssnReferalCd'),(v_mdmpersondetails->>'ssnVerificationDate')::date,
	(v_mdmpersondetails->>'eyeColor'),(v_mdmpersondetails->>'hairColor'),(v_mdmpersondetails->>'raceCd'),(v_mdmpersondetails->>'ethnicityCd'),
	(v_mdmpersondetails->>'genderCd'),(v_mdmpersondetails->>'maritalStatusCd'),(v_mdmpersondetails->>'domesticVoilenceInd'),(v_mdmpersondetails->>'incarcerationInd'),
	(v_mdmpersondetails->>'deathDate')::date,(v_mdmpersondetails->>'deathStateCd'),(v_mdmpersondetails->>'deceasedIndicator'),(v_mdmpersondetails->>'ssnVerificationCd'),
	(v_mdmpersondetails->>'idfctnBirthDistinct'),(v_mdmpersondetails->>'hearingImpairCd'),(v_mdmpersondetails->>'visualImpairCd'),(v_mdmpersondetails->>'dateOfEntry')::date,
	(v_mdmpersondetails->>'languageCd'),(v_mdmpersondetails->>'immigrationStatusCd'),(v_mdmpersondetails->>'usCtznshpInd'),(v_mdmpersondetails->>'driverLicenseNumber'),
	(v_mdmpersondetails->>'veteranStatus'),(v_mdmpersondetails->>'driverLicenseState'),(v_mdmpersondetails->>'irn'),(v_mdmpersondetails->>'maId'),
	(v_mdmpersondetails->>'maIdSuffix'),(v_mdmpersondetails->>'medicaidIndicator'),1,v_securityusersid,now(),
	v_securityusersid,now(),now(),null,null)RETURNING "mdmgolderpersondetailsid" INTO v_mdmgolderpersondetailsid ; 



	if jsonb_array_length( v_personnames::jsonb ) > 0 then
	
	for v_personnames in select
		*
	from
		json_array_elements(v_personnames)
			
	
		loop	
			 
		if (v_personnames->>'nameEffectiveStartDate') = '' then
		
		v_nameeffectivestartdate=null;
	       else
	
	    v_nameeffectivestartdate=(v_personnames->>'nameEffectiveStartDate');
	
		end if;
	
		if (v_personnames->>'nameEffectiveEndDate') = '' then
		
		v_nameeffectiveenddate=null;
	     else
	
	    v_nameeffectiveenddate=(v_personnames->>'nameEffectiveEndDate');
	   
		end if;
	
	insert 	into 	mdmgoldenpersonnames(nametypecode,
			prefixcode,
			lastname,
			middlename,
			firstname,
			suffixcode,
			fullname,
			nameeffectivestartdate,
			nameeffectiveenddate,
			updatedby,
			updatedon,
			insertedby,
			insertedon,
			activeflag,	
			effectivedate,
			personid,
			mdmgolderpersondetailsid)
		values (
		(v_personnames->>'nameTypeCode'),
		(v_personnames->>'prefixCode'),
		(v_personnames->>'lastName'),
		(v_personnames->>'middleName'),
		(v_personnames->>'firstName'),
		(v_personnames->>'sufixCode'),
		(v_personnames->>'fullName'),
		(v_nameeffectivestartdate)::timestamp,
		(v_nameeffectiveenddate)::timestamp,
		v_securityusersid,
		now(),
		v_securityusersid,
		now(),
		1,
		now(),
		(v_personid)::uuid,
		(v_mdmgolderpersondetailsid)::uuid
		);
	end loop;
	
	end if;


	
	if jsonb_array_length( v_personaddress::jsonb ) > 0 then
	
	for v_personaddress in select
		*
	from
		json_array_elements(v_personaddress)
			
	
		loop
		
		
		if (v_personaddress->>'addressEffectiveBeginDate') = '' then
		
		v_addresseffectivebegindate=null;
	       else
	
	    v_addresseffectivebegindate=(v_personnames->>'addressEffectiveBeginDate');
	
		end if;
	
		if (v_personnames->>'addressEffectiveEndDate') = '' then
		
		v_addresseffectiveenddate=null;
	     else
	
	    v_addresseffectiveenddate=(v_personnames->>'addressEffectiveEndDate');
	   
		end if;
		
		
	insert 	into 	mdmgoldenpersonaddress(personid,
			mdmid,
			addresstype,
			addressline1,
			addressline2,
			addresscity,
			addressstate,
			addresscounty,
			addresszip,
			addresscountry,
			addressprimary,
			addresseffectivebegindate,
			addresseffectiveenddate,
			updatedby,
			updatedon,
			insertedby,
			insertedon,
			activeflag,	
			effectivedate,
			mdmgolderpersondetailsid
			)
		values (
		(v_personid)::uuid,
		v_mdmId,
		(v_personaddress->>'addressType'),
		(v_personaddress->>'addressLine1'),
		(v_personaddress->>'addressLine2'),
		(v_personaddress->>'addressCity'),
		(v_personaddress->>'addressState'),
		(v_personaddress->>'addressCounty'),
		(v_personaddress->>'addressZip'),
		(v_personaddress->>'addressCountry'),
		(v_personaddress->>'addressPrimary'),
		(v_addresseffectivebegindate)::timestamp,
		(v_addresseffectiveenddate)::timestamp,
		v_securityusersid,
		now(),
		v_securityusersid,
		now(),
		1,
		now(),
		(v_mdmgolderpersondetailsid)::uuid
		);
	end loop;
	
	end if;
	

	
	if jsonb_array_length( v_personphones::jsonb ) > 0 then
	
	for v_personphones in select
		*
	from
		json_array_elements(v_personphones)
			
	
		loop
		
		
		if (v_personaddress->>'phoneEffectiveBeginDate') = '' then
		
		v_phoneeffectivebegindate=null;
	       else
	
	    v_phoneeffectivebegindate=(v_personnames->>'phoneEffectiveBeginDate');
	
		end if;
	
		if (v_personnames->>'phoneEffectiveEndDate') = '' then
		
		v_phoneeffectiveenddate=null;
	     else
	
	    v_phoneeffectiveenddate=(v_personnames->>'phoneEffectiveEndDate');
	   
		end if;
		
		
	insert 	into 	mdmgoldenpersonphones(personid,
			mdmid,
			phonetype,
			phonenumber,
			phonecountry,
			phoneextension,
			phoneeffectivebegindate,
			phoneeffectiveenddate,		
			updatedby,
			updatedon,
			insertedby,
			insertedon,
			activeflag,	
			effectivedate,
			mdmgolderpersondetailsid
			)
		values (
		(v_personid)::uuid,
		v_mdmId,
		(v_personphones->>'phoneType'),
		(v_personphones->>'phoneNumber'),
		(v_personphones->>'phoneCountry'),
		(v_personphones->>'phoneExtension'),
		(v_phoneeffectivebegindate)::timestamp,
		(v_phoneeffectiveenddate)::timestamp,
		v_securityusersid,
		now(),
		v_securityusersid,
		now(),
		1,
		now(),
		(v_mdmgolderpersondetailsid)::uuid
		);
	end loop;
	
	end if;
	 


---email
	
	
	if jsonb_array_length( v_personemail::jsonb ) > 0 then
	
	for v_personemail in select
		*
	from
		json_array_elements(v_personemail)
			
	
		loop
		
		if (v_personaddress->>'emailEffectiveBeginDate') = '' then
		
		v_emaileffectivebegindate=null;
	       else
	
	    v_emaileffectivebegindate=(v_personnames->>'emailEffectiveBeginDate');
	
		end if;
	
		if (v_personnames->>'emailEffectiveEndDate') = '' then
		
		v_emaileffectiveenddate=null;
	     else
	
	    v_emaileffectiveenddate=(v_personnames->>'emailEffectiveEndDate');
	   
		end if;
		
	insert 	into 	mdmgoldenpersonemails(personid,
			mdmid,
			emailtype,
			emailaddress,
			emaildonotcontact,
			emailprimary,
			emaileffectivebegindate,
			emaileffectiveenddate,		
			updatedby,
			updatedon,
			insertedby,
			insertedon,
			activeflag,	
			effectivedate,
			mdmgolderpersondetailsid
			)
		values (
		(v_personid)::uuid,
		v_mdmId,
		(v_personemail->>'emailType'),
		(v_personemail->>'emailAddress'),
		(v_personemail->>'emailDoNotContact'),
		(v_personemail->>'emailPrimary'),
		(v_emaileffectivebegindate)::timestamp,
		(v_emaileffectiveenddate)::timestamp,	
		v_securityusersid,
		now(),
		v_securityusersid,
		now(),
		1,
		now(),
		(v_mdmgolderpersondetailsid)::uuid
		);
	end loop;
	
	end if;


INSERT INTO mdmlog
( typeofpayload, payload, mdmid, activeflag, insertedby, insertedon, updatedby, updatedon, servicetype)
VALUES( 'response', v_mdmpersondetails::json, v_mdmId, 1, v_securityusersid, now(), v_securityusersid, now(), 'mdmgolden record');

   v_message:='Sucess';
			
     RETURN query select v_cjamspid,v_mdmId,v_message;
	END;

$function$
