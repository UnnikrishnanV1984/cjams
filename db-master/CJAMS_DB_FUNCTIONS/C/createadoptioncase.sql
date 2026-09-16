DROP FUNCTION IF EXISTS cjams.createadoptioncase(v_adoptionplanningid uuid, v_servicecaseid uuid, v_casedata jsonb, v_userid character varying, v_assigntoid character varying);
CREATE OR REPLACE FUNCTION cjams.createadoptioncase(v_adoptionplanningid uuid, v_servicecaseid uuid, v_casedata jsonb, v_userid character varying, v_assigntoid character varying)
 RETURNS TABLE(servicecaseno character varying, caseid uuid, newpersonid uuid, parent1id uuid, parent2id uuid, message character varying)
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------------------------------------------
-- Revision(s) 
-- 09/17/2021 Vineet Tirodkar - To update Adoption Finalization Date as Start Date in IV-E Table (CDM-15927)

-- 09-01 - Addded agreementtyperefid field for the story CIDM-5203
-- 03-20/2023 Mounika Gudise- Addded isbioadoptedflag column to check whether the client is biocase or not (CIDM-6864)
-- 06/08/2023 - Vineet Tirodkar - To generate Adoption case creation Notification to Adoption Worker (CIDM-1181)
-- 07/25/2023 - Vineet Tirodkar - To update the Substance Class and Historic SEN info (CDM-33182)
-- 08/22/2023 - Vineet Tirodkar - To add Adoptive Parents (using the same CJAMS PIDs) from the CJAMS Provider Module(CIDM-7695) 
-- 09-06 - Sybtax error fix
--  07/16/2024- Umasankar Raavi --CIDM-9029-Person profile -Added new column othergendertypekey
--  03/19/2024- Manasa Kasula --CIDM-10291-Person profile client flag should remain same.
--  12/22/2025 - Vinesh Puthan -- CIDM-10967 Fix for Bioclient CISID is getting updated in the adopted client
------------------------------------------------------------------------------------------------------------	
DECLARE l_personid uuid;
	l_personname character varying(100);
	l_adoptioncaseid uuid;
	l_adoptioncase_adoptionagreementid uuid;
	l_adoptioncasenumber character varying(20) ;
	l_response text;
	l_supervisor character varying(100);
	v_persondata json;
	v_person  json;
	v_addressdata  json;
	v_contactsdata  json;
	v_address  json;
	v_contacts  json;
	l_parent1personid uuid;
	l_parent2personid uuid;
	v_ag record;
	v_oldpersonid uuid;
	--v_providerlastname character varying(100);
	v_parent1firstname character varying(100);
	v_parent1lastname character varying(100);
	v_parent2firstname character varying(100);
	v_parent2lastname character varying(100);
	l_programkey character varying;
	l_subprogramkey character varying;
	l_fromteamid uuid;
	l_toteamid uuid;
	l_fromldssid uuid;
	l_toldssid uuid;
	l_assignedsecurity character varying;
	l_responsibilitytypekey character varying;
	l_finaldate DATE;
	v_careergoalid uuid;
	v_personemployerdetailid uuid;
	l_ppareferenceid uuid;
	v_caseid bigint;
	v_clientid bigint;
	v_tousersid RECORD;
	v_username character varying;
	v_msg character varying;
	v_notifystatus character varying; 
	v_parents character varying;  
	v_cnt integer;
	l_startdate timestamp;

	v_adoptiveparent1id bigint; 
	v_adoptiveparent2id bigint;
	v_parent1providerid bigint; 
	v_parent2providerid bigint;
	v_provider_approval_id bigint; --@TM: 2020-11-12 - To fetch unique values from prov approval person tbl
	
	l_parent1id uuid;
	l_parent2id uuid;
	v_provider2id bigint;
	
	v_applicantid uuid;
	v_applicant_clientflag bigint;
	v_applicant_MDM_ID character varying;

	v_co_applicantid uuid;
	v_co_applicant_clientflag bigint;
	v_co_applicant_MDM_ID character varying;		
	
BEGIN

    select 1, adoptioncasenumber, adoptioncaseid, null 
		into v_cnt, l_adoptioncasenumber, l_adoptioncaseid, l_personid 
	from adoptioncase a where adoptionplanningid = v_adoptionplanningid and activeflag = 1;

    if v_cnt > 0 then
      RETURN QUERY  
      SELECT l_adoptioncasenumber, l_adoptioncaseid, l_personid, 'Failed':: character varying;
	else
		/*SELECT isr.insertedby INTO l_supervisor FROM adoptionplanning ap
		INNER JOIN intakeservicerequest isr ON isr.servicecaseid = ap.servicecaseid
		WHERE ap.adoptionplanningid = v_adoptionplanningid;*/
		v_parent1firstname:='';
		v_parent1lastname:='';
		v_parent2firstname:='';
		v_parent2lastname:='';
      
		RAISE  NOTICE  ' >>>v_parent1firstname%',v_parent1firstname;
		RAISE  NOTICE  ' >>>v_parent1lastname%',v_parent1lastname;
		RAISE  NOTICE  ' >>>v_parent2firstname%',v_parent2firstname;
		RAISE  NOTICE  ' >>>v_parent2lastname%',v_parent2lastname;
      
		SELECT TB.provider_first_nm, TB.provider_last_nm, TB.co_first_nm, TB.co_last_nm
			INTO v_parent1firstname, v_parent1lastname, v_parent2firstname, v_parent2lastname
		FROM tb_provider TB WHERE TB.provider_id in (select parent1providerid from adoptionagreement ag where ag.adoptionplanningid=v_adoptionplanningid and activeflag = 1);

		RAISE  NOTICE  ' >>>v_parent1firstname%',v_parent1firstname;
		RAISE  NOTICE  ' >>>v_parent1lastname%',v_parent1lastname;
		RAISE  NOTICE  ' >>>v_parent2firstname%',v_parent2firstname;
		RAISE  NOTICE  ' >>>v_parent2lastname%',v_parent2lastname;
         
         
		--SELECT split_part(ag.parent1providername, ' ', 2) from adoptionagreement ag where ag.adoptionplanningid=v_adoptionplanningid INTO v_providerlastname;
		IF v_parent1lastname is null THEN                     
          v_parent1lastname := '';
        END IF;
		/*
		IF v_providerlastname is null THEN                     
          v_providerlastname := '';
        END IF;
        */
		SELECT  fromsecurityusersid::CHARACTER VARYING,teamid INTO l_supervisor,l_fromteamid
		FROM  routing r 
			INNER JOIN adoptionbreakthelink abl ON abl.adoptionbreakthelinkid::character varying = r.objectid
		WHERE   eventcode ='ABLR' 
			AND r.routingstatustypeid = 16
			AND abl.adoptionplanningid = v_adoptionplanningid
			AND r.activeflag =1
		ORDER BY r.insertedon DESC LIMIT 1; 

	    /*Get Program area for adoption from configuration */
		SELECT programkey, subprogramkey INTO l_programkey, l_subprogramkey FROM programareaconfig WHERE LOWER(servicerequestsubtypekey) = 'adoption' AND isdefault =1 limit 1;

		--Start Adoption case changes
		--Create Adoption case and update adoptioncase id in adoptionagreement, get rid of adoptionplanning from adoptioncase table
		INSERT INTO adoptioncase 
		(adoptionplanningid,alternateid,startdate,enddate,statustypekey,insertedby,updatedby)
		SELECT 
		v_adoptionplanningid, ap.alternateid::bigint, ag.startdate, ag.enddate,'Open', v_userid, v_userid
		FROM  
		adoptionplanning ap, adoptionagreement ag
		WHERE 
		ap.adoptionplanningid = ag.adoptionplanningid
		AND
		ap.adoptionplanningid = v_adoptionplanningid and ap.activeflag = 1 and ag.activeflag= 1 ORDER BY ag.insertedon DESC LIMIT 1
		RETURNING    "adoptioncaseid" , "adoptioncasenumber" , "startdate" INTO l_adoptioncaseid, l_adoptioncasenumber, l_startdate;

		INSERT INTO adoptioncaseagreement
		(adoptioncaseid, isofferedsubsidy, offeraccepteddate, startdate, enddate, finalizationdate, isunderappeal, parent1signdate, parent2signdate, ldssdate, issubsidypaid, activeflag, effectivedate, insertedby, insertedon, updatedby, updatedon, old_id, ismedassist, parent1providerid, parent2providerid, parent1providername, parent2providername, alternateid, issingleparent, singleparentadoptioncheck, adoptiveparent1signature, adoptiveparent2signature, ldssdirectorsignature, agreementcomments, childplacedby, childplacedfrom,agreementtyperefid, providerid, adoptiveparent1id, adoptiveparent2id)
		SELECT 
		l_adoptioncaseid, isofferedsubsidy, offeraccepteddate, startdate, enddate, finalizationdate, isunderappeal, parent1signdate, parent2signdate, ldssdate, issubsidypaid, activeflag, effectivedate, insertedby, now(), updatedby, now(), old_id, ismedassist, parent1providerid, parent2providerid, parent1providername, parent2providername, alternateid, issingleparent, singleparentadoptioncheck, adoptiveparent1signature, adoptiveparent2signature, ldssdirectorsignature, agreementcomments, childplacedby, childplacedfrom,agreementtyperefid, providerid, adoptiveparent1id, adoptiveparent2id
		FROM 
		adoptionagreement
		WHERE 
		adoptionplanningid = v_adoptionplanningid
		AND
		activeflag = 1 ORDER BY insertedon DESC LIMIT 1
		RETURNING "adoptionagreementid" INTO l_adoptioncase_adoptionagreementid;

		INSERT INTO routing
		(eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype)
		SELECT 
		eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, l_adoptioncase_adoptionagreementid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype
		FROM 
		routing
		WHERE routing.routingstatustypeid = 16 
		AND routing.eventcode::text = 'ASAR'::text 
		AND routing.activeflag = 1 
		AND routing.objectid::text = (
		SELECT adoptionagreementid FROM adoptionagreement WHERE adoptionplanningid = v_adoptionplanningid and activeflag = 1 ORDER BY insertedon DESC LIMIT 1
		)::text;

		INSERT INTO adoptioncaseagreementrate
		(adoptionagreementid, startdate, enddate, provider_id, paymentamout, isapproval, approvaldate, isspeacialneeds, parent1actorid, parent2actorid, childrelationship, notes, activeflag, effectivedate, insertedby, insertedon, updatedby, updatedon, old_id, specialneedtypekey, specialneedremarks, transactiondate, rateoverwrittensw,status)
		SELECT 
		l_adoptioncase_adoptionagreementid, startdate, enddate, provider_id, paymentamout, isapproval, approvaldate, isspeacialneeds, parent1actorid, parent2actorid, childrelationship, notes, activeflag, effectivedate, insertedby, now(), updatedby, now(), old_id, specialneedtypekey, specialneedremarks, transactiondate, rateoverwrittensw,status
		FROM 
		adoptionagreementrate
		WHERE 
		adoptionagreementid = (
		-- SELECT adoptionagreementid FROM adoptionagreement WHERE adoptionplanningid = v_adoptionplanningid limit 1 /*subqry return more than one value to resolve this error limit 1 added */
		SELECT adoptionagreementid FROM adoptionagreement WHERE adoptionplanningid = v_adoptionplanningid and activeflag = 1 limit 1 /*subqry return more than one value to resolve this error limit 1 added */
		);

		--End of Adoption case changes
  
		v_persondata:= v_casedata;
        
        RAISE  NOTICE  'v_persondata%',v_casedata;
    
		FOR  v_person  IN  SELECT  *  FROM    json_array_elements(v_persondata)  loop

			v_oldpersonid:= v_person->>'personid';
			/*
			 
			INSERT INTO person (firstname,lastname,middlename,dob,gendertypekey,everbeenadoptedflag,
								activeflag,insertedby,updatedby) 
				values (
					substring(v_person->>'firstname',1,49),
					--substring(v_person->>'lastname',1,49),
					--substring(v_providerlastname,1,49),
					v_parent1lastname,
					v_person->>'middlename',
					(v_person->>'dob')::timestamp,
					v_person->>'gendertypekey',
					1,
					1,
					v_userid,
					v_userid
				)RETURNING    "personid" INTO l_personid;
			
			*/
		   
			/* Profile */

			update person 
			set isbioadoptedflag = 1, updatedby = v_userid, updatedon = now() where personid = v_oldpersonid;

			INSERT INTO cjams.person
			( activeflag, principalident, firstname, lastname, middlename, salutation, suffix, dangerlevel, dangerreason, updatedby, updatedon, insertedby,
			 insertedon, effectivedate, expirationdate, old_id, "timestamp", dob, religiontypekey, maritalstatustypekey, gendertypekey, racetypekey, 
			 deceaseddate, ethnicgrouptypekey, incometypekey, interpreterrequired, firstnamesoundex, lastnamesoundex, ssnverified, userphoto, refusessn,
			 refusedob, dangertoself, dangertoselfreason, personphysicalattributetypeid, maidenname, socialmediasource, dateofdeath, prefx, occupation,
			 deceased, stateid, fein, complaintnumber, cjisnumber, petitionid, tribalassociation, physicalattributes, isdraft, strengths, needs, 
			 nationalitytypekey, isapproxdod, primarylanguageid, secondarylanguageid, livingsituationkey, licensedfacilitykey, otherlicensedfacility, 
			 livingsituationdesc, reporteranonymousflag, url, expungementflag, dobflag, nameunknownflag, actiontypekey, adoptedflag, everbeenadoptedflag,
			 sysdetadptflag, previousadoptionagetypekey, confirmationentitytypekey, clientflag, approximateageno, ssnno, citizenalenagetypekey,
			 alienregistrationtext, doddate, physicalbuildtypekey, skintonetypekey, eyecolortypekey, haircolortypekey, hairtexturetypekey,
			 distinguishedcomments, criminalrecordflag, stateverifieddate, countytypekey, primarycitizenshiptypekey, seccitizenshiptypekey, providerid,
			 datepictaken, datavalidflag, outofstateflag, disabilityflag, afcarsageoutflag, afcarsperiodsent, fetalalcoholspctrmdisordflag,
			 substanceexposednewbornflag, otherdrugs, substanceexposednewbornsourcetypekey, substanceexposednewbornsourceid,
			 substanceexposednewborntimetamp, isapproxdob, otherprimarylanguagetypekey, citizenalenageflag,othergendertypekey, otherreligion, isqualifiedalien, 
			 verificationremarks, alienstatustypekey, safehavenbabyflag, fk_id, personflag, isuscitizen, preadoptiondate, aname, hairtextureotherdesc,
			 haircolorotherdesc, isglasses, employername, clienttitle, biologicalmothermarriedsw,
			 substanceclasses, othersubstances, senstatusflag)

			SELECT 1, principalident, firstname, v_parent1lastname, middlename, salutation, suffix, dangerlevel, dangerreason, v_userid, now(), v_userid,
			 now(), now(), null, old_id, "timestamp", dob, religiontypekey, maritalstatustypekey, gendertypekey, racetypekey, 
			 deceaseddate, ethnicgrouptypekey, incometypekey, interpreterrequired, firstnamesoundex, lastnamesoundex, false, userphoto, refusessn,
			 refusedob, dangertoself, dangertoselfreason, personphysicalattributetypeid, maidenname, socialmediasource, dateofdeath, prefx, occupation,
			 deceased, stateid, fein, complaintnumber, cjisnumber, petitionid, tribalassociation, physicalattributes, isdraft, strengths, needs, 
			 nationalitytypekey, isapproxdod, primarylanguageid, secondarylanguageid, livingsituationkey, licensedfacilitykey, otherlicensedfacility, 
			 livingsituationdesc, reporteranonymousflag, url, expungementflag, dobflag, nameunknownflag, actiontypekey, adoptedflag, 1,
			 sysdetadptflag, previousadoptionagetypekey, confirmationentitytypekey, clientflag, approximateageno, null, citizenalenagetypekey,
			 alienregistrationtext, doddate, physicalbuildtypekey, skintonetypekey, eyecolortypekey, haircolortypekey, hairtexturetypekey,
			 distinguishedcomments, criminalrecordflag, stateverifieddate, countytypekey, primarycitizenshiptypekey, seccitizenshiptypekey, providerid,
			 datepictaken, datavalidflag, outofstateflag, disabilityflag, afcarsageoutflag, afcarsperiodsent, fetalalcoholspctrmdisordflag,
			 substanceexposednewbornflag, otherdrugs, substanceexposednewbornsourcetypekey, substanceexposednewbornsourceid,
			 substanceexposednewborntimetamp, isapproxdob, otherprimarylanguagetypekey, citizenalenageflag, othergendertypekey, otherreligion, isqualifiedalien, 
			 verificationremarks, alienstatustypekey, safehavenbabyflag, fk_id, personflag, isuscitizen, l_startdate::timestamp, aname, hairtextureotherdesc,
			 haircolorotherdesc, isglasses, employername, clienttitle, biologicalmothermarriedsw,
			 substanceclasses, othersubstances, senstatusflag
			FROM person where  personid = v_oldpersonid returning "personid", cjamspid INTO l_personid, v_clientid ;


			INSERT INTO personracetypemap
			(personracetypemapid, personid, racetypekey, activeflag, updatedby, updatedon, insertedby, insertedon, effectivedate, expirationdate, old_id)
			SELECT gen_random_uuid(), l_personid, racetypekey, 1, v_userid, now(), v_userid, now(), now(), null, old_id
			FROM personracetypemap where  personid = v_oldpersonid and activeflag=1 ;

			INSERT INTO personphysicalattribute
			( personid, physicalattributetypekey, attributevalue, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, old_id)
			SELECT  l_personid, physicalattributetypekey, attributevalue, 1, v_userid, now(), v_userid, now(), now(), null, old_id
			FROM personphysicalattribute where  personid = v_oldpersonid and activeflag=1 ;
			 
			-- INSERT INTO personidentifier
			-- ( personid, personidentifiertypekey, personidentifiervalue, updatedby, updatedon, insertedby, insertedon, activeflag, effectivedate, expirationdate, old_id)
			-- SELECT  l_personid, personidentifiertypekey, personidentifiervalue, v_userid, now(), v_userid, now(), 1, now(), null, old_id
			-- FROM personidentifier where  personid = v_oldpersonid and activeflag=1  and UPPER(personidentifiertypekey) not in ('SSN', 'MDM_ID');


			INSERT INTO alias
			( activeflag, personid, firstname, lastname, middlename, sfxname, updatedby, updatedon, insertedby, insertedon,
			effectivedate,  "timestamp", dcn, ssn, licenseno, old_id, akaid, akatypetypekey, prefixtypekey, fnamesoundex, 
			lnamesoundex, formattedmiddlename, formattedfirstname, firstnamesoundex, formattedlastname, lastnamesoundex,
			datavalidflag, mergeindflag, retiredclientid, discovereddate, clientmergeid, fk_id, nametypecode)
			SELECT  1, l_personid, firstname, lastname, middlename, sfxname, v_userid,  now(), v_userid,  now(),
			now(),  "timestamp", dcn, ssn, licenseno, old_id, akaid, akatypetypekey, prefixtypekey, fnamesoundex,
			lnamesoundex, formattedmiddlename, formattedfirstname, firstnamesoundex, formattedlastname, lastnamesoundex, 
			datavalidflag, mergeindflag, retiredclientid, discovereddate, clientmergeid, fk_id, nametypecode
			FROM alias where  personid = v_oldpersonid and activeflag=1 ;

			INSERT INTO personmaritalstatus
			(personmaritalstatusid, fk_id, datesunknownflag, startdate, enddate, marriageplace, divorceplace, prefixtypekey, firstname, middlename, lastname,
			suffixtypekey, informallivingcomments, childrenno, statustypekey, insertedon, insertedby, updatedon, updatedby, activeflag, adrhomephone,
			adrworkphone, adrworkxtn, adrpager, adremail, adrfax, adrcellphone, adrurl, adrothercontact, expungementflag, datavalidflag, clientmergeid,
			old_id, personid)
			SELECT gen_random_uuid(), fk_id, datesunknownflag, startdate, enddate, marriageplace, divorceplace, prefixtypekey, firstname, middlename, lastname,
			suffixtypekey, informallivingcomments, childrenno, statustypekey,  now(), v_userid,  now(), v_userid, 1, adrhomephone,
			adrworkphone, adrworkxtn, adrpager, adremail, adrfax, adrcellphone, adrurl, adrothercontact, expungementflag, datavalidflag, clientmergeid,
			old_id, l_personid FROM personmaritalstatus where  personid = v_oldpersonid and activeflag=1  order by insertedon desc limit 1 ;

			/* Person  Employment   */     

			insert into personworkcarrergoal
			(personid,careergoals,activeflag,updatedby,updatedon,insertedby,insertedon,effectivedate)
			 select l_personid,careergoals,1,v_userid,now(),v_userid,now(),now() from personworkcarrergoal 
			 where   personid = v_oldpersonid and activeflag=1 order by insertedon desc limit 1 returning personworkcarrergoalid into v_careergoalid;
				
			insert into personemployerdetail
			(personid,employername,currentemployer,noofhours,duties,startdate,enddate,
			reasonforleaving,activeflag,updatedby,updatedon,insertedby,insertedon,effectivedate,personworkcarrergoalid)
			select l_personid,employername,currentemployer,noofhours,duties,startdate,enddate,
			reasonforleaving,1,v_userid,now(),v_userid,now(),now(),v_careergoalid
			from personemployerdetail where   personid = v_oldpersonid and activeflag=1 order by insertedon desc limit 1 returning personemployerdetailid into v_personemployerdetailid;
				  
			INSERT INTO cjams.personemployment
			( employername, supervisorprefixtypekey, supervisorfirstname, supervisormiddlename, supervisorlastname, 
			supervisorsuffixtypekey, clienttitle, startdate, enddate, workschedule, emplymenttypekey, income, wagefreqtypekey, addresstypekey,
			 formattypekey, streetnumber, boxnumber, predirtypekey, streetname, streetsuffixtypekey, postdirtypekey, unittypekey, unitnumbertx, 
			 cityname, countytypekey, statetypekey, zip5no, zip4no, direction, foreignaddress, workphone, workextn, homephone, pager, email, fax, mobile,
			 url, othercontacts, insertedon, insertedby, updatedon, updatedby, activeflag, foreignstate, country, postalcode, streetnotes, 
			 employernumber, expungementflag, datavalidflag, clientmergeid, old_id, personid, promotedemploymentprogramname,
			 promotedemploymentprogramstartdate, employedhourspermonth, address1, address2, promotedemploymentprogramenddate, promotedemploymentnarrative,
			 promotedemploymentflag, personemployerdetailsid)
			 SELECT  employername, supervisorprefixtypekey, supervisorfirstname, supervisormiddlename, supervisorlastname,
			 supervisorsuffixtypekey, clienttitle, startdate, enddate, workschedule, emplymenttypekey, income, wagefreqtypekey, addresstypekey,
			 formattypekey, streetnumber, boxnumber, predirtypekey, streetname, streetsuffixtypekey, postdirtypekey, unittypekey, unitnumbertx, 
			 cityname, countytypekey, statetypekey, zip5no, zip4no, direction, foreignaddress, workphone, workextn, homephone, pager, email, fax, mobile,
			 url, othercontacts,  now(), v_userid,  now(), v_userid, 1, foreignstate, country, postalcode, streetnotes,
			 employernumber, expungementflag, datavalidflag, clientmergeid, old_id, l_personid, promotedemploymentprogramname,
			 promotedemploymentprogramstartdate, employedhourspermonth, address1, address2, promotedemploymentprogramenddate, promotedemploymentnarrative,
			 promotedemploymentflag, v_personemployerdetailid FROM personemployment where  personid = v_oldpersonid and activeflag=1 ;

			-- Education info
			INSERT INTO personeducation
				(personid, educationname, educationtypekey, countyid, statecode, startdate, enddate, lastgradetypekey, currentgradetypekey, isspecialeducation, specialeducationtypekey, absentdate, isreceived, isverified, isexcuesed, activeflag, effectivedate, expirationdate, insertedby, updatedby, insertedon, updatedon, extracurricular, schoolid, clientid, contactname, schoolsettingtypekey, schoolschedule, schooladjustment, functioninggradetypekey, intensitylevelno, "comments", statustypekey, performance, strengths, weaknesses, adrformattypekey, adrstreetno, adrboxno, adrpredirtypekey, adrstreetname, adrstreetsuffixtypekey, adrpostdirtypekey, adrunittypetypekey, adrunitno, adrcityname, adrzip5no, adrzip4no, adrdirection, adrforeign, adrworkphone, adrworkxtn, adrhomephone, adrpager, adremail, adrfax, adrcellphone, adrurl, adrothercontact, educationstatustypekey, lastiepdate, lastattendeddate, withdrawaldate, secondaryby19flag, transportmodetypekey, adrforeignstate, adrcountry, adrpostalcode, classtypetypekey, firstqtrperformancetypekey, secondqtrperformancetypekey, thirdqtrperformancetypekey, fourthqtrperformancetypekey, extracurricularactivities, educationproggoal, adrstreet, expungementflag, paytill22typekey, datavalidflag, clientmergeid, educationstatusdate, schoolchangeforplcmnttypekey, schoolchangereason, hospitaledusrv, schoolexitcomments, paytill22educhkflag, paytill22enrollchkflag, paytill22emppgmchkflag, paytill22emp80hrchkflag, paytill22medchkflag, paytill22medchk, adresscounty, disciplinaryactioncomments, speacialeducationrestrictivekey, currentgradelevel, functioninggradelevel, lastgradelevel, highestgradetypekey, summerschoolname, firstqtrabsenceexcused, firstqtrabsencenotexcused, firstqtrabsencetardy, firstqtrabsence, secondqtrabsenceexcused, secondqtrabsencenotexcused, secondqtrabsencetardy, secondqtrabsence, thirdqtrabsenceexcused, thirdqtrabsencenotexcused, thirdqtrabsencetardy, thirdqtrabsence, fourthqtrabsenceexcused, fourthqtrabsencenotexcused, fourthqtrabsencetardy, fourthqtrabsence, numberofabsences, lastifspdate, ifsplastdate, transportmodetypedetail, sasidno)
			SELECT
				 l_personid, educationname, educationtypekey, countyid, statecode, startdate, enddate, lastgradetypekey, currentgradetypekey, isspecialeducation, specialeducationtypekey, absentdate, isreceived, isverified, isexcuesed, activeflag, effectivedate, expirationdate, insertedby, updatedby, insertedon, updatedon, extracurricular, schoolid, clientid, contactname, schoolsettingtypekey, schoolschedule, schooladjustment, functioninggradetypekey, intensitylevelno, "comments", statustypekey, performance, strengths, weaknesses, adrformattypekey, adrstreetno, adrboxno, adrpredirtypekey, adrstreetname, adrstreetsuffixtypekey, adrpostdirtypekey, adrunittypetypekey, adrunitno, adrcityname, adrzip5no, adrzip4no, adrdirection, adrforeign, adrworkphone, adrworkxtn, adrhomephone, adrpager, adremail, adrfax, adrcellphone, adrurl, adrothercontact, educationstatustypekey, lastiepdate, lastattendeddate, withdrawaldate, secondaryby19flag, transportmodetypekey, adrforeignstate, adrcountry, adrpostalcode, classtypetypekey, firstqtrperformancetypekey, secondqtrperformancetypekey, thirdqtrperformancetypekey, fourthqtrperformancetypekey, extracurricularactivities, educationproggoal, adrstreet, expungementflag, paytill22typekey, datavalidflag, clientmergeid, educationstatusdate, schoolchangeforplcmnttypekey, schoolchangereason, hospitaledusrv, schoolexitcomments, paytill22educhkflag, paytill22enrollchkflag, paytill22emppgmchkflag, paytill22emp80hrchkflag, paytill22medchkflag, paytill22medchk, adresscounty, disciplinaryactioncomments, speacialeducationrestrictivekey, currentgradelevel, functioninggradelevel, lastgradelevel, highestgradetypekey, summerschoolname, firstqtrabsenceexcused, firstqtrabsencenotexcused, firstqtrabsencetardy, firstqtrabsence, secondqtrabsenceexcused, secondqtrabsencenotexcused, secondqtrabsencetardy, secondqtrabsence, thirdqtrabsenceexcused, thirdqtrabsencenotexcused, thirdqtrabsencetardy, thirdqtrabsence, fourthqtrabsenceexcused, fourthqtrabsencenotexcused, fourthqtrabsencetardy, fourthqtrabsence, numberofabsences, lastifspdate, ifsplastdate, transportmodetypedetail, sasidno
						 FROM
				personeducation
			WHERE
				personid = v_oldpersonid;
		   
			INSERT INTO personeducationtesting
			( personid, testingtypekey, readinglevel, readingtestdate, mathlevel, mathtestdate, testingprovider, activeflag, effectivedate, expirationdate, insertedby, updatedby,
			insertedon, updatedon, old_id, testinginfotype, nameoftester, pretestdate, pretestscore, posttestdate, posttestscore)
			SELECT  l_personid, testingtypekey, readinglevel, readingtestdate, mathlevel, mathtestdate, testingprovider, activeflag, now(), null, v_userid, v_userid,
			now(),  now(), old_id, testinginfotype, nameoftester, pretestdate, pretestscore, posttestdate, posttestscore
			FROM personeducationtesting WHERE
			personid = v_oldpersonid;


			INSERT INTO personaccomplishment(personid, highestgradetypekey, accomplishmentdate, 
			isrecordreceived, receiveddate, activeflag, expirationdate, 
			insertedby, updatedby, insertedon, updatedon)
			SELECT l_personid, highestgradetypekey, accomplishmentdate, isrecordreceived, 
			receiveddate,activeflag, expirationdate, 
			v_userid,v_userid,now(),  now()
			FROM personaccomplishment where   personid = v_oldpersonid;

			INSERT INTO personeducationvocation(personid, vocationinterest, vocationaptitude, 
			  isvocationaltest, certificatename, certificatepath, activeflag, 
			   expirationdate, insertedby, updatedby, insertedon, 
			  updatedon)
			SELECT l_personid, vocationinterest,vocationaptitude, isvocationaltest, 
			  certificatename, certificatepath, activeflag,  
			 expirationdate, v_userid,v_userid, now(),  now()
			FROM personeducationvocation where   personid = v_oldpersonid;

			/* Contact Tab */ 
			INSERT INTO personphonenumber
			( personid, activeflag, personphonetypekey, phonenumber, phoneextension, reversephonenumber, updatedby, updatedon, insertedby, insertedon, effectivedate, expirationdate, old_id, "timestamp", ismobile, startdate, enddate)
			SELECT  l_personid, 1, personphonetypekey, phonenumber, phoneextension, reversephonenumber, v_userid, now(), v_userid, now(), now(), null, old_id, "timestamp", ismobile, startdate, enddate
			FROM personphonenumber where   personid = v_oldpersonid and activeflag=1;

			INSERT INTO personemail
			( personid, activeflag, personemailtypekey, email, updatedby, updatedon, insertedby, insertedon,   old_id, "timestamp", startdate, enddate)
			SELECT  l_personid, 1, personemailtypekey, email, v_userid, now(), v_userid, now(),   old_id, "timestamp", startdate, enddate
			FROM cjams.personemail where   personid = v_oldpersonid and activeflag=1;


			/* address */
			-- Address is not needed to be carried over to the new identity

			--Health info
			INSERT INTO cjams.personexamination
			( fk_id, appointkeptflag, appoinmentdate, nextappointmentdate, examinationtypekey, "comments", specialityexamtypekey, labtesttypekey, hivconsentflag, recommendations,
			providerid, insertedon, insertedby, updatedon, updatedby, activeflag, motherflag, fatherflag, otherflag, othernotes, infocomments, exprovidedtypekey, providedbyclientid, 
			collateralid, infoclienttypekey, physicianname, physicianspeciality, affiliateorg, addresstypekey, formattypekey, streetnumber, boxnumber, predirtypekey, streetname,
			streetsuffixtypekey, postdirtypekey, unittypekey, unitnumbertx, cityname, countytypekey, statetypekey, zip5no, zip4no, direction, foreignaddress, workphone, workextn, 
			homephone, pager, email, fax, mobile, url, othercontacts, foreignstate, country, postalcode, streetnotes, providedbynotes, providedbyrelationtypekey, expungementflag,
			datavalidflag, clientmergeid, old_id, personid, uploadpath, address2, address1, medicalreferrals, followupneeded, uploadedfiles, nextappointmentreason, notkeptreason,
			providerinfoflag, parentexaminationid)

			SELECT  fk_id, appointkeptflag, appoinmentdate, nextappointmentdate, examinationtypekey, "comments", specialityexamtypekey, labtesttypekey, hivconsentflag, recommendations,
			providerid,  now(), v_userid,  now(), v_userid, 1, motherflag, fatherflag, otherflag, othernotes, infocomments, exprovidedtypekey, providedbyclientid,
			collateralid, infoclienttypekey, physicianname, physicianspeciality, affiliateorg, addresstypekey, formattypekey, streetnumber, boxnumber, predirtypekey, streetname,
			streetsuffixtypekey, postdirtypekey, unittypekey, unitnumbertx, cityname, countytypekey, statetypekey, zip5no, zip4no, direction, foreignaddress, workphone, workextn,
			homephone, pager, email, fax, mobile, url, othercontacts, foreignstate, country, postalcode, streetnotes, providedbynotes, providedbyrelationtypekey, expungementflag,
			datavalidflag, clientmergeid, old_id, l_personid, uploadpath, address2, address1, medicalreferrals, followupneeded, uploadedfiles, nextappointmentreason, notkeptreason, 
			providerinfoflag, parentexaminationid
			FROM personexamination where  personid = v_oldpersonid and activeflag=1;

			INSERT INTO birthhealthinfo
			( personid, mothersusepregnant, mothersusepregnantspecify, mentalcondition, mentalconditionspecify, diseasescondition,
			 diseasesconditionspecify, birthdefects, "comments", activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, 
			 old_id, uploadpath)
			 SELECT  l_personid, mothersusepregnant, mothersusepregnantspecify, mentalcondition, mentalconditionspecify, diseasescondition,
			 diseasesconditionspecify, birthdefects, "comments", 1, v_userid,  now(), v_userid,  now(),  now(), 
			 old_id, uploadpath
			FROM birthhealthinfo where   personid = v_oldpersonid and activeflag=1;


			INSERT INTO clientunder5yearsinfo
			  (personid,providedbyclientid,providedbycollateralid,infoclienttypekey,prenatalcaretypekey,deliverytypekey,deliverytypetx,deliverycomplicationnotes,
			  u5notes,providerid,insertedon,insertedby,updatedon,updatedby,activeflag,hospitalname,addresstypekey,formattypekey,streetnumber,boxnumber,predirtypekey,
			  streetname,streetsuffixtypekey,postdirtypekey,unittypekey,unitnumbertx,cityname,countytypekey,statetypekey,zip5no,zip4no,directionnotes,foreignnotes,workphone,
			  workphoneextn,homephone,pager,email,fax,mobile,url,othercontacts,foreignstatetx,country,postalcode,street,providedby,providerbyrelationtypekey,expungementflag,
			  datavalidflag,clientmergeid,old_id,uploadpath,whenbegun,gestation,"comments",address1,address2,phone,complicationsspecify,county,prenatalproblemspecify,parentcare,
			  parity,speciality,hospitalcomments,complications)
			SELECT
			   l_personid,providedbyclientid,providedbycollateralid,infoclienttypekey,prenatalcaretypekey,deliverytypekey,deliverytypetx,deliverycomplicationnotes,
			   u5notes,providerid,now(),v_userid,now(),v_userid,1,hospitalname,addresstypekey,formattypekey,streetnumber,boxnumber,predirtypekey,
			   streetname,streetsuffixtypekey,postdirtypekey,unittypekey,unitnumbertx,cityname,countytypekey,statetypekey,zip5no,zip4no,directionnotes,foreignnotes,workphone,
			   workphoneextn,homephone,pager,email,fax,mobile,url,othercontacts,foreignstatetx,country,postalcode,street,providedby,providerbyrelationtypekey,expungementflag,
			   datavalidflag,clientmergeid,old_id,uploadpath,whenbegun,gestation,"comments",address1,address2,phone,complicationsspecify,county,prenatalproblemspecify,parentcare,
			   parity,speciality,hospitalcomments,complications
			FROM
			  clientunder5yearsinfo
			WHERE
			  personid = v_oldpersonid and activeflag=1;
			  

			INSERT INTO personsexualinfo
			  (personid,infoprovidedbypersonid,infoprovidedbycollateralid,infoclientkey,sexualactiveflag,sexualorientationkey,pregnancyno,childrenno,birthcontrol,sicomments,insertedon,insertedby,updatedon,updatedby,activeflag,sextransdis,infoprovidedby,infoprovidedbyrelationkey,expungementflag,datavalidflag,clientmergeid,fk_id,old_id,uploadpath,ispregnant,std_treatment_startdate,std_treatment_enddate,stdspecify,bcspecify,genderidentity,genderidentityspecify,birthcontroldate,sexualorientationcomments,specify)
			SELECT
			   l_personid,infoprovidedbypersonid,infoprovidedbycollateralid,infoclientkey,sexualactiveflag,sexualorientationkey,pregnancyno,childrenno,birthcontrol,sicomments,insertedon,insertedby,updatedon,updatedby,activeflag,sextransdis,infoprovidedby,infoprovidedbyrelationkey,expungementflag,datavalidflag,clientmergeid,fk_id,old_id,uploadpath,ispregnant,std_treatment_startdate,std_treatment_enddate,stdspecify,bcspecify,genderidentity,genderidentityspecify,birthcontroldate,sexualorientationcomments,specify
			FROM
			  personsexualinfo
			WHERE
			  personid = v_oldpersonid;
			  

			INSERT INTO personhospitalization
			  (typekey,reasontypekey,adrfaxtx,startdt,enddt,diagnosistx,commentstx,updatedby,updatedon,adrdirectiontx,insertedby,adrzip4no,insertedon,activeflag,adrzip5no,adrstatetypekey,personid,adrcitynm,adrforeignstatetx,providerid,adrunitnotx,adrcountrytx,adrunittypetypekey,adrpostdirtypekey,adrstreetsuffixtypekey,adrstreetnm,adrpredirtypekey,adrpostalcodetx,adrboxno,adrstreetno,adrcellphonetx,adrformattypekey,hospitalnm,adrcountytypekey,adrforeigntx,adremailtx,infocommentstx,adrpagertx,infomotherflag,infofatherflag,adrhomephonetx,infootherflag,infoothertx,adrworkxtntx,adrworkphonetx,adrurltx,adrothercontacttx,hoinfoprovidedtypekey,infoprovidedbyclientid,infoprovidedbycollateralid,infoclienttypekey,adrtypetypekey,adrstreettx,infoprovidedbytx,infoprovidedbyrelationctypekey,expungementflag,datavalidflag,clientmergeid,old_id,uploadpath,hospital_address1,hospital_address2,hospital_phone,hospital_city,hospitalization_type,hospitalization_reason,hospital_state,hospital_zipcode,hasdischargeplan,dischargeplan,county)
			SELECT
			   typekey,reasontypekey,adrfaxtx,startdt,enddt,diagnosistx,commentstx,updatedby,updatedon,adrdirectiontx,insertedby,adrzip4no,insertedon,activeflag,adrzip5no,adrstatetypekey,l_personid,adrcitynm,adrforeignstatetx,providerid,adrunitnotx,adrcountrytx,adrunittypetypekey,adrpostdirtypekey,adrstreetsuffixtypekey,adrstreetnm,adrpredirtypekey,adrpostalcodetx,adrboxno,adrstreetno,adrcellphonetx,adrformattypekey,hospitalnm,adrcountytypekey,adrforeigntx,adremailtx,infocommentstx,adrpagertx,infomotherflag,infofatherflag,adrhomephonetx,infootherflag,infoothertx,adrworkxtntx,adrworkphonetx,adrurltx,adrothercontacttx,hoinfoprovidedtypekey,infoprovidedbyclientid,infoprovidedbycollateralid,infoclienttypekey,adrtypetypekey,adrstreettx,infoprovidedbytx,infoprovidedbyrelationctypekey,expungementflag,datavalidflag,clientmergeid,old_id,uploadpath,hospital_address1,hospital_address2,hospital_phone,hospital_city,hospitalization_type,hospitalization_reason,hospital_state,hospital_zipcode,hasdischargeplan,dischargeplan,county
			FROM
			  personhospitalization
			WHERE
			  personid = v_oldpersonid;
	  

			INSERT INTO personimmunization
			  (personid,immunizationtypekey,immunizationdate,nextduedate,"comments",certifiedcopyflag,updatedby,updatedon,insertedby,direction,insertedon,zip4no,activeflag,fk_id,zip5no,statetypekey,providerid,nonimmunreason,foreignstate,cityname,notimmunizedflag,unitnumber,country,unittypekey,postdirtypekey,streetsuffixtypekey,postalcode,streetname,predirtypekey,boxnumber,mobile,streetnumber,hospitalname,fax,countytypekey,foreignaddress,email,pager,infocomments,motherflag,fatherflag,homephone,otherflag,othernotes,workextn,workphone,formattypekey,url,othercontacts,iminfoprovidedtypekey,providedbyclientid,collateralid,infoclienttypekey,addresstypekey,streetnotes,providedbynotes,providedbyrelationtypekey,expungementflag,datavalidflag,clientmergeid,old_id,reportedby,immunizationdocpath,immunizationdocname,isimmunefileavail,uploadpath,dose,personimmunizationconfigid)
			SELECT
			   l_personid,immunizationtypekey,immunizationdate,nextduedate,"comments",certifiedcopyflag,updatedby,updatedon,insertedby,direction,insertedon,zip4no,activeflag,fk_id,zip5no,statetypekey,providerid,nonimmunreason,foreignstate,cityname,notimmunizedflag,unitnumber,country,unittypekey,postdirtypekey,streetsuffixtypekey,postalcode,streetname,predirtypekey,boxnumber,mobile,streetnumber,hospitalname,fax,countytypekey,foreignaddress,email,pager,infocomments,motherflag,fatherflag,homephone,otherflag,othernotes,workextn,workphone,formattypekey,url,othercontacts,iminfoprovidedtypekey,providedbyclientid,collateralid,infoclienttypekey,addresstypekey,streetnotes,providedbynotes,providedbyrelationtypekey,expungementflag,datavalidflag,clientmergeid,old_id,reportedby,immunizationdocpath,immunizationdocname,isimmunefileavail,uploadpath,dose,personimmunizationconfigid
			FROM
			  personimmunization
			WHERE
			  personid = v_oldpersonid;
			  

			INSERT INTO personabusesubstance
			  (personid,isusetobacco,isusedrugoralcohol,isusedrug,isusealcohol,drugfrequencydetails,drugageatfirstuse,alcoholfrequencydetails,alcoholageatfirstuse,drugoralcoholproblems,activeflag,updatedby,updatedon,insertedby,insertedon,effectivedate,expirationdate,tobaccoageatfirstuse,tobaccofrequencydetails,drugfrequencytypekey,alcoholfrequencytypekey,tobaccofrequencytypekey,drugtimes,alcoholtimes,tobaccotimes,medicalprofilekey,substanceusekey,substancecode,substanceusenotetext,uploadpath,parentabusesubstanceid)
			SELECT
			   l_personid,isusetobacco,isusedrugoralcohol,isusedrug,isusealcohol,drugfrequencydetails,drugageatfirstuse,alcoholfrequencydetails,alcoholageatfirstuse,drugoralcoholproblems,activeflag,updatedby,updatedon,insertedby,insertedon,effectivedate,expirationdate,tobaccoageatfirstuse,tobaccofrequencydetails,drugfrequencytypekey,alcoholfrequencytypekey,tobaccofrequencytypekey,drugtimes,alcoholtimes,tobaccotimes,medicalprofilekey,substanceusekey,substancecode,substanceusenotetext,uploadpath,parentabusesubstanceid
			FROM
			  personabusesubstance
			WHERE
			  personid = v_oldpersonid;
			  

			INSERT INTO personbehavioralhealth
			  (personid,clinicianname,currentdiagnoses,phone,address1,address2,reportname,city,state,countyid,zip,activeflag,updatedby,updatedon,insertedby,insertedon,effectivedate,expirationdate,reportpath,isbehavioralhealth,personservicetypekey,county,uploadpath,email,nodiagnosisreason,evaluationby,dateofevaluation,parentbehaviouralhealthid,typeofservice,phobiakey,phobiacomments)
			SELECT
			   l_personid,clinicianname,currentdiagnoses,phone,address1,address2,reportname,city,state,countyid,zip,activeflag,updatedby,updatedon,insertedby,insertedon,effectivedate,expirationdate,reportpath,isbehavioralhealth,personservicetypekey,county,uploadpath,email,nodiagnosisreason,evaluationby,dateofevaluation,parentbehaviouralhealthid,typeofservice,phobiakey,phobiacomments
			FROM
			  personbehavioralhealth
			WHERE
			  personid = v_oldpersonid;
			  

			INSERT INTO persondisability
			  (personid,disabilityconditiontypekey,disabilityflag,diagnoiseddisabilitynotes,startdate,enddate,evaluationdate,evaluatorname,"comments",insertedon,insertedby,updatedon,updatedby,activeflag,expungementflag,old_id,disabilitytypekey,disabilitytype,uploadpath,hygienekey,specialkey,startdateunknown)
			SELECT
			   l_personid,disabilityconditiontypekey,disabilityflag,diagnoiseddisabilitynotes,startdate,enddate,evaluationdate,evaluatorname,"comments",insertedon,insertedby,updatedon,updatedby,activeflag,expungementflag,old_id,disabilitytypekey,disabilitytype,uploadpath,hygienekey,specialkey,startdateunknown
			FROM
			  persondisability
			WHERE
			  personid = v_oldpersonid;


			INSERT INTO cjams.personfmlymdclhstry
			( fk_id, relativeid, deathcausetypekey, insertedon, insertedby, updatedon, updatedby, activeflag, motherflag, fatherflag, otherflag, othernotes, "comments", fmprovidedtypekey, providedbyclientid, collateralid, infoclienttypekey, relationshiptypekey, famhistclientid, famhistreltypekey, providedbynotes, providedbyrelationtypekey, famhistclientnotes, famhistrelationtypekey, expungementflag, datavalidflag, clientmergeid, old_id, personid, uploadpath, majorhistoryproblem, famhistclient, famhistrelationtype, deathcausetype)
			SELECT  fk_id, relativeid, deathcausetypekey, now(), v_userid, now(), v_userid, 1, motherflag, fatherflag, otherflag, othernotes, "comments", fmprovidedtypekey, providedbyclientid, collateralid, infoclienttypekey, relationshiptypekey, famhistclientid, famhistreltypekey, providedbynotes, providedbyrelationtypekey, famhistclientnotes, famhistrelationtypekey, expungementflag, datavalidflag, clientmergeid, old_id, l_personid, uploadpath, majorhistoryproblem, famhistclient, famhistrelationtype, deathcausetype
			FROM cjams.personfmlymdclhstry where personid = v_oldpersonid and activeflag=1;



			INSERT INTO personhlthfeeding
			  (providedname,relationship,ishousehold,iscollateral,isfeedinginfoknown,diettype,eatertype,liquids,solidfood,feeding_position,otherneeds,typeofformula,amountperfeeding,schedule,insertedon,insertedby,updatedon,updatedby,activeflag,"comments",personid,uploadpath)
			SELECT
			   providedname,relationship,ishousehold,iscollateral,isfeedinginfoknown,diettype,eatertype,liquids,solidfood,feeding_position,otherneeds,typeofformula,amountperfeeding,schedule,insertedon,insertedby,updatedon,updatedby,activeflag,"comments",l_personid,uploadpath
			FROM
			  personhlthfeeding
			WHERE
			  personid = v_oldpersonid;


			INSERT INTO personhealthinsurance
			  (personid,ismedicaidmedicare,policyholdername,address1,address2,city,state,countyid,zip,providerphone,patientpolicyholderrelation,policyname,groupnumber,activeflag,updatedby,updatedon,insertedby,insertedon,effectivedate,expirationdate,providertypeother,insurancetype,providertype,medicalinsuranceprovider,medicarenumber,isinsuranceavailable,uploadpath,county,policynumber,managedcareorganization)
			SELECT
			   l_personid,ismedicaidmedicare,policyholdername,address1,address2,city,state,countyid,zip,providerphone,patientpolicyholderrelation,policyname,groupnumber,activeflag,updatedby,updatedon,insertedby,insertedon,effectivedate,expirationdate,providertypeother,insurancetype,providertype,medicalinsuranceprovider,medicarenumber,isinsuranceavailable,uploadpath,county,policynumber,managedcareorganization
			FROM
			  personhealthinsurance
			WHERE
			  personid = v_oldpersonid;


			INSERT INTO personmedicalcondition
			  (personid,begindate,enddate,recordedby,medicalconditiontypekey,activeflag,updatedby,updatedon,insertedby,insertedon,effectivedate,expirationdate,medicalconditionother,medicalprofilekey,medicalconditionkey,wrkrtemplatecode,medicalconditiontext,medicalconditionstatindc,uploadpath,ismedfragile,severitysymptomkey,ischronic,allergies_adverse_reactions,medication_client_allergies,medicalcondition,notes)
			SELECT
			   l_personid,begindate,enddate,recordedby,medicalconditiontypekey,activeflag,updatedby,updatedon,insertedby,insertedon,effectivedate,expirationdate,medicalconditionother,medicalprofilekey,medicalconditionkey,wrkrtemplatecode,medicalconditiontext,medicalconditionstatindc,uploadpath,ismedfragile,severitysymptomkey,ischronic,allergies_adverse_reactions,medication_client_allergies,medicalcondition,notes
			FROM
			  personmedicalcondition
			WHERE
			  personid = v_oldpersonid;


			INSERT INTO personmedicalinfo
			  (personid,ispersonhealthy,providerid,hospitalname,physicalproblem,mentalproblem,allergydetails,hygienedetails,specialdietdetails,beforebirthdetail,deliverytype,birthdefects,bloodrelationship,sexualdisease,childrennumber,speechtypekey,speechcomments,diettypekey,eatertypekey,feedinginfo,sleepinginfo,bowelmovent,urination,"others",eliminationcomments,specialconsiderations,sensitiveinfo,specialneeds,phobiainfo,physicaldisabilitykey,emotionaldisabilitykey,learningdisabilitykey,hearingdisabilitykey,visualdisabilitykey,otherdisabilitykey,mentallyretarded,disabilitycomment,childhooddisease,bithdisease,confidentialinfo,infoproviderkey,highriskinfo,medicationallergy,insertedon,insertedby,updatedon,updatedby,activeflag,old_id,clientid,badrformattypekey,badrstreetno,badrboxno,badrpredirtypekey,badrstreetname,badrstreetsuffixtypekey,badrpostdirtypekey,badrunittypetypekey,badrunitno,badrcityname,badrcountytypekey,badrstatetypekey,badrzip5no,badrzip4no,badrdirection,badrforeign,sexualactiveflag,sexualorientationtypekey,pregnancyno,agesatup,agewalk,agetalk,mobilityunknownflag,feedingunknownflag,bottleformula,bottlequantity,bottleschedule,sleepingunknownflag,naptime,bedtime,eliminationunknownflag,specialconsunknownflag,developmentallydelayedflag,deliverycomplications,motherusedrug,sexualdiseaseflag,birthcontrolmethod,chinfofatherflag,chinfootherflag,chinfoother,chcomments,alinfomotherflag,alinfofatherflag,alinfootherflag,alinfoother,alcomments,u5infomotherflag,u5infofatherflag,u5infootherflag,u5infoother,u5comments,acinfomotherflag,acinfofatherflag,acinfootherflag,acinfoother,accomments,siinfomotherflag,siinfofatherflag,siinfootherflag,siinfoother,sicomments,msinfomotherflag,msinfofatherflag,msinfootherflag,msinfoother,msinfocomments,fdinfomotherflag,fdinfofatherflag,fdinfootherflag,fdinfoother,fdinfocomments,slinfomotherflag,slinfofatherflag,slinfootherflag,slinfoother,slinfocomments,elinfomotherflag,elinfofatherflag,elinfootherflag,elinfoother,elinfocomments,scinfomotherflag,scinfofatherflag,scinfootherflag,scinfoother,scinfocomments,badrforeignstate,badrcountry,badrpostalcode,mentalretardationtypekey,chinfoprovidedtypekey,alinfoprovidedtypekey,u5infoprovidedtypekey,acinfoprovidedtypekey,siinfoprovidedtypekey,msinfoprovidedtypekey,fdinfoprovidedtypekey,slinfoprovidedtypekey,elinfoprovidedtypekey,childspecialneedflag,splneedprimarybasistypekey,badrstreet,expungementflag,datavalidflag,clientimeergeid,isprescribedmedication,medicinename,dosage,frequency,startdate,enddate,expirationdate,prescribingdoctor,complaint,reportedby,otherreason,prescribedreason,"comments",uploadpath,medicationtype,prescribedduration)
			SELECT
			   l_personid,ispersonhealthy,providerid,hospitalname,physicalproblem,mentalproblem,allergydetails,hygienedetails,specialdietdetails,beforebirthdetail,deliverytype,birthdefects,bloodrelationship,sexualdisease,childrennumber,speechtypekey,speechcomments,diettypekey,eatertypekey,feedinginfo,sleepinginfo,bowelmovent,urination,"others",eliminationcomments,specialconsiderations,sensitiveinfo,specialneeds,phobiainfo,physicaldisabilitykey,emotionaldisabilitykey,learningdisabilitykey,hearingdisabilitykey,visualdisabilitykey,otherdisabilitykey,mentallyretarded,disabilitycomment,childhooddisease,bithdisease,confidentialinfo,infoproviderkey,highriskinfo,medicationallergy,insertedon,insertedby,updatedon,updatedby,activeflag,old_id,clientid,badrformattypekey,badrstreetno,badrboxno,badrpredirtypekey,badrstreetname,badrstreetsuffixtypekey,badrpostdirtypekey,badrunittypetypekey,badrunitno,badrcityname,badrcountytypekey,badrstatetypekey,badrzip5no,badrzip4no,badrdirection,badrforeign,sexualactiveflag,sexualorientationtypekey,pregnancyno,agesatup,agewalk,agetalk,mobilityunknownflag,feedingunknownflag,bottleformula,bottlequantity,bottleschedule,sleepingunknownflag,naptime,bedtime,eliminationunknownflag,specialconsunknownflag,developmentallydelayedflag,deliverycomplications,motherusedrug,sexualdiseaseflag,birthcontrolmethod,chinfofatherflag,chinfootherflag,chinfoother,chcomments,alinfomotherflag,alinfofatherflag,alinfootherflag,alinfoother,alcomments,u5infomotherflag,u5infofatherflag,u5infootherflag,u5infoother,u5comments,acinfomotherflag,acinfofatherflag,acinfootherflag,acinfoother,accomments,siinfomotherflag,siinfofatherflag,siinfootherflag,siinfoother,sicomments,msinfomotherflag,msinfofatherflag,msinfootherflag,msinfoother,msinfocomments,fdinfomotherflag,fdinfofatherflag,fdinfootherflag,fdinfoother,fdinfocomments,slinfomotherflag,slinfofatherflag,slinfootherflag,slinfoother,slinfocomments,elinfomotherflag,elinfofatherflag,elinfootherflag,elinfoother,elinfocomments,scinfomotherflag,scinfofatherflag,scinfootherflag,scinfoother,scinfocomments,badrforeignstate,badrcountry,badrpostalcode,mentalretardationtypekey,chinfoprovidedtypekey,alinfoprovidedtypekey,u5infoprovidedtypekey,acinfoprovidedtypekey,siinfoprovidedtypekey,msinfoprovidedtypekey,fdinfoprovidedtypekey,slinfoprovidedtypekey,elinfoprovidedtypekey,childspecialneedflag,splneedprimarybasistypekey,badrstreet,expungementflag,datavalidflag,clientimeergeid,isprescribedmedication,medicinename,dosage,frequency,startdate,enddate,expirationdate,prescribingdoctor,complaint,reportedby,otherreason,prescribedreason,"comments",uploadpath,medicationtype,prescribedduration
			FROM
			  personmedicalinfo
			WHERE
			  personid = v_oldpersonid;


			INSERT INTO personphycisianinfo
			  (personid,isprimaryphycisian,"name",facility,phone,email,address1,address2,city,state,countyid,zip,startdate,enddate,activeflag,updatedby,updatedon,insertedby,insertedon,effectivedate,expirationdate,physicianspecialtytypekey,medicalprofilekey,completeworkeridno,mcotext,physicianfaxtext,psychrasesindc,psychrasesloctntext,psychrasesdate,psychrasesdiagkey,psychrhospindc,psychrhosploctntext,psychrhospdate,psychrhospdiagkey,psychlasesindc,psychlasesloctntext,psychlasesdate,psychlasesdiagkey,counselingindc,counselingloctntext,counselingdate,psychotropicdrugindc,addictionindc,addictionloctntext,addictiondate,addictionresultkey,placementsummarykey,completedate,completeindc,marylandmamcocode,otherinsuranceindc,othinseffectivedate,othinsexpiredate,othinscompanytext,othinsmcotext,othinspolicynumbtext,othinspolicyholdertext,othphysicianname_text,othphysicianpracttext,othphysicianphonetext,othphysicianfaxtext,isphysician,isdentist,dental_speciality,physician_speciality,physician_child_lang_check,translation_service_available,dentist_child_lang_check,uploadpath,otherspeciality,degreetype,countyname)
			SELECT
			   l_personid,isprimaryphycisian,"name",facility,phone,email,address1,address2,city,state,countyid,zip,startdate,enddate,activeflag,updatedby,updatedon,insertedby,insertedon,effectivedate,expirationdate,physicianspecialtytypekey,medicalprofilekey,completeworkeridno,mcotext,physicianfaxtext,psychrasesindc,psychrasesloctntext,psychrasesdate,psychrasesdiagkey,psychrhospindc,psychrhosploctntext,psychrhospdate,psychrhospdiagkey,psychlasesindc,psychlasesloctntext,psychlasesdate,psychlasesdiagkey,counselingindc,counselingloctntext,counselingdate,psychotropicdrugindc,addictionindc,addictionloctntext,addictiondate,addictionresultkey,placementsummarykey,completedate,completeindc,marylandmamcocode,otherinsuranceindc,othinseffectivedate,othinsexpiredate,othinscompanytext,othinsmcotext,othinspolicynumbtext,othinspolicyholdertext,othphysicianname_text,othphysicianpracttext,othphysicianphonetext,othphysicianfaxtext,isphysician,isdentist,dental_speciality,physician_speciality,physician_child_lang_check,translation_service_available,dentist_child_lang_check,uploadpath,otherspeciality,degreetype,countyname
			FROM
			  personphycisianinfo
			WHERE
			  personid = v_oldpersonid;


			INSERT INTO personhlthmobilityspeech
			  (providedname,relationship,ishousehold,iscollateral,ismbltyspchknown,satupage,walkedage,talkedage,insertedon,insertedby,updatedon,updatedby,activeflag,"comments",personid,uploadpath,mblty,speech)
			SELECT
			   providedname,relationship,ishousehold,iscollateral,ismbltyspchknown,satupage,walkedage,talkedage,insertedon,insertedby,updatedon,updatedby,activeflag,"comments",l_personid,uploadpath,mblty,speech
			FROM
			  personhlthmobilityspeech
			WHERE
			  personid = v_oldpersonid;

			INSERT INTO personhlthsleeping
			  (providedname,relationship,ishousehold,iscollateral,issleepinginfoknown,sleepingenvironment,sleepingproblems,sleepingposition,sleepingschedule_naptime,sleepingschedule_bedtime,insertedon,insertedby,updatedon,updatedby,activeflag,"comments",personid,uploadpath,otherspecify)
			SELECT
			   providedname,relationship,ishousehold,iscollateral,issleepinginfoknown,sleepingenvironment,sleepingproblems,sleepingposition,sleepingschedule_naptime,sleepingschedule_bedtime,insertedon,insertedby,updatedon,updatedby,activeflag,"comments",l_personid,uploadpath,otherspecify
			FROM
			  personhlthsleeping
			WHERE
			  personid = v_oldpersonid;

			INSERT INTO personhlthelimination
				(providedname,relationship,ishousehold,iscollateral,iseliminationinfoknown,elimination_currentstatus,toilettrainingmethod,wordforbowelmovement,wordforurination,insertedon,insertedby,updatedon,updatedby,activeflag,"comments",personid,specialcomments,uploadpath,isspecialconsiderunknown,otherspecify)
			SELECT
				 providedname,relationship,ishousehold,iscollateral,iseliminationinfoknown,elimination_currentstatus,toilettrainingmethod,wordforbowelmovement,wordforurination,insertedon,insertedby,updatedon,updatedby,activeflag,"comments",l_personid,specialcomments,uploadpath,isspecialconsiderunknown,otherspecify
			FROM
				personhlthelimination
			WHERE
				personid = v_oldpersonid;

			--Adoption actor
			INSERT INTO cjams.adoptioncaseactor ( adoptioncaseid, personid, actortypekey,  activeflag,  insertedby, updatedby)
				VALUES( 
						l_adoptioncaseid,
						l_personid, 
						'CHILD',
						1, 
						v_userid, 
						v_userid
					);
					
			/*Add program area*/  
			SELECT finalizationdate::date INTO l_finaldate FROM adoptionagreement WHERE adoptionplanningid = v_adoptionplanningid ORDER BY insertedon DESC LIMIT 1;
			
			l_ppareferenceid := null;
			INSERT INTO personprogramarea 
				(personid, programkey, subprogramkey, 
				 objecttypekey, objectid, startdate,
				 insertedby, updatedby,  entityid, datatransferflag, sourcetype) 
			VALUES( l_personid, l_programkey, l_subprogramkey, 
				'adoptioncase', l_adoptioncaseid:: character varying, COALESCE(l_finaldate,NOW()) :: DATE, 
				v_userid, v_userid,  l_adoptioncasenumber , 'A','CW')
			RETURNING personprogramid into l_ppareferenceid;

			IF l_ppareferenceid IS NOT NULL THEN
				INSERT INTO auditlog(referenceid, logtypekey, description, metadata, insertedon, insertedby)
					VALUES(l_ppareferenceid,'PRGMAREA','systemupdate02',
				(SELECT row_to_json(personprogramarea) FROM personprogramarea WHERE personprogramid = l_ppareferenceid), now(), v_userid);
			END IF;

		  
			RAISE  NOTICE  'contact%',v_person->>'contact';
	  
		END LOOP;

		-- NOTE: pre-adoption case id is the 'Adoption planning id' from the service case that lead up to the adoption
		INSERT INTO cjams.adoptionlink
		( preadoptionclientid, preadoptioncaseid, adoptionclientid, adoptioncaseid, insertedon, insertedby, updatedon, updatedby, activeflag)
		VALUES( v_oldpersonid, v_adoptionplanningid, l_personid, l_adoptioncaseid, now(), v_userid, now(), v_userid, 1);

		--@TM-2020-10-20: Populate adoptive parents if unavailable in bio-case
		select parent1providerid
		  into v_parent1providerid
		from adoptionagreement ag 
		  where ag.adoptionplanningid = v_adoptionplanningid and ag.activeflag = 1;

		select * from getadoptiveparents(v_parent1providerid::character varying) into v_parents; 

		--IF(v_adoptiveparent1id is null and v_parent1providerid is not null) THEN
		-- select  getadoptiveparents(v_parent1providerid::character varying)::json -> 0 -> 'adoptiveparent1id', 
		--       getadoptiveparents(v_parent1providerid::character varying)::json -> 0 -> 'adoptiveparent2id',
		--       getadoptiveparents(v_parent1providerid::character varying)::json -> 0 -> 'provider_approval_id' 
		-- select  case 
		--     	when (getadoptiveparents(v_parent1providerid::character varying)::json -> 0 -> 'adoptiveparent1id')::character varying = 'null' then null 
		--     	else getadoptiveparents(v_parent1providerid::character varying)::json -> 0 -> 'adoptiveparent1id'
		--     end, 
		--     case 
		--     	when (getadoptiveparents(v_parent1providerid::character varying)::json -> 0 -> 'adoptiveparent2id')::character varying = 'null' then null
		-- 		else getadoptiveparents(v_parent1providerid::character varying)::json -> 0 -> 'adoptiveparent2id'
		--     end,
		--     case --@TM: 2020-11-12 - To fetch unique values from prov approval person tbl
		--     	when (getadoptiveparents(v_parent1providerid::character varying)::json -> 0 -> 'provider_approval_id')::character varying = 'null' then null
		--     	else getadoptiveparents(v_parent1providerid::character varying)::json -> 0 -> 'provider_approval_id'
		-- 	end
		select    
			case when ((v_parents::character varying)::json -> 0 -> 'adoptiveparent1id')::character varying = 'null' then null else ((v_parents::character varying)::json -> 0 -> 'adoptiveparent1id') end,
			case when ((v_parents::character varying)::json -> 0 -> 'adoptiveparent2id')::character varying = 'null' then null else ((v_parents::character varying)::json -> 0 -> 'adoptiveparent2id') end,
			case when ((v_parents::character varying)::json -> 0 -> 'provider_approval_id')::character varying = 'null' then null else ((v_parents::character varying)::json -> 0 -> 'provider_approval_id') end,
			case when ((v_parents::character varying)::json -> 0 -> 'provider2id')::character varying = 'null' then null else ((v_parents::character varying)::json -> 0 -> 'provider2id') end
		into v_adoptiveparent1id, 
		  v_adoptiveparent2id,
		  v_provider_approval_id,
		  v_provider2id;

		-- RAISE  NOTICE  '618 >>>v_parents%',v_parents;     

		UPDATE adoptioncaseagreement 
		SET adoptiveparent1id = v_adoptiveparent1id, adoptiveparent2id = v_adoptiveparent2id
		WHERE adoptionagreementid = l_adoptioncase_adoptionagreementid;

		-- END IF;
		-- TODO- Once provider module is ready, we will get the person id based on the provider from prov approval person table
		-- and just insert into the adoptioncaseactor the existing person ids instead of inserting new ones.

		-- FOR  v_ag  IN  select *  from adoptionagreement ag where ag.adoptionplanningid=v_adoptionplanningid and ag.activeflag=1 LOOP
		--  IF(v_ag.adoptiveparent1id is not null) THEN
		--    SELECT first_nm, last_nm into v_parent1firstname, v_parent1lastname from tb_prov_approval_person where approval_person_id = v_ag.adoptiveparent1id;

		RAISE  NOTICE  ' >>>v_adoptiveparent1id%',v_adoptiveparent1id;
		RAISE  NOTICE  ' >>>v_provider_approval_id%',v_provider_approval_id;
		RAISE  NOTICE  ' >>>v_adoptiveparent2id%',v_adoptiveparent2id;

		-- Adoptive Parent 1 - Applicant
		select pr.personid, 
			pr.clientflag, 
			( select pid.personidentifiervalue
				from personidentifier pid
				where pid.personid = pr.personid
					and pid.activeflag = 1
					and pid.personidentifiertypekey = 'MDM_ID'
			) as MDM_ID
		into v_applicantid,
			 v_applicant_clientflag,
			 v_applicant_MDM_ID
		from intakeservicerequestactor isra,
			actor ac,
			person pr
		where isra.actorid = ac.actorid
			and ac.personid = pr.personid
			and isra.objectid = v_parent1providerid::character varying
			and isra.objecttype = 'prov_provider' 
			and coalesce(isra.isprimary, false) = true
			-- and isra.activeflag = 1
			and isra.intakeservicerequestpersontypekey = 'APLCNT'
			and pr.activeflag = 1
		order by isra.insertedon desc 
		limit 1 ;
		/*
		SELECT first_nm, last_nm 
			into v_parent1firstname, v_parent1lastname 
		from tb_prov_approval_person 
		where approval_person_id = v_adoptiveparent1id
			and provider_approval_id = v_provider_approval_id; 

		INSERT INTO 
		person (firstname, lastname, activeflag, insertedby, updatedby) 
		values (v_parent1firstname, v_parent1lastname, 1, v_userid, v_userid)
		RETURNING "personid" INTO l_parent1personid;
		*/
		
		INSERT INTO 
		cjams.adoptioncaseactor (adoptioncaseid, personid, actortypekey, activeflag, insertedby, updatedby)
		-- VALUES (l_adoptioncaseid, l_parent1personid, 'ADOPTIVEPARENT', 1, v_userid, v_userid);
		VALUES (l_adoptioncaseid, v_applicantid, 'ADOPTIVEPARENT', 1, v_userid, v_userid);

		if v_applicant_clientflag = 2 then 
			update person 
			set --clientflag = 1, 
				providerid = v_parent1providerid,
				updatedon = now(), 
				updatedby = v_userid
			where personid = v_applicantid ;
		end if;
		
		if v_applicant_MDM_ID is null then
			l_parent1id := v_applicantid;
		else
			l_parent1id := null;
		end if;
		
		--  END IF;

		-- IF(v_ag.adoptiveparent2id is not null) THEN
		IF(v_adoptiveparent2id is not null) THEN

			-- Adoptive Parent 2 - Cp-Applicant
			select pr.personid, 
				pr.clientflag, 
				( select pid.personidentifiervalue
					from personidentifier pid
					where pid.personid = pr.personid
						and pid.activeflag = 1
						and pid.personidentifiertypekey = 'MDM_ID'
				) as MDM_ID
			into v_co_applicantid,
				 v_co_applicant_clientflag,
				 v_co_applicant_MDM_ID
			from intakeservicerequestactor isra,
				actor ac,
				person pr
			where isra.actorid = ac.actorid
				and ac.personid = pr.personid
				and isra.objectid = v_parent1providerid::character varying
				and isra.objecttype = 'prov_provider' 
				and coalesce(isra.isprimary, false) = true
				-- and isra.activeflag = 1
				and isra.intakeservicerequestpersontypekey = 'COAPLCNT'
				and pr.activeflag = 1
			order by isra.insertedon desc 
			limit 1 ;
			/*
			-- SELECT first_nm, last_nm into v_parent2firstname, v_parent2lastname from tb_prov_approval_person where approval_person_id = v_ag.adoptiveparent2id;
			SELECT first_nm, last_nm 
				into v_parent2firstname, v_parent2lastname 
			from tb_prov_approval_person 
			where approval_person_id = v_adoptiveparent2id
				and provider_approval_id = v_provider_approval_id;

			INSERT INTO 
				person (firstname, lastname, activeflag, insertedby, updatedby) 
			values (v_parent2firstname, v_parent2lastname, 1, v_userid, v_userid)
			RETURNING "personid" INTO l_parent2personid;
			*/
			
			
			If v_co_applicantid is not null then 
				INSERT INTO 
					cjams.adoptioncaseactor (adoptioncaseid, personid, actortypekey, activeflag, insertedby, updatedby)
				-- VALUES(l_adoptioncaseid, l_parent2personid, 'ADOPTIVEPARENT', 1, v_userid, v_userid);
				VALUES(l_adoptioncaseid, v_co_applicantid, 'ADOPTIVEPARENT', 1, v_userid, v_userid);
				
				if v_co_applicant_clientflag = 2 then 
					update person 
					set --clientflag = 1, 
						providerid = coalesce(v_provider2id, v_parent1providerid),
						updatedon = now(), 
						updatedby = v_userid
					where personid = v_co_applicantid ;
				end if;
				
				if v_co_applicant_MDM_ID is null then
					l_parent2id := v_co_applicantid;
				else
					l_parent2id := null;
				end if;
			else
				l_parent2id := null;
			end if;	
		else
			l_parent2id := null;
		END IF;

		-- END LOOP;

		-- CIDM-1181
		select fullname
			into v_username 
		from userprofile 
		where securityusersid = v_userid;

		v_msg:= 'Adoption case ' || l_adoptioncasenumber::character varying  || ' created and assigned to you. Adoption case created by ' || v_username::character varying  || '.';

		select send_notification 
			into v_notifystatus 
		from send_notification( 
								v_assigntoid, -- Adotion caseworker 
								v_userid, -- User creating the Adoption Case 
								v_assigntoid, -- Adotion caseworker 
								'System', 
								'High', 
								v_msg, 
								v_msg, 
								l_adoptioncaseid::varchar
							  );
							  

			
		SELECT routingintake INTO l_response 
			FROM routingintake(
				l_adoptioncaseid:: character varying ,l_supervisor,'ADPC',2,'Adoptioncase Created', coalesce(v_assigntoid, v_userid),
				true,false,false, 'Adoptioncase Created','Adoptioncase Created', 
				v_servicecaseid:: character varying,'' , 1);
				 
		INSERT INTO cjams.tb_client_eligibility 
			(start_dt, 
			 end_dt, 
			 eligibility_type_cd, 
			 eligibility_status_cd, 
			 client_id, 
			 removal_id, 
			 create_user_id, 
			 update_user_id, 
			 delete_sw, 
			 adoption_id, 
			 case_id, 
			 data_valid_sw, 
			 client_merge_id, 
			 guardian_subsidy_id, 
			 transactionid, 
			 create_ts, 
			 update_ts)   
		SELECT
			-- New logic (CDM-15927)
			coalesce(
			(select adb.finalizationdate::date 
				from adoptionbreakthelink adb
			 where adb.adoptionplanningid = ac.adoptionplanningid
				and adb.activeflag = 1
			 order by adb.insertedon desc
			 limit 1)
			, ac.startdate::date),	
			-- (SELECT ag.finalizationdate::date FROM adoptionagreement ag WHERE ag.adoptionplanningid = ac.adoptionplanningid order by ag.insertedon desc limit 1),
			null,  
			'2934', 
			'2909', 
			v_clientid, 
			null,
			ac.insertedby,
			ac.updatedby, 
			'N',
			(SELECT alternateid FROM  adoptionplanning ap
			WHERE ap.adoptionplanningid = ac.adoptionplanningid order by ap.insertedon desc limit 1), -- send alternate id of adoption planning here 
			ac.adoptioncasenumber::bigint,
			null,
			null,
			null,
			null,
			now(),
			now()
		FROM cjams.adoptioncase ac 
		where ac.adoptioncaseid = l_adoptioncaseid 
			and ac.activeflag = 1 
		limit 1 ;     

		FOR v_tousersid IN 
		  select up.securityusersid from userprofile up 
			inner join teammemberassignment tma on tma.securityusersid = up.securityusersid
			inner join teammember tm on tm.teammemberid = tma.teammemberid 
		  where up.teamtypekey = 'CW' and tm.roletypekey = 'IVESV'
		  loop
			SELECT COALESCE(lastname,'')||', '|| COALESCE(firstname,'')into v_username FROM userprofile WHERE securityusersid = v_userid;
			v_msg:= concat('Adoption initial determination for client id ', v_clientid::text , ' is assigned by ', COALESCE( v_username,''));
			SELECT send_notIFication INTO v_notifystatus FROM send_notIFication( v_tousersid.securityusersid,v_userid, v_tousersid.securityusersid,
			'System', 'High', v_msg, v_msg , l_adoptioncaseid::varchar);
		end loop;      
			   
		/*Logged in user role details*/ 
	  
		IF coalesce(v_assigntoid, '') <> '' THEN
			v_userid := v_assigntoid;
		END IF;

		SELECT  t.teamid  INTO  l_fromteamid 
		  FROM    teammemberassignment tma 
		  INNER JOIN  teammember tm ON tm.teammemberid = tma.teammemberid AND tm.activeflag =1
		  INNER JOIN team t on t.teamid = tm.teamid  and t.activeflag =1
		  WHERE  tma.SecurityUsersId = v_userid
		  AND   tma.activeflag =1;
		 
		 
		 SELECT   toworkeridno, responsibilitytypekey, fromldssid 
					INTO l_assignedsecurity,l_responsibilitytypekey,l_fromldssid
		 FROM     caseassignment 
		   WHERE    objectid = v_servicecaseid AND objecttypekey = 'servicecase' AND responsibilitytypekey = 'family'
		ORDER BY insertedon DESC LIMIT 1;
	   
		if (coalesce(l_responsibilitytypekey,'') = '')
		then 
			SELECT   toworkeridno, fromldssid
			INTO l_assignedsecurity,l_fromldssid
			FROM     caseassignment 
			WHERE    objectid = v_servicecaseid AND objecttypekey = 'servicecase'
			ORDER BY insertedon DESC LIMIT 1;
			 
			l_responsibilitytypekey:= 'family';
		end if;

		/*INSERT INTO caseassignment(fromworkeridno, toworkeridno, insertedby, updatedby, insertedon, updatedon, objecttypekey, objectid,startdate,fromteamid,toteamid,responsibilitytypekey,fromldssid,toldssid,assignmenttype,assigndate)
		VALUES(l_supervisor,l_assignedsecurity,v_userid,v_userid,now(),now(),'adoptioncase',l_adoptioncaseid,now(),l_fromteamid,l_toteamid,l_responsibilitytypekey,l_fromldssid,l_toldssid,'W',now()::date);
		*/
	  
		/* Assign the case to the same worker who breaks the link */
		/* Populate to-user details */
		SELECT  t.teamid, t.countyid  INTO  l_toteamid, l_toldssid
		  FROM    teammemberassignment tma 
		  INNER JOIN  teammember tm ON tm.teammemberid = tma.teammemberid AND tm.activeflag =1
		  INNER JOIN team t on t.teamid = tm.teamid  and t.activeflag =1
		  WHERE  tma.SecurityUsersId = v_userid
		  AND   tma.activeflag =1;
	  
		INSERT INTO caseassignment(fromworkeridno, toworkeridno, insertedby, updatedby, insertedon, updatedon, objecttypekey, objectid,startdate,fromteamid,toteamid,responsibilitytypekey,fromldssid,toldssid,assignmenttype,assigndate)
		VALUES(l_supervisor,v_userid,v_userid,v_userid,now(),now(),'adoptioncase',l_adoptioncaseid,now(),l_fromteamid,l_toteamid,l_responsibilitytypekey,l_fromldssid,l_toldssid,'W',now()::date);


		RETURN QUERY  
		SELECT l_adoptioncasenumber, 
			l_adoptioncaseid, 
			l_personid, 
			l_parent1id::uuid,
			l_parent2id::uuid,
			'Success':: character varying;

	end if;
 
END;
 
$function$
;