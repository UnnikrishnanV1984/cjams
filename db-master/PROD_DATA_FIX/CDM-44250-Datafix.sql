/*
 Issue Description: CDM-44250
-- Category/ Module: Assessments-Home health report
-- Root cause: Code fix is done for patching the relationship in home health report, For this case data fix is promoted
-- Fix Provided:Data fix is promoted to update the relationship for the approved home health report.
-- Pull request# N/A
-- Reason why no related code fix: N/A
*/


with filtered_assessments as (
    select assessmentid, jsonb_array_elements(submissiondata->'householdmemberdetail') as details from assessment where assessmentid = 'b07afb61-eae7-4da2-a68e-d4374e49e261'
),
updated_assessments as (
    select assessmentid, 
    case 
        when details->>'householdpersonid' = 'f966e199-73f6-447a-98e3-e712d9aa8acc' then jsonb_set(details, '{householdmemberrelationship}', '"self"'::jsonb)
        when details->>'householdpersonid' = '34e2ba38-9cac-4a8a-9276-0f24d73f5c1b' then jsonb_set(details, '{householdmemberrelationship}', '"Boyfriend"'::jsonb)
    end as householdrelationships
    from filtered_assessments
),
finalresult as (
    select 
        a.assessmentid,
        jsonb_set(a.submissiondata, '{householdmemberdetail}', jsonb_agg(uss.householdrelationships)) as submissiondatas
    from assessment a
    inner join updated_assessments uss on uss.assessmentid = a.assessmentid
    group by a.assessmentid
)
update assessment a
set submissiondata = submissiondatas
from finalresult f
where a.assessmentid = f.assessmentid