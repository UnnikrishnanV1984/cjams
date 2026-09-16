DROP FUNCTION IF EXISTS cjams.getpersonsbyservicecase(uuid, integer, integer);

CREATE OR REPLACE FUNCTION cjams.getpersonsbyservicecase(v_servicecaseid uuid, _page integer, _limit integer)
 RETURNS TABLE(totalcount bigint, rolename character varying, dcn character varying, personid uuid, fullname character varying, prefx character varying, firstname character varying, lastname character varying, middlename character varying, suffix character varying, gender character varying, dob timestamp without time zone, age text, incidentage text, ageat26years timestamp without time zone, ageat14years timestamp without time zone, icwastatusinquiry character varying, icwaeligibleformembership character varying, icwatribename character varying, dateofdeath timestamp without time zone, isapproxdod integer, address character varying, dangeraddress boolean, address2 character varying, state character varying, city character varying, zipcode character varying, county character varying, height character varying, weight character varying, haircolortypekey character varying, hairtexturetypekey character varying, eyecolortypekey character varying, physicalbuildtypekey character varying, skintonetypekey character varying, hairtextureotherdesc character varying, haircolorotherdesc character varying, isglasses boolean, employername character varying, clienttitle character varying, race json, phonenumber character varying, workphone character varying, dangerous json, hospitaldetails json, actorid uuid, intakeservicerequestactorid uuid, isalleged integer, priorscount integer, reported boolean, refusessn boolean, refusedob boolean, userphoto text, primarylanguageid character varying, primarylanguage character varying, secondarylanguageid character varying, secondarylanguage character varying, otherprimarylanguagetypekey character varying, email character varying, roles json, relationship text, relationshiparray json, fourerelid integer, ishousehold integer, iscollateralcontact integer, schoolname json, ssn character varying, assistpid character varying, cjamspid bigint, strengths character varying, needs character varying, medicalinformation json, medicationinformation json, addendum json, medicalcondition json, emergency json, ethinicity character varying, religion character varying, racetypekey character varying, fetalalcoholspctrmdisordflag integer, drugexposednewbornflag integer, probationsearchconductedflag integer, sexoffenderregisteredflag integer, servicecaseid uuid, intakeserviceid uuid, caseheadname character varying, statustypekey character varying, isplacement integer, removaldate timestamp without time zone, removaldtforcaseplan timestamp without time zone, removalid bigint, adoptionremovalid bigint, citizenalenageflag integer, isqualifiedalien integer, alienregistrationtext character varying, verificationremarks character varying, alienstatustypekey character varying, issafe integer, mdm character varying, programareabyservicecase json, programarea json, isheadofhousehold boolean, biologicalmothermarriedsw integer, ivedeterminationdetails json, iverejecteddeterminationdetails json, gapdeterminationdetails json, gaprejecteddeterminationdetails json, iveadoptiondetails json, iveadoptionrejecteddetails json, is_mdm_sync boolean, everbeenadoptedflag integer, cferesourcehomechild boolean, limitedenglishproficiency boolean, needtranslatorinterpreter boolean,readingproficiency boolean, writingproficiency boolean, speakingproficiency boolean,
 effectivedate timestamp without time zone, clientflag integer, activeremovalservicecase character varying, userroles character varying, rolehistory json, birthmatchdetails json, maritalstatustypekey character varying, aliasname character varying, preadoptiondate timestamp without time zone, intercountryadoption integer, priorlegalguardianship integer, preplacementguardianshipdate timestamp without time zone, senstatusflag integer, sennotifications json, nationalitytypekey character varying, primarycitizenshiptypekey character varying, seccitizenshiptypekey character varying, isbioadoptedflag integer, dobtdiffwithincidentdate integer, cfe_diff_dates json,
 substanceexposednewbornsourceid character varying, substanceexposednewbornsourcetype character varying, substanceexposednewborntimetamp timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
-------------------------------------------------------------------------------------------
--Revision(s)
-- 06/08/2022 - Smitha Somasekharan - To fix the person missing issue -(CDM -22944), PR # -5636
-- 07/13/2022 - Pratap P - add Marital status -(CIDM-5027)
-- 07/18/2022 - Vijaya Laxmi Devunoori - add preadoptiondate, intercountryadoption, priorlegalguardianship, preplacementguardianshipdate - (CIDM-5099)
-- 08/15/2022 - Vineet Tirodkar - To fix the Person Substance Exposed Newborn Flag logic (CIDM-5306)
-- 03-20/2023 Mounika Gudise- Addded isbioadoptedflag column to check whether the client is biocase or not (CIDM-6864)
-- 04/10/2023 Mukesh Reddy - county logic changed (joined with refrence values for getting the county name) (CDM-29581)
-- 10/04/2023 - Vineet Tirodkar - Modifications CfE Differential Board Rates Extension (CIDM-8046/B-178498)
-- 10-12-2023 Veera B97262_CIDM8070_Person Card - Rejected IV-E decision
-- 10-24-2023 Veera B97264_CIDM8116_Person Card - Rejected IV-E decision
-- 10-25-2023 Veera B-97263-CIDM-8097 Person Card Rejected status for Adoption cases
-- CDM-35832 - Veera Nadimpalli Safec Issues
-- CIDM-8182 - Duplicate role displayed
--06/05/2024- sai kothapalli-CIDM-8742- Kinship Navigation Services
--06/05/2024 - Akhil Katukuri - Revert Sai Kothapalli code to unblock QA
--06/10/2024 - Akhil Katukuri - commented out end date null check as we need to display program area even with not null date
--06/12/2024 - Akhil Katukuri - added enddate null check so that program area will not show up when end dated.
--06/14/2024 - Akhil Katukuri - Update the else case for kinship to make getcaseservice null
-- 09/17/2024 - Veera Nadimpalli - CDM-41639 , CDM-41630 , CDM-41629 , CDM-41628 , CDM-41627 Person load issue fix
-- 08/22/2024 - CIDM-9160 - Veera changes for Living arrangement and hospitalization user story 
-- 10/15/2024 - CIDM-9160 - Veera changes for Living arrangement and hospitalization user story 
-- 02/06/2024 - CIDM-10020 - User story changes to get case id for program area 
-- 08/06/2025 - CIDM-10473 - Simar Singh - adding Alias name as part of the service case getpersondetailcw
-- 01/08/2026 - CIDM-10984 - Manasa Kasula - Changes to fetch sen fields for sen untimely story
---01/08/2026 --CIDM-10981--Umasankar Raavi --Added additional Person table columns for the Limited English Proficiency (LEP) user story
-------------------------------------------------------------------------------------------
DECLARE                    
_offset integer;
jsondatas json;
narativeval json;
obj json;
incidentdate timestamp without time zone;
incidentdateval character varying;

begin
	
_offset := (_page - 1) * _limit;

For    jsondatas    in    SELECT   idas.jsondata::json    FROM    intakedastaging idas where 
	idas.intakenumber =(select inss.intakenumber from intakeservicerequest inss where inss.servicecaseid = v_servicecaseid order by inss.insertedon desc  limit 1)   and idas.activeflag =1
LOOP 
    obj := jsondatas->>'General';
	raise notice 'teslsldst %' ,incidentdate;
	incidentdateval := obj->>'RecivedDate';
	if(incidentdateval != '' )
	then
		raise notice 'qqqqqqqqqqqqqqqqqqqq %' ,incidentdate;
		incidentdate := incidentdateval ::timestamp without time zone; 
	else 
	incidentdate := null;
	raise notice 'else %' ,incidentdate;
	end if;
END  loop ;

raise notice 'test %',incidentdate;

RETURN QUERY
SELECT 
	"Person".totalcount,
	'' :: character varying ,
	"Person".dcn,
	"Person".personid,
	"Person".fullname,
	"Person".prefx,
	"Person".firstname,
	"Person".lastname,
	"Person".middlename,
	"Person".suffix,
	"Person".typedescription,
	"Person".dob ,
	"Person".age,
	"Person".incidentage,
	"Person".ageat26years,
	"Person".ageat14years,
	"Person".icwastatusinquiry,
	"Person".icwaeligibleformembership,
	"Person".icwatribename,
	"Person".dateofdeath,
	"Person".isapproxdod,
	"Person".address,
	"Person".dangeraddress,
	"Person".address2,
	"Person".state,
	"Person".city,
	"Person".zipcode,
	"Person".county,
	"Person".height :: character varying,
	"Person".weight :: character varying,
	"Person".haircolortypekey,
	"Person".hairtexturetypekey,
	"Person".eyecolortypekey,
	"Person".physicalbuildtypekey,
	"Person".skintonetypekey,
	"Person".hairtextureotherdesc,
	"Person".haircolorotherdesc,
	"Person".isglasses,
	"Person".employername,
	"Person".clienttitle,
	(select json_agg(x) from (select prt.racetypekey from personracetypemap prt where prt.personid="Person".personid and prt.activeflag=1) x) as race,
	(
		SELECT ph.phonenumber
		FROM personphonenumber ph  
		WHERE ph.personid = "Person".personid  AND activeflag = 1
		ORDER BY insertedon DESC LIMIT 1
	),
	(
		SELECT ph.phonenumber
		FROM personphonenumber ph  
		WHERE ph.personid = "Person".personid  AND activeflag = 1 AND personphonetypekey = 'WK'
		ORDER BY insertedon DESC LIMIT 1
	),
	"Person".dangerous,
	"Person".hospitaldetails,
	"Person".actorid,
	(select ia.intakeservicerequestactorid from intakeservicerequestactor ia inner join cjams.referencevalues rv on rv.ref_key = ia.intakeservicerequestpersontypekey 
	and rv.referencetypeid=176 and rv.activeflag = 1 and coalesce(rv.teamtypekey, 'CW') = 'CW' where IA.activeflag = 1 and ia.actorid = "Person".actorid and ia.servicecaseid = v_servicecaseid order by rv.displayorder asc limit 1),
	-- "Person".intakeservicerequestactorid,
	null :: integer,
	NULL :: integer,
	"Person".reported,
	"Person".RefuseSSN,
	"Person".RefuseDOB,
	"Person".userphoto  ::text,
	"Person".primarylanguageid,
	null :: character varying,
	null :: character varying,
	null :: character varying,
	null :: character varying,
	"Person".email :: character  varying  ,
	"Person".roles ::json,
	"Person".relationship ,
	"Person".relationshiparray,
	"Person".fourerelid,
	"Person".ishousehold,
	"Person".iscollateralcontact,
	null :: json,                                                                                                                             
	"Person".ssnno :: character varying,  
	"Person".assistpid,
	"Person".cjamspid,
	"Person".strengths,
	"Person".needs,
	null ::json,
	null ::json,
	null ::json,
	null ::json,
	null ::json,
	"Person".ethinicity :: character varying,
	"Person".religion :: character varying,
	"Person".racetypekey :: character varying,
	null:: integer,
	"Person".drugexposednewbornflag :: integer,
	null:: integer,
	null:: integer,
	"Person".servicecaseid,
	"Person".intakeserviceid,
	"Person".caseheadname,
	"Person".statustypekey,
	"Person".isplacement,
	"Person".removaldate,
	"Person".removaldtForCasePlan,
	"Person".removalid,
	"Person".adoptionRemovalid,
	"Person".citizenalenageflag,
	"Person".isqualifiedalien,
	"Person".alienregistrationtext,
	"Person".verificationremarks,
	"Person".alienstatustypekey,
	(
		SELECT COALESCE(aa.issafe,0)
		FROM assessment asmt 
		--INNER JOIN assessmentsubmission asn on asmt.assessmentid = asn.assessmentid and asn.datakey = 'dateassessmentinitiated' and asn.activeflag = 1
		INNER JOIN assessmentactor aa on asmt.assessmentid = aa.assessmentid and asmt.activeflag = 1 and aa.activeflag = 1
		INNER JOIN intakeservicerequestactor bb on aa.intakeservicerequestactorid = bb.intakeservicerequestactorid
		WHERE asmt.activeflag=1 and aa.activeflag=1 --and asn.activeflag=1 
		and assessmenttemplateid ='0f01e16c-73db-42d8-ad84-04eeb5e26418' and assessmentstatustypekey in ('Review', 'Accepted')
		and bb.personid = "Person".personid order by asmt.updatedon desc LIMIT 1
	),
	cast('Y' as character varying) as mdm,
	"Person".programareabyservicecase,
	"Person".programarea,
	COALESCE((SELECT isa.isheadofhousehold FROM intakeservicerequestactor isa WHERE  isa.personid = "Person".personid AND isa.servicecaseid = v_servicecaseid AND isa.isheadofhousehold = TRUE AND isa.activeflag = 1  LIMIT 1),false) ishoh,
	"Person".biologicalmothermarriedsw,
	"Person".ivedeterminationdetails,
    "Person".iverejecteddeterminationdetails,
	"Person".gapdeterminationdetails,
	"Person".gaprejecteddeterminationdetails,
    "Person".iveadoptiondetails,
	"Person".iveadoptionrejecteddetails,
	"Person".is_mdm_sync,
	"Person".everbeenadoptedflag,
	"Person".cferesourcehomechild,
	"Person".limitedenglishproficiency,
	"Person".needtranslatorinterpreter,
	"Person".readingproficiency,
	"Person".writingproficiency,
	"Person".speakingproficiency,
	"Person".effectivedate,
	"Person".clientflag,
	"Person".activeremovalservicecase,
        (case when "Person".roles is not null
                then (with roletable as (
                            select 1 id, "Person".roles  js
                                )
                                select string_agg(j.v ->> 'typedescription', ', ') vals
                                from roletable t
                                cross join lateral jsonb_array_elements( (js::jsonb)) j(v)
                                where j.v ->> 'typedescription'  is not null
                                group by t.id
                ) else null end)::character varying, 
	"Person".rolehistory,
	(select json_agg(f) as birthmatchdetails from
			(select * from personbirthmatch ph where ph.personid = "Person".personid and activeflag = 1 order by insertedon desc) as f 
	) ::json, 
	"Person".maritalstatustypekey,
	(
	select 
		(CONCAT(a.prefixtypekey , ' ',a.firstname, ' ', a.middlename, ' ', a.lastname, ' ', a.sfxname) ) 
		as aliasname
	from
		alias a
	where 
		a.personid = "Person".personid
		and a.activeflag = 1
	limit 1) :: character varying,
	"Person".preadoptiondate, 
	"Person".intercountryadoption, 
	"Person".priorlegalguardianship, 
	"Person".preplacementguardianshipdate, 
	"Person".senstatusflag,
	(select json_agg(x) as sennotifications from
			(select * from senhistorynotifications sh where sh.personid = "Person".personid and activeflag = 1 order by insertedon desc) as x 
	) ::json,
	"Person".nationalitytypekey,
	"Person".primarycitizenshiptypekey,
	"Person".seccitizenshiptypekey,
	"Person".isbioadoptedflag,
	"Person".dobtdiffwithincidentdate::int,
	(select json_agg(x) as cfe_diff_dates from
		(select start_dt,
			end_dt
		 from tb_fiscal_category_master 
		 where fiscal_category_id = 174
			and delete_sw = 'N' 
		) as x 
	)::json,
	"Person".substanceexposednewbornsourceid,
	"Person".substanceexposednewbornsourcetype,
	"Person".substanceexposednewborntimetamp
FROM  
(
	SELECT
		DISTINCT ON (P.personid)
		count(1) over() AS totalcount,
        IAR.intakeserviceid,
       	P.biologicalmothermarriedsw,
        SC.caseheadname,
        SC.statustypekey,
        SC.servicecaseid,
		(
			SELECT
				personidentifiervalue
			FROM personidentifier pid
			WHERE pid.personid = P.personid AND personidentifiertypekey = 'DCN' AND activeflag = 1 LIMIT 1
		) AS dcn,
		P.personid,
		concat_ws(' ',coalesce(p.prefx,null),coalesce(p.firstname,null),coalesce(p.middlename,null),coalesce(p.lastname,null),coalesce(p.suffix,null) ):: character varying as fullname,
		p.prefx,
		p.firstname,
		p.lastname,
		p.middlename,
		p.suffix,
		G.typedescription,
		p.senstatusflag,
		p.dob,
		CASE WHEN EXTRACT(YEAR FROM age(coalesce(p.dateofdeath, now()), p.dob)) <= 0 THEN 
			CASE WHEN EXTRACT(MONTH FROM age(coalesce(p.dateofdeath, now()), p.dob)) <= 0 THEN 
				CONCAT (EXTRACT(DAY FROM age(coalesce(p.dateofdeath, now()), p.dob)) :: CHARACTER varying, ' ', 'Day(s)') 
				ELSE CONCAT (EXTRACT(MONTH FROM age(coalesce(p.dateofdeath, now()), p.dob)) :: CHARACTER varying, ' ', 'Month(s)') 
			END 
		ELSE CONCAT (EXTRACT(YEAR FROM age(coalesce(p.dateofdeath, now()), p.dob)) :: CHARACTER varying,' ', 'Yrs') END AS age,
    	EXTRACT(YEAR FROM age(now(), p.dob)) age1,
    	
    	(CASE WHEN incidentdate::date < p.dob::date then
         	 '0 day(s)'
         ELSE
    		( CASE WHEN EXTRACT(YEAR FROM age(coalesce(incidentdate,null), p.dob)) <= 0 THEN 
				CASE WHEN EXTRACT(MONTH FROM age(coalesce(incidentdate,null), p.dob)) <= 0 THEN 
					CONCAT (EXTRACT(DAY FROM age(coalesce(incidentdate,null) ,p.dob)) :: CHARACTER varying, ' ', 'Day(s)') 
				ELSE
					CONCAT (EXTRACT(MONTH FROM age(coalesce(incidentdate,null), p.dob)) :: CHARACTER varying, ' ', 'Month(s)') 
				END 
			 ELSE 
				CONCAT (EXTRACT(YEAR FROM age(coalesce(incidentdate,null), p.dob)) :: CHARACTER varying,' ', 'Yrs') 
			 END 
			)
		end)  AS incidentage,		
		DATE_PART('day', incidentdate::timestamp - p.dob::timestamp) as dobtdiffwithincidentdate,
		p.dob + interval '26 years' as ageat26years,
		p.dob + interval '14 years' as ageat14years,
		p.icwastatusinquiry,
		p.icwaeligibleformembership,
		p.icwatribename,
		
    	EXTRACT(YEAR FROM age(coalesce(incidentdate,null), p.dob)) age2,
		p.dateofdeath,
		p.isapproxdod,
		p.userphoto,
		p.primarylanguageid,
		p.secondarylanguageid,
		p.otherprimarylanguagetypekey, 
		(select pa.address  from personaddress AS pa  where pa.personid=p.personid and  pa.currentlocationflag = 1 AND pa.activeflag=1 
        order by updatedon desc	limit 1) address,
		(select pa.danger  from personaddress AS pa  where pa.personid=p.personid and  pa.currentlocationflag = 1 AND pa.activeflag=1 
        order by updatedon desc	limit 1) dangeraddress,
		(select pa.address2  from personaddress AS pa  where pa.personid=p.personid and  pa.currentlocationflag = 1 AND pa.activeflag=1 
        order by updatedon desc	limit 1) address2,
		(select pa.state  from personaddress AS pa  where pa.personid=p.personid and  pa.currentlocationflag = 1 AND pa.activeflag=1 
        order by updatedon desc	limit 1) state,
		(select pa.city  from personaddress AS pa  where pa.personid=p.personid and  pa.currentlocationflag = 1 AND pa.activeflag=1 
        order by updatedon desc	limit 1) city,
		(select pa.zipcode  from personaddress AS pa  where pa.personid=p.personid and  pa.currentlocationflag = 1 AND pa.activeflag=1 
        order by updatedon desc	limit 1) zipcode,
        (select rf.value_text from referencevalues rf where rf.activeflag=1 and rf.referencetypeid = '306' and rf.ref_key::character varying  in (select pa.county from personaddress AS pa  where pa.personid=p.personid and  pa.currentlocationflag = 1 AND pa.activeflag=1 
       order by pa.updatedon desc	limit 1) order by rf.insertedon limit 1) county,
		ppa.attributevalue as height,
		ppat.attributevalue as weight,
		p.haircolortypekey,
		p.hairtexturetypekey,
		p.eyecolortypekey,
		p.physicalbuildtypekey,
		p.skintonetypekey,
		p.hairtextureotherdesc,
     	p.haircolorotherdesc,
     	p.isglasses,
     	p.employername,
     	p.clienttitle,
		(select json_agg(v) as dangerous from (
				SELECT prole.dangertoself,prole.isdangertoworker,prole.updatedon
				from personrole as prole WHERE activeflag=1
				AND  prole.personid = p.personid
				order by prole.updatedon desc limit 1
		) as v ) ::json, 
		(select json_agg(v) as hospitaldetails from (
				SELECT ph.hospital_inpatientadmissiondate , ph.hospital_discharged, ph.hospital_dischargeddate , ph.hospital_overstay , ph.hospitalizationid , ph.notificationdate
				from personhospitalization as ph WHERE ph.activeflag=1 and (ph.hospital_inpatientadmission = true or ph.hospital_erexamination = true)
				AND  ph.personid = p.personid and ph.hospital_dischargeddate is null and ph.hospital_discharged is not true and ph.hospital_overstay = false and ph.objectid is not null
				order by ph.updatedon desc limit 1
		) as v ) ::json,
		AC.actorid,
	    IAR.Intakeservicerequestactorid AS intakeservicerequestactorid,
	    NULL isvictim,
		NULL ::bool reported,
		NULL ::bool RefuseSSN,
		NULL ::bool RefuseDOB,
		( select max(personemail.email) from personemail where personemail.personid = P.personid and personemail.activeflag = 1 )email,
		(
		select json_agg(e) as roles
		from
			(
			select
				isrpn.intakeservicerequestpersontypekey,
				at.value_text as typedescription,
				isrpn.intakeservicerequestactorid
			from
				intakeservicerequestactor ISRPN
			inner join referencevalues at on	
			at.ref_key = isrpn.intakeservicerequestpersontypekey
			where
				isrpn.actorid = ac.actorid
				and (isrpn.servicecaseid = v_servicecaseid    )
				and isrpn.activeflag = 1
     			and at.referencetypeid in (176) -- changed by CIDM-8182
            	and coalesce(at.teamtypekey, 'CW') = 'CW'
				and isrpn.intakeservicerequestpersontypekey not in ('AM')
			group by
				isrpn.intakeservicerequestpersontypekey,
				at.value_text,
				isrpn.intakeservicerequestactorid
			) as e ) ::json,
		CASE 
			WHEN IAR.intakeservicerequestpersontypekey IN ('RC','CHILD','BIOCHILD') 
			THEN 
				(SELECT AT.typedescription FROM Actortype AT WHERE AT.Actortype = IAR.intakeservicerequestpersontypekey AND AT.activeflag=1 LIMIT 1)
			ELSE 
			(
				SELECT 
					rt.description 
				FROM relationshiptype rt 
				INNER JOIN actorrelationship ar ON rt.relationshiptypekey= ar.relationshiptypekey AND ar.activeflag=1 AND rt.activeflag =1 
				INNER JOIN intakeservicerequestactor IR on AR.intakeservicerequestactorid = ir.intakeservicerequestactorid AND IR.servicecaseid = SC.servicecaseid 
					AND IR.activeflag = 1
				INNER JOIN Actor a on a.actorid = IR.actorid
				WHERE ir.actorid = AC.actorid
				GROUP BY rt.description LIMIT 1
			) 
		END AS relationship,
		
		(
		 select json_agg(x) from (
	      select * from (
            select distinct on (ar.person1id,ar.person2id,rt.description,up.firstname,up2.firstname) ar.person1id as secondaryuserid,ar.person2id as primaryuserid,rt.description,up.firstname,up2.firstname, ar.updatedon
		FROM 	actor a
            INNER JOIN intakeservicerequestactor isa ON isa.actorid = a.actorid
            INNER JOIN person up ON up.personid = a.personid
            LEFT JOIN actorrelationship ar ON ar.person2id = up.personid and ar.activeflag = 1
			INNER JOIN person up2 on up2.personid = ar.person2id
            LEFT JOIN relationshiptype rt on rt.relationshiptypekey= ar.relationshiptypekey  AND rt.activeflag=1
            WHERE	a.activeflag=1 and isa.activeflag=1
            AND 
            		isa.servicecaseid =  SC.servicecaseid)y order by updatedon desc
			) x
		) :: json as relationshiparray,
		
        (
            SELECT 
                rt.fourerelid 
            FROM relationshiptype rt 
            INNER JOIN actorrelationship ar ON rt.relationshiptypekey= ar.relationshiptypekey AND ar.activeflag=1 AND rt.activeflag =1 
            INNER JOIN intakeservicerequestactor IR on AR.intakeservicerequestactorid = ir.intakeservicerequestactorid AND IR.servicecaseid = SC.servicecaseid 
                AND IR.activeflag = 1
            INNER JOIN Actor a on a.actorid = IR.actorid
            WHERE ir.actorid = AC.actorid
            GROUP BY rt.fourerelid LIMIT 1
        ) AS fourerelid,
        AC.ishouseholdmember AS ishousehold,  
        AC.iscollateralcontact AS iscollateralcontact,
		NULL::json,
		p.ssnno AS ssnno,
		coalesce((select pii.personidentifiervalue from personidentifier pii where pii.personidentifiertypekey = 'IRN' and pii.personid = p.personid and pii.activeflag = 1 limit 1), p.cisclientid) as assistpid,
		p.cjamspid,
		p.strengths,
		p.needs,  
        NULL ::json,  
		NULL ::json,
		NULL ::json , 
		NULL ::json,
		NULL ::json,
       	p.ethnicgrouptypekey AS ethinicity,
		p.religiontypekey AS religiontypekey,
       	( SELECT typedescription FROM religiontype WHERE religiontypekey = p.religiontypekey ) AS religion,
       	NULL racetypekey,
		NULL fetalalcoholspctrmdisordflag,
		-- CIDM-5306
		-- (select prl.drugexposednewbornflag from personrole prl where prl.personid = p.personid and prl.servicecaseid = v_servicecaseid limit 1) as  drugexposednewbornflag,
		COALESCE(p.substanceexposednewbornflag, 0) as  drugexposednewbornflag,
		NULL probationsearchconductedflag,
		NULL sexoffenderregisteredflag,
		/*(select case when count(1)>0 then 1 else 0 end from tb_placement where client_id = p.cjamspid) */
    	1 AS isplacement,
		(
			SELECT
				icr.removaldate
			FROM intakeservreqchildremoval icr  
			INNER JOIN intakeservicerequestactor ir ON ir.intakeservicerequestactorid = icr.intakeservicerequestactorid 
			WHERE icr.servicecaseid = v_servicecaseid and ir.personid = p.personid AND icr.exitdate IS NULL AND icr.activeflag =1
			ORDER BY 1 DESC LIMIT 1
		) AS removaldate,
		(   SELECT
				icr.removaldate
			FROM intakeservreqchildremoval icr  
			INNER JOIN intakeservicerequestactor ir ON ir.intakeservicerequestactorid = icr.intakeservicerequestactorid 
			WHERE icr.servicecaseid = v_servicecaseid and ir.personid = p.personid AND icr.activeflag =1
			ORDER BY 1 DESC LIMIT 1
		) AS removaldtForCasePlan,
		(
			select icr.removalid from 
			intakeservreqchildremoval icr
			inner join intakeservicerequestactor ir on ir.intakeservicerequestactorid = icr.intakeservicerequestactorid
			where icr.servicecaseid = v_servicecaseid and ir.personid = p.personid AND icr.activeflag =1 order by 1 desc limit 1
		) AS removalid,
		(
			select icr.removalid from 
			intakeservreqchildremoval icr
			inner join intakeservicerequestactor ir on ir.intakeservicerequestactorid = icr.intakeservicerequestactorid
			where icr.servicecaseid = v_servicecaseid and ir.personid = p.personid AND icr.activeflag =1 and icr.removalexitreason = 'ADPFIN' order by 1 desc limit 1
		) AS adoptionRemovalid,
		p.citizenalenageflag,
		p.isqualifiedalien,
		p.alienregistrationtext,
		p.verificationremarks,
		p.alienstatustypekey,
		case when (select count(*) from personprogramarea where objectid=v_servicecaseid::character varying AND activeflag=1 AND sourcetype = 'CW') > 0 then 
			(SELECT json_agg(e) AS programareabyservicecase 
			FROM
			(
				SELECT
					DISTINCT ppa.programkey,
					(SELECT ap.programname FROM agencyprogramarea ap 
					WHERE ap.programkey = ppa.programkey AND ap.activeflag =1 LIMIT 1 ) programname
				FROM personprogramarea ppa 
				WHERE ppa.objectid=SC.servicecaseid::character varying AND ppa.enddate IS NULL AND ppa.activeflag=1 AND ppa.programkey is not null AND ppa.sourcetype = 'CW'
			) AS e) 
		else 
			(SELECT null::json AS programareabyservicecase) 
		end,  
		(
			SELECT json_agg(e) AS programarea FROM(
			SELECT DISTINCT
				ppa.programkey,
				ppa.subprogramkey,
				(case when ppa.programkey = 'KIN' then (select sc.servicecaseid::character varying from servicecase sc where sc.servicecasenumber=ppa.entityid and sc.activeflag=1 limit 1) else ppa.objectid end) as objectid,
				(SELECT rv.description  FROM referencevalues rv  WHERE rv.ref_key = ppa.subprogramkey AND rv.referencetypeid = 12 AND rv.activeflag =1 LIMIT 1) subprogramname,
				(SELECT ap.programname FROM agencyprogramarea ap  WHERE ap.programkey = ppa.programkey AND ap.activeflag =1 LIMIT 1) programname
			FROM personprogramarea ppa 
			WHERE ppa.personid = P.personid  AND ppa.activeflag=1
			 AND ppa.enddate IS NULL 
			 AND ppa.programkey is not null
			 AND ppa.sourcetype = 'CW'
			ORDER BY ppa.programkey,ppa.subprogramkey desc ) AS e
		) ::json,
		(
			SELECT json_agg(e) AS ivedeterminationdetails FROM (
			select tbpv.description_tx as IVEstatustype, tpe.eligibility_period_id as IVEtransactionid, tpe.sqnm_sw
		    from tb_client_eligibility tbce  
			inner join tb_eligibility_period tpe on  tpe.eligibility_id = tbce.eligibility_id and tpe.delete_sw = 'N' and tpe.approvalstatus in ('PENDING','APPROVED')
			inner join tb_picklist_values tbpv on TRIM(tbpv.picklist_value_cd) = TRIM(tpe.status_cd) and tbpv.picklist_type_id = 262  
			where tbce.delete_sw = 'N' and tbce.client_id = p.cjamspid and tbce.eligibility_type_cd = '2931'
			order by tpe.eligibility_period_id desc limit 1 ) AS e
		) ::json,
		(
			SELECT json_agg(e) AS iverejecteddeterminationdetails FROM (
			select tbpv.description_tx as IVEstatustype, tpe.eligibility_period_id as IVEtransactionid, tpe.sqnm_sw, tpe.approvalstatus
		    from tb_client_eligibility tbce  
			inner join tb_eligibility_period tpe on  tpe.eligibility_id = tbce.eligibility_id and tpe.approvalstatus in ('REJECTED')
			inner join tb_picklist_values tbpv on TRIM(tbpv.picklist_value_cd) = TRIM(tpe.status_cd) and tbpv.picklist_type_id = 262  
			where tbce.delete_sw = 'N' and tbce.client_id = p.cjamspid and tbce.eligibility_type_cd = '2931'
			order by tpe.end_dt desc NULLS LAST) AS e
		) ::json,
		(
			SELECT json_agg(e) AS gapdeterminationdetails FROM (
			select tbpv.description_tx as IVEstatustype, tpe.eligibility_period_id as IVEtransactionid, tpe.sqnm_sw, tpe.approvalstatus
		    from tb_client_eligibility tbce  
			inner join tb_eligibility_period tpe on  tpe.eligibility_id = tbce.eligibility_id and tpe.delete_sw = 'N' and tpe.approvalstatus in ('PENDING','APPROVED')
			inner join tb_picklist_values tbpv on TRIM(tbpv.picklist_value_cd) = TRIM(tpe.status_cd) and tbpv.picklist_type_id = 262  
			where tbce.delete_sw = 'N' and tbce.client_id = p.cjamspid and tbce.eligibility_type_cd = '2935'
			order by tpe.sqnm_sw desc NULLS LAST limit 2  ) AS e
		) ::json,
		(
			SELECT json_agg(e) AS gaprejecteddeterminationdetails FROM (
			select tbpv.description_tx as IVEstatustype, tpe.eligibility_period_id as IVEtransactionid, tpe.sqnm_sw, tpe.approvalstatus
		    from tb_client_eligibility tbce  
			inner join tb_eligibility_period tpe on  tpe.eligibility_id = tbce.eligibility_id and tpe.approvalstatus in ('REJECTED')
			inner join tb_picklist_values tbpv on TRIM(tbpv.picklist_value_cd) = TRIM(tpe.status_cd) and tbpv.picklist_type_id = 262  
			where tbce.delete_sw = 'N' and tbce.client_id = p.cjamspid and tbce.eligibility_type_cd = '2935'
			order by tpe.sqnm_sw desc NULLS LAST ) AS e
		) ::json,
        (
			SELECT json_agg(e) AS iveadoptiondetails FROM (
			select tbpv.description_tx as adoptionstatustype, tpe.eligibility_period_id as adoptiontransactionid, tpe.sqnm_sw, tbce.client_id as adoptionclientid
		    from tb_client_eligibility tbce  
			inner join tb_picklist_values tbpv on TRIM(tbpv.picklist_value_cd) = TRIM(tbce.eligibility_status_cd) and tbpv.picklist_type_id = 262  
			inner join tb_eligibility_period tpe on  tpe.eligibility_id = tbce.eligibility_id and tpe.delete_sw = 'N' and tpe.approvalstatus in ('PENDING','APPROVED')
			where tbce.delete_sw = 'N' and tbce.client_id = p.cjamspid and tbce.eligibility_type_cd = '2934'
			order by tbce.create_ts desc limit 1 ) AS e
		) ::json,
		(
			SELECT json_agg(e) AS iveadoptionrejecteddetails FROM (
			select tbpv.description_tx as adoptionstatustype, tpe.eligibility_period_id as adoptiontransactionid, tpe.sqnm_sw, tbce.client_id as adoptionclientid
		    from tb_client_eligibility tbce  
			inner join tb_picklist_values tbpv on TRIM(tbpv.picklist_value_cd) = TRIM(tbce.eligibility_status_cd) and tbpv.picklist_type_id = 262  
			inner join tb_eligibility_period tpe on  tpe.eligibility_id = tbce.eligibility_id and tpe.delete_sw = 'N' and tpe.approvalstatus = 'REJECTED' 
			where tbce.delete_sw = 'N' and tbce.client_id = p.cjamspid and tbce.eligibility_type_cd = '2934'
			order by tbce.create_ts desc limit 1 ) AS e
		) ::json,
		(select mpd.is_mdm_sync from mdmgoldenpersondetails mpd where mpd.personid=p.personid and mpd.activeflag=1 order by mpd.insertedon desc limit 1) as is_mdm_sync,
		p.everbeenadoptedflag,
		p.cferesourcehomechild,
		p.limitedenglishproficiency,
		p.needtranslatorinterpreter,
		p.readingproficiency,
		p.writingproficiency,
		p.speakingproficiency,
		p.effectivedate,
		p.clientflag,
		(
			select sc.servicecasenumber as activeremovalservicecase 
			FROM intakeservicerequestactor isra
			JOIN Intakeservreqchildremoval irl ON isra.intakeservicerequestactorid =irl.intakeservicerequestactorid and irl.activeflag = 1 and irl.exitdate is null
			join routing r on r.objectid = irl.intakeservreqchildremovalid :: character varying AND r.activeflag =1 and r.routingstatustypeid = 16
			join servicecase sc on sc.servicecaseid = irl.servicecaseid  and sc.activeflag = 1 and sc.servicecaseid != v_servicecaseid
			WHERE  isra.personid = p.personid order by r.updatedon limit 1
		),
		(
			select coalesce(json_agg(e), '[]') as roles
			from
				(select u.fullname as username, ph.updatedby, ph.updatedon, ph."comments" 
				from personrole_history ph
				inner join userprofile u on u.securityusersid =  ph.updatedby
				where ph.personid = p.personid
				order by ph.updatedon desc
				) as e 
		) ::json as rolehistory,
		p.maritalstatustypekey as maritalstatustypekey,
		p.preadoptiondate, p.intercountryadoption, p.priorlegalguardianship, p.preplacementguardianshipdate,
		p.nationalitytypekey,
	    p.primarycitizenshiptypekey,
	    p.seccitizenshiptypekey,
		p.isbioadoptedflag,
		p.substanceexposednewbornsourceid,
		(select description_tx from tb_picklist_values tpv where tpv.picklist_value_cd = trim(p.substanceexposednewbornsourcetypekey) and picklist_type_id = 275) as substanceexposednewbornsourcetype,
		p.substanceexposednewborntimetamp
    FROM servicecase SC      
	INNER JOIN Intakeservicerequestactor IAR ON IAR.servicecaseid = SC.servicecaseid AND IAR.activeflag=1 --AND IAR.isprimary =TRUE  
	INNER JOIN actor AS AC ON AC.servicecaseid = IAR.servicecaseid AND AC.actorid = IAR.actorid AND AC.activeflag=1   
	INNER JOIN person AS P ON P.personid=AC.personid AND P.activeflag=1
	left join personphysicalattribute as ppa on
		ppa.personid = P.personid
		and ppa.physicalattributetypekey = 'Ht'
		and ppa.activeflag = 1
	left join personphysicalattribute as ppat on
		ppat.personid = P.personid
		and ppat.physicalattributetypekey = 'Wt'
		and ppat.activeflag = 1
	INNER JOIN gendertype AS G ON G.gendertypekey=P.gendertypekey                      
	WHERE  SC.servicecaseid=v_servicecaseid 
	GROUP BY  IAR.Intakeservicerequestactorid, P.biologicalmothermarriedsw, IAR.intakeservicerequestpersontypekey,
	SC.caseheadname,SC.statustypekey,SC.servicecaseid,IAR.intakeserviceid,P.personid,G.typedescription,AC.actorid,
	address,dangeraddress,address2,state,city,zipcode,county,ppa.attributevalue,ppat.attributevalue
) AS "Person"  
ORDER BY "Person".age1 DESC
LIMIT  _limit  OFFSET  _offset;

END;
$function$
;

