/* 
    Issue Description: CDM-44197
   Category/ Module  : Placement/Living Arrangement not populating
   Root cause: : User has requested to add the SAFE-C OHP assessment (in Draft/Review record)
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete:
*/


UPDATE assessment
SET submissiondata = jsonb_set( jsonb_set(
              jsonb_set( jsonb_set(
                  jsonb_set(submissiondata::jsonb, '{ClientName}', '"Lyric Palmer"'),'{addressline1}', '"4408 Bayonne Ave 21206"'),
                  '{addressline2}', '"Baltimore, Maryland"'),
              '{zipcode}', '"21206"'), '{placementlivingarrangement}', '"Yvonne Palmer"'),
              updatedon =now(),
              updatedby = 'CDM-44197'
WHERE objectid='f5b7b307-3d90-4848-a6e4-c10a9a80e754' 
  AND assessmentid='7ae78171-b20e-4918-b01d-811fbdeda6fb'  
  AND submissionid='925d1c12-9d44-477f-bf6e-bfcd1b2397a9'  
  AND activeflag=1;