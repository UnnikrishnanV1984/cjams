DROP FUNCTION if exists  cjams.getUploadFailedAttachments(v_userid character varying, v_ecmsdocumentid character varying );
CREATE OR REPLACE FUNCTION cjams.getUploadFailedAttachments(v_userid character varying, v_ecmsdocumentid character varying)
 RETURNS json
 LANGUAGE plpgsql
AS $function$
-------------------------------------------------------------------------------------------
--Revision(s)
--05/23/2025 - Manasa Kasula- CIDM-10472: EDMS file upload implementation.
---------------------------------------------------------------------------------------------------------------
DECLARE
	jsondata json;

BEGIN
	
SELECT JSON_AGG(pla) INTO jsondata FROM (

SELECT COUNT(1) over(),
dp.documentpropertiesid, 
dp.numberofbytes,  
dp.originalfilename,  
dp.servicecaseid,
dp.ecmsdocumentid,
dp.uploadstatus,
dp.finalstatus,
dp.objectid,
dp.objecttypekey,
COALESCE(sc.servicecasenumber,isr.servicerequestnumber,ac.adoptioncasenumber,dp.intakenumber) as casenumber,
COALESCE(sc.servicecaseid,isr.intakeserviceid,ac.adoptioncaseid) as caseid,
(case when sc.servicecasenumber is not null then 'servicecase' when isr.servicerequestnumber is not null then 'cps' 
when ac.adoptioncasenumber is not null then 'adoptioncase' when dp.intakenumber is not null then 'intake' end) as casetype,
p.cjamspid,
concat(p.firstname, ' ', p.lastname) as personname,
dp.additionalobjectid,
dp.additionalobjecttype,
dp.filesize,
tspa.service_log_id,
tsl.client_id,
coalesce(g.permanencyplanid,aplan.permanencyplanid) as permanencyplanid, 
isrco.intakeservicerequesthearingid
FROM documentproperties dp 
left join servicecase sc on sc.servicecaseid = dp.servicecaseid and sc.activeflag = 1
left join intakeservicerequest isr on isr.intakeserviceid = dp.servicerequestid and isr.activeflag = 1
left join adoptioncase ac on (ac.adoptioncaseid = dp.objectid or ac.adoptioncaseid = dp.servicecaseid) and ac.activeflag = 1 and dp.objecttypekey in ('Adoptioncase', 'AdoptionSubsidy')
left join person p on p.personid = dp.objectid and p.activeflag = 1
left join tb_service_purchase_authorization tspa on dp.objecttypekey = 'purchaseAuthReceipt' and dp.additionalobjectid = tspa.authorization_id::varchar and delete_sw = 'N'
left join tb_service_log tsl on tsl.service_log_id = tspa.service_log_id and tsl.delete_sw = 'N'
left join gapagreement gagg on dp.objecttypekey = 'gapagreement' and gagg.gapagreementid = dp.objectid and gagg.activeflag = 1
left join gapapplication ga on  dp.objecttypekey = 'gapapplication' and ga.gapapplicationid = dp.objectid and ga.activeflag = 1
left join guardianship g on (g.gapid = ga.gapid or g.gapid = gagg.gapid) and g.activeflag = 1
left join intakeservreqcourtorder isrco on dp.objecttypekey = 'courtorder' and isrco.intakeservreqcourtorderid = dp.objectid and isrco.activeflag = 1
left join adoptionagreement aagre on dp.objecttypekey = 'AdoptionSubsidy' and sc.servicecaseid is not null and aagre.adoptionagreementid = dp.objectid and aagre.activeflag = 1
left join adoptionplanning aplan on aplan.adoptionplanningid = aagre.adoptionplanningid and aplan.activeflag = 1
WHERE dp.insertedby = v_userid and Coalesce(dp.finalstatus,'FAILED') = 'FAILED' and COALESCE(dp.usernotified, false) = false and 
case when v_ecmsdocumentid is not null then dp.ecmsdocumentid = v_ecmsdocumentid else  dp.activeflag in (4,5) end 
ORDER BY dp.insertedon desc) AS pla;

update documentproperties 
set updatedby = v_userid, usernotified = true, updatedon = now()
where activeflag in (4,5) and insertedby = v_userid and Coalesce(finalstatus,'FAILED') = 'FAILED' and 
case when v_ecmsdocumentid is not null then ecmsdocumentid = v_ecmsdocumentid else true end 
;

RETURN jsondata ;

END;

$function$
;
