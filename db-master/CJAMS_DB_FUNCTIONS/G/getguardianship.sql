drop function if exists cjams.getguardianship(v_permanencyplanid uuid, v_objectid uuid, v_objecttype character varying);

CREATE OR REPLACE FUNCTION cjams.getguardianship(v_permanencyplanid uuid, v_objectid uuid, v_objecttype character varying)
 RETURNS TABLE(guardianoneproviderid integer, switchprovider boolean, switchproviderreason character varying, effectiveswitchdate timestamp without time zone, guardianoneprovidername character varying, guardiantwoproviderid integer, guardiantwoprovidername character varying, enteredby text, applicationenteredby text, gapid character varying, alternateid bigint, gapdisclosure json,auditinfo  json, gapapplication json, childname character varying, personid uuid, cjamspid character varying, dob timestamp without time zone, gender character varying, role character varying, gapsuspension json, successionaddendumdate timestamp without time zone, cofinaldate timestamp without time zone, successorguardianname character varying, empprogramstartdate timestamp without time zone, empprogramname character varying, primaryrelationshipkey character varying, secondaryrelationshipkey character varying, guardianonerelation character varying, guardiantworelation character varying, fosterhomeapprover character varying, guardiantwoid character varying, guardianoneid character varying, isrcgunderstandpurpose boolean, iscgenteredagreement boolean, isrcgacknowledgedruledoutplans boolean, isrcgapprovedhomeforsixmonths boolean, isrcgcomprehensivestudycompleted boolean, isrcgcompletedprotectiveclearance boolean, isrcgauthorizedmentalinfo boolean, isrcgshowpermanentcommitment boolean, isrcgwillstablehome boolean, isrcgprovidesupervision boolean, iscgcompletedannualreconsideration boolean, isrcghavefinancialsupport boolean, isrcgagreestoapplyssn boolean, isrcgnotifybehalfofchild boolean, isrcgnotifylocaldeptforchanges boolean, isrcgguardianshipassistancepayment boolean, isrcgunderstandgacanbeterminated boolean, isrcgandcwdiscussedrequirements boolean, documentsigned boolean, isapprovedresourceparent boolean, isapprovedkinshipplacement boolean, one_dob_dt date, two_dob_dt date, one_ssno character varying, two_ssno character varying, oneaddress character varying, twoaddress character varying, provider_category_cd character varying)
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------
-- Revision(s)
-- 06/21/2023 Manasa Kasula -- CIDM-7337 Changes to show the person updated by and updated on correctly
-- 11/23/2021 Veera Nadimpalli - Modifications for GAP Refinement story (CIDM-3159)
-- 11/30/2021 SJ - Added missed values for print GAP Refinement (CIDM-3159)
-- 03-28-2022 Veera Nadimpalli - Modifications for GAP Refinement story (CIDM-4268)
-- 11-17 - Veera 
--4/13/2023 -Umasankar raavi --CIDM-6997--Retriving more values from Documentproperties table 
--12/27/2024 - Sundeep Kiran Anugolu --CIDM-9990--sending activeflag for gapsuspension for patching values in web
------------------------------------------------------------------------    
                  
DECLARE
v_auditinfo_id uuid;


BEGIN

IF v_objecttype = 'disclosure' THEN

	SELECT ga.permanencyplanid INTO v_permanencyplanid 
	FROM gapdisclosure gd
	INNER JOIN guardianship ga ON ga.gapid = gd.gapid
	WHERE gapdisclosureid = v_objectid;
	
else IF v_objecttype = 'application' THEN

	SELECT ga.permanencyplanid INTO v_permanencyplanid 
	FROM gapapplicationl gd
	INNER JOIN guardianship ga ON ga.gapid = gd.gapid
	WHERE gapapplicationlid = v_objectid;
	
ELSIF v_objecttype = 'suspension' THEN

	SELECT ga.permanencyplanid INTO v_permanencyplanid 
	FROM gapsuspension gs
	INNER JOIN guardianship ga ON ga.gapid = gs.gapid
	WHERE gapsuspensionid = v_objectid;
	
END IF;
END IF;

select gd.gapapplicationid into v_auditinfo_id 
	FROM gapapplication gd, guardianship gap 
	WHERE gap.permanencyplanid = v_permanencyplanid
AND gap.activeflag=1 and gd.gapid=gap.gapid order by gd.updatedon desc limit 1;


RETURN query

SELECT 
	gap.guardianoneproviderid,
	gap.switchprovider,
	gap.switchproviderreason,
	gap.effectiveswitchdate,
	COALESCE(gap.guardianonename, (btrim(tbp1.first_nm) || ' ' || btrim(tbp1.last_nm)):: character varying) AS guardianoneprovidername,
	gap.guardiantwoproviderid,
	COALESCE(gap.guardiantwoname,(btrim(tbp2.first_nm) || ' ' || btrim(tbp2.last_nm)):: character varying) AS guardiantwoprovidername,	
	(SELECT up.firstname || ' ' || up.lastname from userprofile up where up.securityusersid=gc.insertedby and up.activeflag=1 limit 1) enteredby,
		(SELECT up.firstname || ' ' || up.lastname from userprofile up where up.securityusersid=gapap.insertedby and up.activeflag=1 limit 1) applicationenteredby,
	gap.gapid:: character varying, 
	gap.alternateid:: bigint,
    (SELECT json_agg((SELECT y FROM (SELECT gapdisclosureid,disclosuredate,ischildplacedsixmonths,isproviderapprovedgap,gd.iscgenteredagreement,
		iscourthearingcustody,isreunificationremoved,isadoptionremoved,iscgprovidesafe,isothergapfinsupport,iscgattendedorientation,
		orientationmeetingdate,isrequirementdiscussed,iscgparticipategap,iscgcompleteauthorization,iscgaftercareservice,
		isneedadditionalservices,iscgcompleteannualreview,issuspendedfromguardian,insertedby,r.remarks AS comments,  
        r.typedescription AS routingstatus,gd.issuccessorguardianexists,gd.isconsultationchildage,gd.dateofplanning,
		r.requestedby as approvedby, r.approvedby as requestedby , r.updatedon  as insertdate,
        gd.isguardianattach,gd.isguardiantwoattach) AS y)) AS items
		FROM gapdisclosure gd  
        INNER JOIN (SELECT objectid,(typedescription) typedescription,(remarks) remarks,up2.fullname as approvedby, up1.fullname as  requestedby , r.updatedon
						FROM routing r INNER JOIN routingstatustype rt ON rt.sequencenumber=r.routingstatustypeid AND rt.activeflag=1
						left join userprofile up1 on r.fromsecurityusersid:: character varying = up1.securityusersid
                        left join userprofile up2 on r.tosecurityusersid:: character varying  = up2.securityusersid
                        WHERE r.activeflag=1) r ON r.objectid=gapdisclosureid :: character varying
		WHERE gd.activeflag=1 and gd.gapid=gap.gapid
	) AS gapdisclosure, 
    (	SELECT json_agg(a) AS auditinfo   
			FROM (
				select ps.approvalstatus, ps.oldproviderid, ps.newproviderid,ps.approvaldate as approvedon,ps.decisiondate, u2.fullname as approvedby, u.fullname as requestedby,
                 (select f_ename('2953', ps.oldproviderid::bigint)) as oldprovidername,
				 (select f_ename('2953', ps.newproviderid::bigint)) as newprovidername
				 from providerswitchinfo ps
                 left join userprofile u2 on u2.securityusersid = ps.approvedby
                 left join userprofile u on u.securityusersid = ps.requestedby
                 where ps.objectid = v_auditinfo_id
				order by ps.insertedby desc
				) a  
	),	
	(SELECT json_agg((SELECT y FROM (select gd.gapapplicationid, gd.gapid, gd.planmeetingdate, gd.guardianonedate, gd.guardiantwodate, gd.ldssdirectordate, r.remarks AS comments, gd.guardian1signature,gd.guardian2signature,gd.ldssdirectorsignature, 
        r.typedescription AS routingstatus,
		( SELECT                                                                                                                                                                                                                                                                                                                                        
                json_agg(doc)                                                                                                                                                                                                                                                                                                          
     			FROM                                                                                                                                                                                                                                                                                                                                          
 				(                                                                                                                                                                                                                                                                                                                                             
 				SELECT  dp.filename, dp.documentpropertiesid,  dp.title,  dp.mime,  dp.numberofbytes, dp.s3bucketpathname,  dp.originalfilename,
				dp.documentdate, 
				dp.actualdocumentdate, 
				dp.title,
				dp.other,
				(select up.fullname as insertedby from userprofile up where up.securityusersid = dp.insertedby),
				dp.updatedon,
				(select attachmentclassificationtypekey from documentattachment where documentpropertiesid = dp.documentpropertiesid),
				(select attachmentclassificationsubtypekey from documentattachment where documentpropertiesid = dp.documentpropertiesid),
				(select attachmenttypekey from documentattachment where documentpropertiesid = dp.documentpropertiesid),
				dp.uploadstatus, 
				dp.finalstatus,
				dp.ecmsdocumentid
       			from documentproperties dp where dp.objectid =  gd.gapapplicationid  and dp.activeflag in (1,3,4,5)                                                                                                                                                                                                                                         
                                         ) doc  ) :: json AS attachments,
		r.requestedby as approvedby, r.approvedby as requestedby , r.updatedon  as insertdate
		) AS y)) AS items
		FROM gapapplication gd  
        INNER JOIN (SELECT objectid,(typedescription) typedescription,(remarks) remarks,up2.fullname as approvedby, up1.fullname as  requestedby , r.updatedon
						FROM routing r
						INNER JOIN routingstatustype rt ON rt.sequencenumber=r.routingstatustypeid AND rt.activeflag=1
						left join userprofile up1 on r.fromsecurityusersid:: character varying = up1.securityusersid
                        left join userprofile up2 on r.tosecurityusersid:: character varying  = up2.securityusersid
                        WHERE r.activeflag=1) r ON r.objectid=gapapplicationid :: character varying
		WHERE gd.activeflag=1 and gd.gapid=gap.gapid) as gapapplication,
	
	
    (ps.firstname || ' '||ps.lastname):: character varying childname,	
    ps.personid,
	ps.cjamspid:: character varying,
    ps.dob,(SELECT typedescription FROM gendertype WHERE gendertypekey = ps.gendertypekey limit 1) gender,  
	isra.intakeservicerequestpersontypekey AS role, 
    (SELECT json_agg((SELECT z FROM (SELECT gs.gapsuspensionid,gs.suspensionreasontypekey,--gs.startdate,
case when
                 (select gsv.startdate from 
                 gapsuspensionrevision gsv where gsv.suspensionid=gs.gapsuspensionid 
                  and gsv.approvalstatustypekey='3045' and gsv.activeflag=1 
                order by gsv.insertedon desc limit 1
                 )is not null   then (select gsv.startdate from 
                 gapsuspensionrevision gsv where gsv.suspensionid=gs.gapsuspensionid  
                 and gsv.approvalstatustypekey='3045' and gsv.activeflag=1
                 ) else gs.startdate end as startdate  ,
		
		case when
                 (select gsv.enddate from 
                 gapsuspensionrevision gsv where gsv.suspensionid=gs.gapsuspensionid 
                  and gsv.approvalstatustypekey='3045' and gsv.activeflag=1 
                order by gsv.insertedon desc limit 1
                 )is not null   then (select gsv.enddate from 
                 gapsuspensionrevision gsv where gsv.suspensionid=gs.gapsuspensionid  
                 and gsv.approvalstatustypekey='3045' and gsv.activeflag=1
                 ) else gs.enddate end as enddate  ,
	gs.notes,gs.isdraft,gs.suspensiondesc,
        r.remarks AS comments,srt.typedescription,r.typedescription AS routingstatus, r.objectid as objectid,gs.otherreason, gs.activeflag) AS z order by z.startdate desc)) AS items FROM gapsuspension gs
		INNER JOIN (SELECT objectid,(typedescription) typedescription,(remarks) remarks
					FROM routing r INNER JOIN routingstatustype rt ON rt.sequencenumber=r.routingstatustypeid AND rt.activeflag=1
                    WHERE r.activeflag=1 
					) r ON r.objectid=gs.gapsuspensionid :: character varying
		INNER JOIN suspensionreasontype srt ON srt.suspensionreasontypekey = gs.suspensionreasontypekey AND srt.activeflag =1
        WHERE gs.activeflag=1 and gs.gapid=gap.gapid --order by gs.insertedon desc limit 1 
	) AS gapsuspension,
	gap.successionaddendumdate,
	gap.cofinaldate,
	gap.successorguardianname,
	gap.empprogramstartdate,
	gap.empprogramname,
	gap.primaryrelationshipkey,
	gap.secondaryrelationshipkey,
	(case when gap.primaryrelationshipkey is not null then (select rt.description from relationshiptype rt where rt.relationshiptypekey = gap.primaryrelationshipkey) else null end):: character varying as guardianonerelation,
	(case when gap.secondaryrelationshipkey is not null then (select rt.description from relationshiptype rt where rt.relationshiptypekey = gap.secondaryrelationshipkey) else null end):: character varying as guardiantworelation,
	gap.fosterhomeapprover,
	gap.guardiantwoid,
	gap.guardianoneid,
    gap.isrcgunderstandpurpose,
	gap.iscgenteredagreement,
    gap.isrcgacknowledgedruledoutplans,
    gap.isrcgapprovedhomeforsixmonths,
    gap.isrcgcomprehensivestudycompleted,
    gap.isrcgcompletedprotectiveclearance,
    gap.isrcgauthorizedmentalinfo,
    gap.isrcgshowpermanentcommitment,
    gap.isrcgwillstablehome,
    gap.isrcgprovidesupervision,
    gap.iscgcompletedannualreconsideration,
    gap.isrcghavefinancialsupport,
    gap.isrcgagreestoapplyssn,
    gap.isrcgnotifybehalfofchild,
    gap.isrcgnotifylocaldeptforchanges,
    gap.isrcgguardianshipassistancepayment,
    gap.isrcgunderstandgacanbeterminated,
    gap.isrcgandcwdiscussedrequirements,
	gap.documentsigned,
	gap.isapprovedresourceparent,
	gap.isapprovedkinshipplacement,
	tbp1.dob_dt,
	tbp2.dob_dt,
	--tbp1.tax_id_no ::character varying,
	--tbp2.tax_id_no ::character varying,
	(regexp_replace(tbp1.ssn_no::text, '(\d{3})(\d{2})(\d{4})', '***-**-\3', 'g'))::character varying, 
	(regexp_replace(tbp2.ssn_no::text, '(\d{3})(\d{2})(\d{4})', '***-**-\3', 'g'))::character varying, 
	(select provider_adr from get_provider_address(gap.guardianoneproviderid,trim('{3357}') :: character varying)) as oneaddress,
	(select provider_adr from get_provider_address(gap.guardiantwoproviderid,trim('{3357}') :: character varying)) as twoaddress,
	(select f_prvpcklst_cat(gap.guardianoneproviderid::bigint,'PLACEMENT')) as provider_category_cd
FROM guardianship gap  
inner join permanencyplan pp on pp.permanencyplanid = gap.permanencyplanid 
left  JOIN gapdisclosure gc ON gc.gapid=gap.gapid AND gc.activeflag=1
 JOIN gapapplication gapap ON gapap.gapid=gap.gapid AND gapap.activeflag=1
LEFT JOIN intakeservicerequestactor isra ON  isra.intakeservicerequestactorid=pp.intakeservicerequestactorid  AND isra.activeflag=1 
LEFT JOIN person ps ON isra.personid=ps.personid AND ps.activeflag=1
--LEFT JOIN tb_provider tbp1 ON tbp1.provider_id=gap.guardianoneproviderid
--LEFT JOIN tb_provider tbp2 ON tbp2.provider_id=gap.guardiantwoproviderid
LEFT JOIN tb_prov_approval_person tbp1 ON tbp1.approval_person_id::character varying =gap.guardianoneid
LEFT JOIN tb_prov_approval_person tbp2 ON tbp2.approval_person_id::character varying =gap.guardiantwoid
WHERE gap.permanencyplanid = v_permanencyplanid
AND gap.activeflag=1 order by gap.insertedon desc  LIMIT 1;

END;


$function$
;