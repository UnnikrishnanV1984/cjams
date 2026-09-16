DROP FUNCTION IF EXISTS  cjams.getbehavioursubstance_filter(json,bigint,bigint); --clean up _ ones in all envs
DROP FUNCTION IF EXISTS  cjams.getbehavioursubstancefilter(json,bigint,bigint);
CREATE OR REPLACE FUNCTION cjams.getbehavioursubstancefilter(filters json, v_lipagenumber bigint, v_lipagesize bigint)
 RETURNS TABLE(totalcount bigint, personbehavioralhealthid uuid, typeofservice json, isbehaviouraldiagnosis boolean, clinicianname character varying, address1 character varying, address2 character varying, city character varying, state character varying, county character varying, zipcode character varying, phonenumber character varying, currentdiagnosis character varying, phobiakey json, phobiacomments character varying, uploadpath json, reportname character varying,
 email character varying, evaluationby character varying, dateofevaluation timestamp without time zone, personabusesubstanceid uuid, parentabusesubstanceid uuid, isusetobacco boolean, isusedrugoralcohol boolean, isusedrug boolean, isusealcohol boolean, drugfrequencydetails character varying, drugageatfirstuse character varying, alcoholfrequencydetails character varying, alcoholageatfirstuse character varying, drugoralcoholproblems character varying, tobaccoageatfirstuse character varying, tobaccofrequencydetails character varying, 
 ischildhassextraffichistory boolean, issextraffichistoryreported boolean, sextraffichistoryreportedon date, ischildhassextraffic boolean, issextrafficreported boolean, sextrafficreportedon date, nochangesinsextraffic boolean, nodiagnosisreason text, updatedby character varying, updatedon timestamp, insertedon timestamp)
 LANGUAGE plpgsql
AS $function$

-- 03/24/2025 Simar Singh -- CIDM-10103 accept filter values for searching along with person id

DECLARE  

v_pagenumber int;
v_pageoffset int;
person_id uuid;
startDate timestamp;
endDate   timestamp;
    
BEGIN 


startDate := (filters ->> 'startDate')::timestamp;
endDate := (filters ->> 'endDate')::timestamp;
person_id := (filters ->> 'personid')::uuid;
v_pagenumber := v_liPageNumber - 1;
v_pageoffset := v_pagenumber * v_liPageSize;

return query        
select count(1) over() as totalcount,pbh.personbehavioralhealthid, pbh.typeofservice as typeofservice,pbh.isbehavioralhealth as isbehaviouraldiagnosis, 
pbh.clinicianname as clinicianname, pbh.address1 as addressline1, 
pbh.address2 as addressline2, pbh.city, pbh.state, pbh.county, pbh.zip as zipcode, pbh.phone as phonenumber, 
pbh.currentdiagnoses as currentdiagnosis,
pbh.phobiakey,pbh.phobiacomments, 
(SELECT json_agg(docs) FROM  (
    SELECT dp.documentpropertiesid, dp.objecttypekey, dp.title, dp.actualdocumentdate, dp.documenttypekey, dp.insertedon, dp.updatedon, 
    (select up.fullname as insertedby from userprofile up where up.securityusersid = dp.insertedby), 
    dp.updatedby, dp.documentdate, dp.mime, dp.s3bucketpathname, dp.description, dp.other,dp.filename,dp.numberofbytes, dp.originalfilename,
    (SELECT row_to_json(x) AS documentattachment FROM(                                                                               
    SELECT dat.documentpropertiesid, dat.attachmenttypekey, dat.attachmentclassificationtypekey, dat.attachmentclassificationsubtypekey, dat.assessmenttemplateid,
    (select up.fullname as updatedby from userprofile up where up.securityusersid = dat.updatedby) from documentattachment dat                                                                                   
    WHERE dat.documentpropertiesid = dp.documentpropertiesid                                                  
    ) x),
    dp.uploadstatus, 
    dp.finalstatus,
    dp.ecmsdocumentid
from documentproperties dp where dp.additionalobjectid = pbh.personbehavioralhealthid::varchar and dp.additionalobjecttype = 'personbehavioralhealth' and dp.activeflag in (1,3,4,5)
)docs) as uploadpath, 
pbh.reportname,
pbh.email,
pbh.evaluationby,
pbh.dateofevaluation,
pas.personabusesubstanceid,
pas.parentabusesubstanceid,
pas.isusetobacco, 
pas.isusedrugoralcohol, 
pas.isusedrug,
pas.isusealcohol, 
pas.drugfrequencydetails, 
pas.drugageatfirstuse,
pas.alcoholfrequencydetails,
pas.alcoholageatfirstuse,
pas.drugoralcoholproblems, 
pas.tobaccoageatfirstuse, 
pas.tobaccofrequencydetails,
pas.ischildhassextraffichistory,
pas.issextraffichistoryreported,
pas.sextraffichistoryreportedon,
pas.ischildhassextraffic,
pas.issextrafficreported,
pas.sextrafficreportedon,
pas.nochangesinsextraffic,
pbh.nodiagnosisreason,
(select fullname from v_userprofile where securityusersid = pas.updatedby limit 1),
pas.updatedon,
pbh.insertedon
from personbehavioralhealth pbh
inner join personabusesubstance pas on pas.parentabusesubstanceid=pbh.parentbehaviouralhealthid and pas.activeflag=1
where pbh.activeflag=1 and pbh.personid=person_id
and case when startDate is not null then Date(pbh.insertedon) >= Date(startDate) else true end
and case when endDate is not null then Date(pbh.insertedon) <= Date(endDate) else true end
 LIMIT v_liPageSize OFFSET v_pageoffset; 
END;

$function$
;