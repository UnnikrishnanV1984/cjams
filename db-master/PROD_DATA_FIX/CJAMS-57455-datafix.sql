/*
Issue Description:User has requested a data fix  for SAFE-C OHP assessment (in Draft/Review record)
Category/Module: Bug
Root cause: User has requested a data fix  for SAFE-C OHP assessment
Fix provided: DB queries to do a data fix  for SAFE-C OHP assessment
Data/Code fix ticket#: CJAMS-57455
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
*/

UPDATE assessment
SET submissiondata = jsonb_set( jsonb_set(
              jsonb_set( jsonb_set(
                  jsonb_set(submissiondata::jsonb, '{ClientName}', '"Nevae EBONY MACK"'),'{addressline1}', '"7021 Arundel Mills Cir"'),
                  '{addressline2}', '"Hanover , Maryland"'),
              '{zipcode}', '"21076"'), '{placementlivingarrangement}', '"Foster Care - Non-Foster Home setting"'),
              updatedon =now(),
              updatedby = 'CJAMS-57455'
WHERE objectid='eace25f7-a272-496f-8db2-345637289700' 
  AND assessmentid='b760c108-2192-4330-b5c3-6395e1dec2b4'  
  AND submissionid='5af2fd19-1c31-4f4f-93a9-acbaf6cd255a'  
  AND activeflag=1;