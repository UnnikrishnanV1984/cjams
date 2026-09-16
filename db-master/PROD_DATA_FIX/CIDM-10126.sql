/*
 * CIDM-10126 - Date format in SAFEC_OHP_ASSESSMENT has changed
 * Description: Date format on SAFEC OHp assessment has changes which is causing problem in the report .Please keep old format only.
 * Date format issue for dateassessmentinitiated, approveddate and safetydecision fields(Example: 01/23/2025 4:04 pm - Incorrect format)
 * Data Fix: Updated the date format to ISO String (Example:  2025-01-28T18:49:00.000Z - correct format)
 *
 */

--select (u1.submissiondata -> 'dateassessmentinitiated') as old 
--, (to_char(to_timestamp(u1.submissiondata->>'dateassessmentinitiated'::text, 'mm/dd/yyyy hh12:mi am,pm'),  'YYYY-MM-DD"T"HH24:MI:SS.MS"Z"')) as new 
--from cjams.assessment u1 where u1.assessmenttemplateid = 'f6e4c466-72ae-4453-9997-a2a12fcf8035' 
--and (u1.submissiondata ->> 'dateassessmentinitiated') SIMILAR TO '%(am|pm)%';

UPDATE assessment
SET updatedon  = now(), updatedby ='CIDM-10126', 
submissiondata = jsonb_set(submissiondata, '{dateassessmentinitiated}', to_jsonb(to_char(to_timestamp(submissiondata->>'dateassessmentinitiated'::text, 'mm/dd/yyyy hh12:mi am,pm'),  'YYYY-MM-DD"T"HH24:MI:SS.MS"Z"')))
WHERE assessmenttemplateid = 'f6e4c466-72ae-4453-9997-a2a12fcf8035' 
and (submissiondata ->> 'dateassessmentinitiated') SIMILAR TO '%(am|pm)%';

--select (u1.submissiondata -> 'approveddate') as old 
--, (to_char(to_timestamp(u1.submissiondata->>'approveddate'::text, 'mm/dd/yyyy hh12:mi am,pm'),  'YYYY-MM-DD"T"HH24:MI:SS.MS"Z"')) as new 
--from cjams.assessment u1 where u1.assessmenttemplateid = 'f6e4c466-72ae-4453-9997-a2a12fcf8035' 
--and (u1.submissiondata ->> 'approveddate') SIMILAR TO '%(am|pm)%';

UPDATE assessment
SET updatedon  = now(), updatedby ='CIDM-10126', 
submissiondata = jsonb_set(submissiondata, '{approveddate}', to_jsonb(to_char(to_timestamp(submissiondata->>'approveddate'::text, 'mm/dd/yyyy hh12:mi am,pm'),  'YYYY-MM-DD"T"HH24:MI:SS.MS"Z"')))
WHERE assessmenttemplateid = 'f6e4c466-72ae-4453-9997-a2a12fcf8035' 
and (submissiondata ->> 'approveddate') SIMILAR TO '%(am|pm)%';

--select (u1.submissiondata -> 'safetydecision') as old 
--, (to_char(to_timestamp(u1.submissiondata->>'safetydecision'::text, 'mm/dd/yyyy hh12:mi am,pm'),  'YYYY-MM-DD"T"HH24:MI:SS.MS"Z"')) as new 
--from cjams.assessment u1 where u1.assessmenttemplateid = 'f6e4c466-72ae-4453-9997-a2a12fcf8035' 
--and (u1.submissiondata ->> 'safetydecision') SIMILAR TO '%(am|pm)%';

UPDATE assessment
SET updatedon  = now(), updatedby ='CIDM-10126', 
submissiondata = jsonb_set(submissiondata, '{safetydecision}', to_jsonb(to_char(to_timestamp(submissiondata->>'safetydecision'::text, 'mm/dd/yyyy hh12:mi am,pm'),  'YYYY-MM-DD"T"HH24:MI:SS.MS"Z"')))
WHERE assessmenttemplateid = 'f6e4c466-72ae-4453-9997-a2a12fcf8035' 
and (submissiondata ->> 'safetydecision') SIMILAR TO '%(am|pm)%';