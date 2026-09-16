
-- 10/18/2023 prasanna sai kommineni -- CIDM-9541 B-206485 : CW-Psychotropic Medications - Secondary Review



DROP FUNCTION IF EXISTS cjams.addpsychotropicmedications(psychotropic json);

CREATE OR REPLACE FUNCTION cjams.addpsychotropicmedications(psychotropic json)
 RETURNS json
 LANGUAGE plpgsql
AS $function$
DECLARE 
v_psychotropic json;
v_result json;
currentRow record;
currentothercurrentmedication jsonb;
v_psychotropicid uuid;
v_psycotrophicothercurrentmedicationid uuid;
v_documents json;
v_psycotrophicothercurrentmedication jsonb;
BEGIN
v_psychotropic := psychotropic;
v_documents := v_psychotropic ->> 'documents'; 
v_psycotrophicothercurrentmedication :=(v_psychotropic -> 'psycotrophicothercurrentmedication')::jsonb; 
if (v_psychotropic ->> 'psychotropicid') is not  null
then
update  cjams.psychotropicmedications 
set 
objecttypekey = v_psychotropic ->> 'objecttypekey',
objectid = (v_psychotropic ->> 'objectid')::uuid,
personid = (v_psychotropic ->> 'personid')::uuid,
medicationname = v_psychotropic ->> 'medicationname',
classification = v_psychotropic ->> 'classification',
dateprescribed = (v_psychotropic ->> 'dateprescribed')::timestamp,
targetedsymptoms = v_psychotropic ->> 'targetedsymptoms',
methodofdelivery = v_psychotropic ->> 'methodofdelivery',
prescribedduration = v_psychotropic ->> 'prescribedduration',
isdraft = (v_psychotropic ->> 'isdraft')::boolean,
age=(v_psychotropic ->> 'age'),
peerdecision=(v_psychotropic ->> 'peerdecision'),
medicaldiagnosis=(v_psychotropic ->> 'medicaldiagnosis'),
othermedications=v_psychotropic ->> 'othermedications',
countytypekey = v_psychotropic ->> 'countytypekey',
peerreview = (v_psychotropic ->> 'peerreview')::boolean,
revieweddate = (v_psychotropic ->> 'revieweddate')::date,
reviewedby = v_psychotropic ->> 'reviewedby',
isinfoincomplete =(v_psychotropic ->> 'isinfoincomplete')::boolean,
prescriberdegree = v_psychotropic ->> 'prescriberdegree',
otherprescriberdegree = v_psychotropic ->> 'otherprescriberdegree',
prescriberspecialty = v_psychotropic ->> 'prescriberspecialty',
otherprescriberspecialty = v_psychotropic ->> 'otherprescriberspecialty',
settingmedicationprescribed = v_psychotropic ->> 'settingmedicationprescribed',
otherdiagnosis = v_psychotropic ->> 'otherdiagnosis',
psychosocialinterventions = v_psychotropic ->> 'psychosocialinterventions' ,
 additionalpsychosocialinterventions = v_psychotropic ->> 'additionalpsychosocialinterventions' ,
 otheradditionalpsychosocialinterventions = v_psychotropic ->> 'otheradditionalpsychosocialinterventions',
dosage = v_psychotropic ->> 'dosage',
frequency = v_psychotropic ->> 'frequency',
diagnosis = v_psychotropic ->> 'diagnosis',
prescribername = v_psychotropic ->> 'prescribername',
prescribercontactinfo = v_psychotropic ->> 'prescribercontactinfo',
prescriberemail = v_psychotropic ->> 'prescriberemail',
otherfrequency = v_psychotropic ->> 'otherfrequency',
othersymptoms = v_psychotropic ->> 'othersymptoms',
specifyhour = v_psychotropic ->> 'specifyhour',
psychotropiccomments = v_psychotropic ->> 'psychotropiccomments',
specifyduration = v_psychotropic ->> 'specifyduration',
otherspecifyduration = v_psychotropic ->> 'otherspecifyduration',
updatedon =now(),
updatedby =v_psychotropic ->> 'user_id'
where psychotropicid =(v_psychotropic ->> 'psychotropicid')::uuid
returning psychotropicid:: uuid into v_psychotropicid;

if(v_psycotrophicothercurrentmedication) is not  null
then
for currentothercurrentmedication IN SELECT * FROM jsonb_array_elements(v_psycotrophicothercurrentmedication::jsonb)   
loop
if(currentothercurrentmedication ->> 'psycotrophicothercurrentmedicationid') is not null
then
UPDATE cjams.psycotrophicothercurrentmedication
SET
    dosage = currentothercurrentmedication ->> 'dosage',
    indication = currentothercurrentmedication ->> 'indications',
    currentmedication = currentothercurrentmedication ->> 'medication',
    updatedon = NOW(),
    updatedby = v_psychotropic ->> 'user_id'
WHERE
    psycotrophicothercurrentmedicationid =(currentothercurrentmedication ->> 'psycotrophicothercurrentmedicationid')::uuid 
     returning psycotrophicothercurrentmedicationid:: uuid into v_psycotrophicothercurrentmedicationid;
    
else
INSERT INTO cjams.psycotrophicothercurrentmedication (
    psychotropicid,
    currentmedication,
    dosage,
    indication,
    insertedon,
    insertedby,
    updatedon,
    updatedby,
    activeflag
) VALUES (
    v_psychotropicid::uuid,
   currentothercurrentmedication ->> 'medication',
   currentothercurrentmedication ->> 'dosage',
   currentothercurrentmedication ->> 'indications',
    now(),
    v_psychotropic ->> 'user_id',
    now(), 
    v_psychotropic ->> 'user_id',
    1
)returning psycotrophicothercurrentmedicationid :: uuid into v_psycotrophicothercurrentmedicationid;
end if;
END LOOP;  
end if;

for currentRow IN SELECT * FROM json_array_elements(v_documents)   
loop
select * from cjams.updatedocumentproperties(null, currentRow ->> 'uploadpath',v_psychotropicid::varchar,'psychotropicmedications', null,v_psychotropic ->> 'user_id');
 END LOOP;    

else
insert into cjams.psychotropicmedications (objecttypekey,objectid ,personid,medicationname ,classification ,dateprescribed ,targetedsymptoms ,
methodofdelivery ,prescribedduration ,isdraft,age,peerdecision,medicaldiagnosis,othermedications,countytypekey,peerreview,revieweddate,reviewedby,isinfoincomplete,prescriberdegree,otherprescriberdegree,prescriberspecialty,otherprescriberspecialty,settingmedicationprescribed,otherdiagnosis,psychosocialinterventions , additionalpsychosocialinterventions , otheradditionalpsychosocialinterventions,
otherfrequency,othersymptoms,specifyhour, dosage ,frequency ,diagnosis,prescribername ,prescribercontactinfo  ,prescriberemail ,psychotropiccomments,specifyduration,otherspecifyduration ,insertedon ,insertedby ,updatedon ,updatedby ,activeflag )
values (
v_psychotropic ->> 'objecttypekey',
(v_psychotropic ->> 'objectid')::uuid,
(v_psychotropic ->> 'personid')::uuid,
v_psychotropic ->> 'medicationname',
v_psychotropic ->> 'classification',
(v_psychotropic ->> 'dateprescribed')::timestamp,
v_psychotropic ->> 'targetedsymptoms',
 v_psychotropic ->> 'methodofdelivery',
v_psychotropic ->> 'prescribedduration',
(v_psychotropic ->> 'isdraft')::boolean,
(v_psychotropic ->> 'age'),
v_psychotropic ->> 'peerdecision',
v_psychotropic ->> 'medicaldiagnosis',
v_psychotropic ->> 'othermedications',
v_psychotropic ->> 'countytypekey',
 (v_psychotropic ->> 'peerreview')::boolean,
 (v_psychotropic ->> 'revieweddate')::date,
 v_psychotropic ->> 'reviewedby',
(v_psychotropic ->>'isinfoincomplete')::boolean,
v_psychotropic ->> 'prescriberdegree',
v_psychotropic ->> 'otherprescriberdegree',
v_psychotropic ->> 'prescriberspecialty',
v_psychotropic ->> 'otherprescriberspecialty',
v_psychotropic ->> 'settingmedicationprescribed',
v_psychotropic ->> 'otherdiagnosis',
v_psychotropic ->> 'psychosocialinterventions' ,
 v_psychotropic ->> 'additionalpsychosocialinterventions' ,
 v_psychotropic ->> 'otheradditionalpsychosocialinterventions',
 v_psychotropic ->> 'otherfrequency',
 v_psychotropic ->> 'othersymptoms',
 v_psychotropic ->> 'specifyhour',
v_psychotropic ->> 'dosage',
v_psychotropic ->> 'frequency',
v_psychotropic ->> 'diagnosis',
v_psychotropic ->> 'prescribername',
v_psychotropic ->> 'prescribercontactinfo',
v_psychotropic ->> 'prescriberemail',
v_psychotropic ->> 'psychotropiccomments',
v_psychotropic ->> 'specifyduration',
v_psychotropic ->> 'otherspecifyduration',
now(),
v_psychotropic ->> 'user_id',
now(),
v_psychotropic ->> 'user_id',
1)returning psychotropicid :: uuid into v_psychotropicid;

if(v_psycotrophicothercurrentmedication) is not  null
then
for currentothercurrentmedication IN SELECT * FROM jsonb_array_elements(v_psycotrophicothercurrentmedication)   
loop
INSERT INTO cjams.psycotrophicothercurrentmedication (
    psychotropicid,
    currentmedication,
    dosage,
    indication,
    insertedon,
    insertedby,
    updatedon,
    updatedby,
    activeflag
) VALUES (
    v_psychotropicid::uuid,
    currentothercurrentmedication ->> 'medication',
    currentothercurrentmedication ->> 'dosage',
    currentothercurrentmedication ->> 'indications',
    now(),
    v_psychotropic ->> 'user_id',
    now(), 
    v_psychotropic ->> 'user_id',
    1
)returning psycotrophicothercurrentmedicationid :: uuid into v_psycotrophicothercurrentmedicationid;

END LOOP;  
end if;

for currentRow IN SELECT * FROM json_array_elements(v_documents)   
loop
select *  from cjams.updatedocumentproperties(null, currentRow ->> 'uploadpath',v_psychotropicid::varchar,'psychotropicmedications', null,v_psychotropic ->> 'user_id');
 END LOOP; 
  
end if;

SELECT json_agg(a) into v_result FROM 
		(
		select v_psychotropicid as psychotropicid ,   v_psycotrophicothercurrentmedicationid as psycotrophicothercurrentmedicationid
			
		) a;
RETURN v_result;
END;
$function$;