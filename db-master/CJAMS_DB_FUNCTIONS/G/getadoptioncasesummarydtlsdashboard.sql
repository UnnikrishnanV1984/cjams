DROP FUNCTION IF EXISTS getadoptioncasesummarydtlsdashboard(v_adoptioncaseid uuid, loginsecurityuserid character varying);
CREATE OR REPLACE FUNCTION cjams.getadoptioncasesummarydtlsdashboard(v_adoptioncaseid uuid, loginsecurityuserid character varying)
 RETURNS TABLE(da_number character varying, intakeserviceid uuid, da_typeid uuid, da_subtypeid uuid, da_type character varying, da_subtype character varying, da_receiveddate timestamp without time zone, da_focus character varying, da_role character varying, da_identifier character varying, da_county character varying, da_zip character varying, da_status character varying, da_disposition character varying, da_assignedto character varying, da_duedate timestamp without time zone, da_daystogo bigint, da_loadnumber character varying, da_focusprofilephoto text, persondob timestamp without time zone, assistpid character varying, cjamspid bigint, persondod timestamp without time zone, personid uuid, programarea json, case_opendate timestamp without time zone, case_closedate timestamp without time zone, responsibleworkers json, adoptioncasenumber character varying, teamid uuid, servicecaseid uuid, narrativeupdateddate timestamp without time zone, da_assignedby character varying, service_old_id character varying, adoptionproviderid bigint, onlyadoptivehomeprovider boolean)
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------------------------------------------
-- Revision(s)
-- 02/27/2022 Vineet Tirodkar - Modifications to get all active workers/logged in user and thier Supervisors  (CIDM-4296)
-- 08/16/2023 - Manasa Kasula - To return the adoptive provider id and onlyadoptivehomeprovider flag (CIDM-7695) 
------------------------------------------------------------------------------------------------------------
DECLARE	
v_servicecaseid uuid;
v_intakeserviceid uuid;
v_IntakeServReqTypeId uuid;
v_disposition  character varying;
daStatusTypeId character varying;
v_duedateoffset int;
v_personid uuid;
v_adoptioncasenumber character varying;
l_assigncount bigint;
v_adoptionproviderid bigint;
v_onlyadoptivehomeprovider boolean;
	
BEGIN
		
	select ac.servicecaseid,ac.adoptioncasenumber into v_servicecaseid,v_adoptioncasenumber from adoptioncase ac where ac.adoptioncaseid   = v_adoptioncaseid;
	
	select isr.intakeserviceid,isr.narrativeUpdatedDate into v_intakeserviceid,narrativeUpdatedDate 
	from intakeservicerequest isr where isr.servicecaseid   =  v_servicecaseid;
		
	select ac.old_id into service_old_id from adoptioncase ac where ac.adoptioncaseid   =  v_adoptioncaseid;

	select provider_id into v_adoptionproviderid from adoptioncaseagreement a  
	inner join adoptioncaseagreementrate agr on agr.adoptionagreementid = a.adoptionagreementid and agr.activeflag = 1
	where a.adoptioncaseid  = v_adoptioncaseid and a.activeflag = 1 order by agr.startdate desc limit 1;

	select (case when count(*) > 0 then false else true end) into v_onlyadoptivehomeprovider
	from prov.tb_provider_services ps, prov.tb_services sc
	where ps.service_id = sc.service_id and ps.provider_id = v_adoptionproviderid
	and ps.delete_sw = 'N' and sc.delete_sw = 'N' and sc.structure_service_cd = 'P'
	and sc.service_id <> 501 -- Adoptive Home
	and (ps.end_dt is null or ps.end_dt > current_date);	
		
	SELECT tm.loadnumber,tm.teamid 
    	INTO da_loadnumber, teamid
	FROM userprofile u 
        INNER JOIN  teammemberassignment tma 	ON tma.SecurityUsersId =  u.SecurityUsersId AND tma.activeflag =1
        INNER JOIN teammember tm ON tm.teammemberid = tma.teammemberid AND tm.activeflag =1
	WHERE u.activeflag =1   AND u.SecurityUsersId = loginsecurityuserid;
 
	SELECT 	ac.adoptioncasenumber, ac.startdate, ac.startdate, 
			ac.enddate, ac.statustypekey
	INTO 	DA_Number, DA_ReceivedDate, case_opendate,
			case_closedate,	daStatusTypeId
	FROM 	adoptioncase ac 
    	WHERE  ac.adoptioncaseid  =  v_adoptioncaseid LIMIT 1 ;  

 	SELECT intakeservreqtypeid into da_typeid from intakeservicerequesttype where intakeservreqtypekey='adoptioncase' and activeflag=1  limit 1;
	
	da_subtypeid:= '00000000-0000-0000-0000-000000000000';
	DA_Type := 'Adoption Case'; 
	da_subtype := '';

	/*Status and disposition taken from disposition table*/
	SELECT 	scd.dispositioncode,scd.intakeserreqstatustypekey 
	INTO 	v_disposition, DA_Status  
	FROM 	servicecasedisposition scd 
	WHERE 	scd.servicecaseid = v_servicecaseid 
	ORDER BY scd.statusdate DESC LIMIT 1; 
	
	SELECT Description INTO DA_Disposition 
	FROM  dispositioncode 
	WHERE dispositioncode =v_disposition AND activeflag =1 LIMIT 1;
	
	 DA_Status:= COALESCE(daStatusTypeId, 'Open');

	SELECT 	typedescription
    INTO 	DA_Role 
    FROM 	ActorType WHERE actortype IN (SELECT FocusRoletype FROM ServiceRequestTypeConfig 
                                         WHERE IntakeServReqTypeId = v_IntakeServReqTypeId AND ServiceRequestSubTypeId = da_subtypeid AND ActiveFlag =1);

	SELECT INITCAP(TRIM(P.firstname)||' '||TRIM(P.lastname) ||
			CASE WHEN P.middlename IS NOT NULL AND TRIM(P.middlename) != '' THEN ', ' || TRIM(P.middlename) ELSE '' END),
            P.userphoto,P.dob,P.old_id as assistpid,P.cjamspid ,p.dateofdeath,p.personid
    INTO DA_Focus,da_focusProfilePhoto,
    	  persondob,assistpid,cjamspid ,persondod,v_personid
    FROM person as P WHERE p.personid in (
	SELECT isra2.personid  FROM adoptioncaseactor isra2 
	WHERE isra2.adoptioncaseid = v_adoptioncaseid AND actortypekey in ('CHILD', 'PVTADPCHILD') limit 1);

	SELECT coalesce(pif.personidentifiervalue,null) into DA_Identifier  FROM PersonIdentifier pif WHERE pif.personid IN (
	SELECT ac.PersonId FROM actor ac WHERE ac.ActorId IN (
	SELECT isra1.Actorid  FROM IntakeServiceRequestActor isra1 WHERE isra1.servicecaseid = v_servicecaseid 
	AND isra1.intakeservicerequestpersontypekey IN ('RA','RC', 'Youth') LIMIT 1)) AND pif.personidentifiertypekey = 'DCN';

	SELECT  zipcode,county INTO DA_Zip,DA_County FROM PersonAddress WHERE PersonAddressId in  (
	SELECT isra.RoutingAddressId  FROM IntakeServiceRequestActor isra WHERE isra.servicecaseid = v_servicecaseid AND 
	isra.RoutingAddressId IS NOT NULL);

	SELECT CAST(UP2.firstname || ' ' || UP2.lastname AS character varying) into da_assignedto
				FROM  userprofile UP2  
				inner join caseassignment ca on ca.toworkeridno = up2.securityusersid AND ca.activeflag = 1 
				WHERE UP2.activeflag =1 
				and ca.objectid = v_adoptioncaseid
				and ca.objecttypekey = 'adoptioncase' and ca.enddate is null order by ca.insertedon desc LIMIT 1;
			
	--## SHOW UNIT SUPERVISOR ON BLUE RIBBON WHEN EVER OPEN A CASE
		SELECT u2.firstname||COALESCE(' '||u2.middlename,'')||' '||u2.lastname into  da_assignedby
		FROM userprofile u1 
			 INNER JOIN userprofile u2 ON u2.securityusersid = u1.supervisorid
		WHERE u1.securityusersid = loginsecurityuserid;
    
	SELECT duedateoffset into v_duedateoffset FROM servicerequesttypeconfig WHERE intakeservreqtypeid  = v_IntakeServReqTypeId AND servicerequestsubtypeid = da_subtypeid AND activeflag =1 AND category= 'Intake' LIMIT 1;

	da_duedate:= DA_ReceivedDate::date +v_duedateoffset;
 
	da_daystogo:= EXTRACT(day FROM (da_duedate  - now()));

	IF da_daystogo < 0 THEN
		da_daystogo = 0;
	END IF;
    
	
	SELECT json_agg(e) AS programarea INTO programarea
				FROM
	            (
					SELECT
						DISTINCT ppa.programkey,
						(SELECT ap.programname FROM agencyprogramarea ap 
						WHERE ap.programkey = ppa.programkey AND ap.activeflag =1 LIMIT 1) programname
					FROM personprogramarea ppa 
					WHERE ppa.personid = v_personid AND ppa.objectid=v_adoptioncaseid::character varying AND ppa.sourcetype = 'CW' AND ppa.activeflag=1
				) AS e;
			
	
		  SELECT   json_agg(worker) INTO responsibleworkers
		  FROM   (
		      SELECT
		        ca.responsibilitytypekey,
				ca.startdate::date,
				ca.enddate::date,
		        up.firstname,
		        up.lastname,
		        up.email,
		        (
		          SELECT
		            json_agg(e) as address
		          FROM
		            (
		              SELECT
		                upa.address,
		                upa.city,
		                upa.county,
		                upa.state,
		                upa.country,
		                upa.zipcode
		              FROM
		                userprofileaddress upa
		              where
		                upa.securityusersid = up.securityusersid
		            ) e
		        ),
		        (SELECT upp.phonenumber from userprofilephonenumber upp where upp.securityusersid = up.securityusersid and upp.activeflag =1 limit 1)
				, up.supervisorid
				,(select UP1.firstname || ' ' || UP1.lastname
					from userprofile UP1
				  where up1.securityusersid = up.supervisorid	
				) as supervisorname
		      	FROM caseassignment ca
		        	INNER JOIN userprofile up on up.securityusersid = ca.toworkeridno  
						AND up.activeflag = 1
		      	WHERE ca.objectid = v_adoptioncaseid 
					and ca.enddate is null 
		    	ORDER BY COALESCE(CA.enddate:: date,now() + interval '1' day ) DESC
			) worker;
RETURN QUERY 
SELECT DA_Number,v_intakeserviceid,da_typeid,da_subtypeid,DA_Type,da_subtype,DA_ReceivedDate,DA_Focus,DA_Role,DA_Identifier,
DA_County,DA_Zip,DA_Status,DA_Disposition,da_assignedto,da_duedate,da_daystogo,da_loadnumber,da_focusProfilePhoto,persondob,assistpid,
cjamspid,persondod,v_personid,programarea,case_opendate,case_closedate,responsibleworkers,v_adoptioncasenumber,teamid,
v_servicecaseid,narrativeUpdatedDate,da_assignedby,service_old_id, v_adoptionproviderid, v_onlyadoptivehomeprovider;

END;

$function$
;
