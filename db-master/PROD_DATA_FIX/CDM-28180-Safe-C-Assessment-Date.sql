/*
    Issue Description: CDM-28180
    Category/ Module  :  Safe c Assessment
    Root cause: Dates are not correct in assessment
    Pull request# for code fix:7855
    Reason why no related code fix: 
    Status of the code fix if already submitted and expected prod fix date: 
*/
update assessment 
set submissiondata =  replace(submissiondata::text, '"dateoflastsafetyplan": "2022-10-31T16:30",', '"dateoflastsafetyplan": "2022-11-20T01:45",')::json, updatedby = 'CDM-28180', updatedon = now()
where assessmentid = '5aa0b000-f070-4967-a35a-9435b1c53940';

update assessment 
set submissiondata =  replace(submissiondata::text, '"dateoflastsafetyplan": "2022-11-30T13:45",', '"dateoflastsafetyplan": "2023-01-04T08:30",')::json, updatedby = 'CDM-28180', updatedon = now()
where assessmentid = '11a7f0fb-9892-4f39-bb10-eff94a896eb2';
 