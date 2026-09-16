DROP FUNCTION IF EXISTS cjams.getexaminationlist(person_id uuid, v_lipagenumber bigint, v_lipagesize bigint);
CREATE OR REPLACE FUNCTION cjams.getexaminationlist(person_id uuid, v_lipagenumber bigint, v_lipagesize bigint)
 RETURNS TABLE(totalcount bigint, providerinfoflag integer, personexaminationid uuid, parentexaminationid uuid, uploadpath json, appointment json, physician json, covidimpacted boolean, exposedtocovid character varying, covidtestconducted character varying, typeoftest character varying, covidtestresults character varying, covidtestdate date)
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------------------------------------------
-- Revision(s) 
--12/09/2022 - Adding fields for CIDM-6157
-- 02/26/2022 Chandra Ramasamy -- Adding two new fileds for lap test & Speciality other reason(B-124086)
-- 03/31/2023 Vijaya Laxmi Devunoori - CIDM-6926 : Added two new fields in select result: 
--	personexamination.isannualhealthvisit and personexamination.issemiannualdentalvisit
------------------------------------------------------------------------------------------------------------	
DECLARE  
v_pagenumber int;
v_pageoffset int;
	
BEGIN 
v_pagenumber := v_liPageNumber - 1;
v_pageoffset := v_pagenumber * v_liPageSize;

return query		
	select count(1) over() as totalcount, x.* from (	
		select  pe.providerinfoflag
			, pe.personexaminationid
			, pe.parentexaminationid
			, (SELECT json_agg(docs) FROM  (
				SELECT documentpropertiesid, objecttypekey, title, actualdocumentdate, documenttypekey, insertedon, updatedon,
				(select up.fullname as insertedby from userprofile up where up.securityusersid = dp.insertedby),
				updatedby, documentdate, mime, s3bucketpathname, description, other,filename, numberofbytes, originalfilename,
				(SELECT row_to_json(x) AS documentattachment FROM(                                                                               
				SELECT documentpropertiesid, attachmenttypekey, attachmentclassificationtypekey,attachmentclassificationsubtypekey, assessmenttemplateid,
				(select up.fullname as updatedby from userprofile up where up.securityusersid = dat.updatedby) from documentattachment dat                                                                                   
				WHERE dat.documentpropertiesid = dp.documentpropertiesid                                                  
				) x),dp.uploadstatus, dp.finalstatus,dp.ecmsdocumentid
			from documentproperties dp where dp.additionalobjectid = pe.personexaminationid::varchar and dp.additionalobjecttype = 'personexamination' and dp.activeflag in (1,3,4,5)
			)docs) as uploadpath
			, (SELECT json_agg(cont) FROM  (
				SELECT pe.appoinmentdate as "apptDate"
					, pe.nextappointmentdate as "nextApptDate"
					, pe.examinationtypekey as "natureofexamkey"
					, pe.isannualhealthvisit as "isannualhealthvisit"
					, pe.issemiannualdentalvisit as "issemiannualdentalvisit"
					, (select value_tx from tb_picklist_values where trim(picklist_value_cd)=trim(pe.examinationtypekey) and picklist_type_id=320 limit 1) as "natureofexamdesc"
					, (pe.labtesttypekey)::jsonb as "labtestkey"
					, pe.specialityexamtypekey as "specialityexamkey"
					, (select value_tx from tb_picklist_values where trim(picklist_value_cd)=trim(pe.specialityexamtypekey) and picklist_type_id=318 limit 1) as "specialitydesc"
					, pe.nextappointmentreason
					, pe.authformcompletion
					, pe.notcompletedauthform
					, pe.provcaremissed
					, pe.otherreason
					, pe.hivconsentflag as "hivtestreceived"
					, pe.notkeptreason
					, pe.appointkeptflag as "apptkept"
					, pe.starttime
					, pe.endtime  
					, pe.timeframe as "timeframe"
					, (select value_tx from tb_picklist_values where trim(picklist_value_cd)=trim(pe.timeframe) and picklist_type_id=10047 limit 1) as "timeframedesc"
					,pe.labtestother
					,pe.specialityexamother
			)cont) as appointment
			, json_build_object(
				'speciality', pe.physicianspeciality
				, 'affilication', pe.affiliateorg
				, 'physicianname', pe.physicianname
				, 'recommendations', pe.recommendations
				, 'comments', pe.comments
				, 'address1', pe.address1
				, 'address2',pe.address2
				, 'city', pe.cityname
				, 'state', pe.statetypekey
				, 'county', pe.countytypekey
				, 'zip', lpad((pe.zip5no::varchar), 5, '0')
				, 'phone' , pe.workphone
				, 'email' , pe.email
				, 'followupneeded' ,pe.followupneeded
				, 'medicalreferrals' ,pe.medicalreferrals
				, 'physicianfaxnumber', pe.physicianfaxnumber
			) as physician
			, pe.covidimpacted
			, pe.exposedtocovid
			, pe.covidtestconducted
			, pe.typeoftest
			, pe.covidtestresults
			, pe.covidtestdate 
		from personexamination pe
		where pe.activeflag=1 and pe.personid= person_id
		order by pe.appoinmentdate desc
	) as x
	LIMIT v_liPageSize OFFSET v_pageoffset; 
END;

$function$
;