/*
Issue Description: The child's living arrangement is not populating on the Safe-C OHP. It will not even let me type it in.
Category/Module: Support
Root cause:  user can able to create assessment, but could not able to update values.
Fix provided: DB queries to update  record in assessment table.
Data/Code fix ticket#: CDM-44198
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Support
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/
--Case# 231030112981and Client ID# 201233273
update assessment 
set submissiondata = submissiondata || '{"placementlivingarrangement": "THADDEUS L SMITH", "addressline1": "20 E Washington St", 
"addressline2": "Apt 2 Hagerstown, Maryland", "zipcode": "21740"}'::jsonb,
updatedby = 'CDM-44198', updatedon = now()
where assessmentid = '72e2b1a3-7059-495d-84ab-716bd6a91057' and activeflag =1;

--Case# 3184942 ,Client ID# 204006040
update assessment 
set submissiondata = submissiondata || '{"currentplacement": "true", "placementlivingarrangement": "DONNA WALTER", "addressline1": "818 N WOODLYNN RD", 
"addressline2": "Essex, Maryland", "zipcode": "21221"}'::jsonb,
updatedby = 'CDM-44198', updatedon = now()
where assessmentid = 'f33f17cc-f0f1-400d-ae15-f36d2838693d' and   activeflag =1;

--Case# 3184942 and Client ID# 204006040
update assessment 
set submissiondata = submissiondata || '{"currentplacement": "true", "placementlivingarrangement": "DONNA WALTER", "addressline1": "818 N WOODLYNN RD", 
"addressline2": "Essex, Maryland", "zipcode": "21221"}'::jsonb,
updatedby = 'CDM-44198', updatedon = now()
where assessmentid = '4244ff1b-c14d-47da-9b5c-57320a10a2a1' and   activeflag =1;
--Case# 3184942 and Client ID# 204006050 
update assessment 
set submissiondata = submissiondata || '{"currentplacement": "true", "placementlivingarrangement": "DONNA WALTER", "addressline1": "818 N WOODLYNN RD", 
"addressline2": "Essex, Maryland", "zipcode": "21221"}'::jsonb,
updatedby = 'CDM-44198', updatedon = now()
where assessmentid = '1d90c808-80fe-4b26-8515-0a85d8564c78' and   activeflag =1;