drop function if exists gethospitalizationlist(uuid,bigint,bigint);
CREATE OR REPLACE FUNCTION cjams.gethospitalizationlist(person_id uuid, v_lipagenumber bigint, v_lipagesize bigint)
 RETURNS TABLE(totalcount bigint, hospitalizationid uuid, hospitalization_type character varying,hospitalization_typedesc character varying, hospitalization_reason character varying,
  hospitalization_discharge_recommendation_others character varying, actual_placement_after_discharge_others character varying, 
   hospitalization_reasondesc character varying, "Reason_or_diagnosis" character varying, "Hospital_name" character varying, "Hospital_phone" character varying, "start_Date" date, "end_Date" date, starttime character varying, endtime character varying, has_discharge_plan integer, discharge_plan character varying, "Hospital_address1" character varying, "Hospital_address2" character varying, "Hospital_city" character varying, "Hospital_state" character varying, "Hospital_zipcode" character varying, county character varying, uploadpath json, livingid uuid, placementid uuid,
 "Hospital_ERexamination" boolean, "Hospital_ERevaluation" boolean, "Hospital_InpatientAdmission" boolean, "Hospital_Overstay" boolean, "Hospital_Transfer" boolean, "Hospital_Discharged" boolean, "Hospital_examStartDate" TIMESTAMP WITHOUT TIME ZONE, "Hospital_evaluatSartDate" TIMESTAMP WITHOUT TIME ZONE,
 "Hospital_OverstayDate" TIMESTAMP WITHOUT TIME ZONE, "Hospital_TransferDate" TIMESTAMP WITHOUT TIME ZONE, "Hospital_InpatientAdmissionDate" TIMESTAMP WITHOUT TIME ZONE, "Hospital_DischargedDate" TIMESTAMP WITHOUT TIME ZONE, "Hospital_DischargePlan" text, "ReasoForFenialByProvider" text, "Hospital_DischargeDiagnoses" text, "Hospital_TransferredName" character varying,
 "Hospital_Unit" character varying, "Hospital_RoomNumber" character varying, "Hospital_PhoneNumber" character varying, "hospital_addressline1" character varying, "hospital_addressline2" character varying, "hospital_cityname"  character varying,"hospital_statename" character varying,"hospital_zipcode1" character varying,"hospital_country"character varying, "Hospital_DischargeRecommendation" character varying, "Actual_Placement_After_Discharge" character varying, "Hospital_ReasonForOvrStay" character varying, "Hospital_DenialsByProviders" character varying, "Hospital_LengthOfOverstay" character varying, "Hospital_GroupHome" character varying, "hospitalization_reasonForHospitalization_others" character varying, durationdays character varying, medicalnecessitydays character varying, hospital_room character varying, hospital_roomphoneno character varying, activeflag integer
 )
 LANGUAGE plpgsql
AS $function$
-- 06/21/2023 Manasa Kasula -- CDM-29425 Changes related to person health document delete 
-- CIDM-7337 Changes to show the person updated by and updated on correctly
-- 08/23/2024-Umasankar Raavi --CIDM-9160- Added new columns to the function (hospitalization_discharge_recommendation_others, actual_placement_after_discharge_others,Actual_Placement_After_Discharge )
-- 10/01 - Veera Nadimpalli CIDM-9160 User story changes
DECLARE  


v_pagenumber int;

v_pageoffset int;

	
	
BEGIN 





v_pagenumber := v_liPageNumber - 1;
v_pageoffset := v_pagenumber * v_liPageSize;

	return query		
select count(1) over() as totalcount,ph.hospitalizationid, ph.hospitalization_type,(select value_tx from tb_picklist_values where trim(picklist_value_cd)=trim(ph.hospitalization_type) and picklist_type_id=230 limit 1) as hospitalization_typedesc,
ph.hospitalization_reason,ph.hospitalization_discharge_recommendation_others, ph.actual_placement_after_discharge_others, (select value_tx from tb_picklist_values where trim(picklist_value_cd)=trim(ph.hospitalization_reason) and picklist_type_id in(310,280) limit 1) as hospitalization_reasondesc,diagnosistx as "Reason_or_diagnosis",
ph.hospitalnm as "Hospital_name",ph.hospital_phone,ph.startdt as "start_Date",
ph.enddt as "end_Date",ph.starttime, ph.endtime, ph.hasdischargeplan as "has_discharge_plan",ph.dischargeplan as "discharge_plan",
ph.hospital_address1 as "Hospital_address1",ph.hospital_address2 as "Hospital_address2",
ph.hospital_city as "Hospital_city",ph.hospital_state as "Hospital_state",ph.hospital_zipcode as "Hospital_zipcode" ,ph.county,
(SELECT json_agg(docs) FROM  (
	SELECT dp.documentpropertiesid, dp.objecttypekey, dp.title, dp.actualdocumentdate, dp.documenttypekey, dp.insertedon, dp.updatedon, 
	(select up.fullname as insertedby from userprofile up where up.securityusersid = dp.insertedby),
	dp.updatedby, dp.documentdate, dp.mime, dp.s3bucketpathname, dp.description, dp.other,dp.filename,dp.numberofbytes, dp.originalfilename,
	(SELECT row_to_json(x) AS documentattachment FROM(                                                                               
	SELECT dat.documentpropertiesid, dat.attachmenttypekey, dat.attachmentclassificationtypekey, dat.attachmentclassificationsubtypekey, dat.assessmenttemplateid,
	(select up.fullname as updatedby from userprofile up where up.securityusersid = dat.updatedby) from documentattachment dat                                                                                   
	WHERE dat.documentpropertiesid = dp.documentpropertiesid                                                  
	) x)
from documentproperties dp where dp.additionalobjectid = ph.hospitalizationid::varchar and dp.additionalobjecttype = 'personhospitalization' and dp.activeflag = 1
)docs) as uploadpath, 
(select l.livingid from livingarrangement l where l.objectid = ph.hospitalizationid::character varying limit 1) as "livingid",
(select pr.placementid from placementrevision pr where pr.objectid = ph.hospitalizationid::character varying and pr.activeflag = 1 limit 1) as "placementid",
ph.hospital_erexamination as "Hospital_ERexamination",
ph.hospital_erevaluation as "Hospital_ERevaluation",
ph.hospital_inpatientAdmission as "Hospital_InpatientAdmission",
ph.hospital_overstay as "Hospital_Overstay",
ph.hospital_transfer as "Hospital_Transfer",
ph.hospital_discharged as "Hospital_Discharged",
ph.hospital_examstartdate::timestamp without time zone as "Hospital_examStartDate",
ph.hospital_evaluatstartdate::timestamp without time zone as "Hospital_evaluatSartDate",
ph.hospital_overstaydate::timestamp without time zone as "Hospital_OverstayDate",
ph.hospital_transferdate::timestamp without time zone as "Hospital_TransferDate",
ph.hospital_inpatientadmissiondate::timestamp without time zone as "Hospital_InpatientAdmissionDate",
ph.hospital_dischargeddate::timestamp without time zone as "Hospital_DischargedDate",
ph.hospital_dischargeplan as "Hospital_DischargePlan",
ph.reasoforfenialbyprovider as "ReasoForFenialByProvider",
ph.hospital_dischargediagnoses as "Hospital_DischargeDiagnoses",
ph.hospital_transferredname as "Hospital_TransferredName",
ph.hospital_unit as "Hospital_Unit",
ph.hospital_roomnumber as "Hospital_RoomNumber",
ph.hospital_phonenumber as "Hospital_PhoneNumber",
ph.hospital_addressline1 as "hospital_addressline1",
ph.hospital_addressline2 as "hospital_addressline2",
ph. hospital_cityname as "hospital_cityname",
ph.hospital_statename as "hospital_statename",
ph.hospital_zipcode1 as "hospital_zipcode1",
ph.hospital_country as "hospital_country",
ph.hospital_dischargerecommendation as "Hospital_DischargeRecommendation",
ph.Actual_Placement_After_Discharge as "Actual_Placement_After_Discharge",
ph.hospital_reasonforovrstay as "Hospital_ReasonForOvrStay",
ph.hospital_denialsbyproviders as "Hospital_DenialsByProviders",
ph.hospital_lengthofoverstay as "Hospital_LengthOfOverstay",
ph.hospital_grouphome as "Hospital_GroupHome",
ph.hospitalization_reasonForHospitalization_others as "hospitalization_reasonForHospitalization_others",
ph.durationdays as "durationdays",
ph.medicalnecessitydays as "medicalnecessitydays",
ph.hospital_room as "hospital_room",
ph.hospital_roomphoneno as "hospital_roomphoneno",
ph.activeflag

from personhospitalization ph
where ph.activeflag in (1 , 2) and ph.personid=person_id order by ph.hospital_examstartdate , ph.hospital_inpatientadmissiondate desc
 LIMIT v_liPageSize OFFSET v_pageoffset; 
END;

$function$