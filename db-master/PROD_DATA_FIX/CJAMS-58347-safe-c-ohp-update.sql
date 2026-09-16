/*
Issue Description: The child's living arrangement is not populating on the Safe-C OHP. It will not even let me type it in.
Category/Module: Support
Root cause:  user can able to create assessment, but could not able to update values.
Fix provided: DB queries to update  record in assessment table.
Data/Code fix ticket#:CJAMS-58347
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Support
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/
--Case# 241030408358 and Client ID#  204073019

update assessment 
set submissiondata = submissiondata || '{"currentplacement": "true", "placementlivingarrangement": "Mount Washington", "addressline1": "1708 W Rogers Ave", 
"addressline2": "Baltimore, Maryland", "zipcode": "21209"}'::jsonb,
updatedby = 'CJAMS-58347', updatedon = now()
where assessmentid = '19036328-52e5-45c1-aa9e-ae2ba9ed9cca' and   activeflag =1;