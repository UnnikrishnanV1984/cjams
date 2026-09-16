/*
  Issue Description: CJAMS-61264 Updates needed for NYTD Surveys
  Category/ Module : NYTD Surveys
  Root cause: : Survey Results for Element 42 Public financial assistance / Element 43 Public food assistance/Element 44 Public housing assistance has to be "Not Applicable" if "Element 36 - Foster Care Outcome is "Yes" otherwise it's Federally non-compliant.
                Data fix needs to be done to update the records The Survey answers to be updated are for the following elements to "not applicable" Element 42 Public financial assistanceElement 43 Public food assistanceElement 44 Public housing assistance    
                Updates needed for the following records as per Uma: 004086077 , 004338020, 004442974, 002085375, 002192963, 200870400, 200852957, 200022312, 200772429, 003291944, 002285943.
                Code fix will be done to handle this issue.               
  Fix Provided: Data fix has been done to update the surveyed records to not applicable for records 004086077 , 004338020, 004442974, 002085375, 002192963, 200870400, 200852957, 200022312, 200772429, 003291944, 002285943.
  Regression Impacts: N/A
  Is Code fix needed: Code fix needed to disabled other selections and only allow not applicable when "Element 36 - Foster Care Outcome is "Yes" for Element 42 Public financial assistance / Element 43 Public food assistance/Element 44 Public housing assistance and corresponding records.
  Code fix ticket # : TBD
  Reason why no related code fix: N/A 
*/


update personnytddetail set elementvalue = 'not applicable', updatedon = now() where summaryid ='a34ec816-5699-4bb4-9338-9599a168715d' and elementid in ('ce0f19c9-f729-43b1-93e2-30028f78b3c9',
'2ee71064-b5e3-408d-add0-3349b7b57182','d3412f6b-6eab-4336-bf63-9725879cfb74');

update personnytddetail set elementvalue = 'not applicable', updatedon = now() where summaryid ='e822d496-f990-48ad-9166-e37da9f17922' and elementid in ('ce0f19c9-f729-43b1-93e2-30028f78b3c9',
'2ee71064-b5e3-408d-add0-3349b7b57182','d3412f6b-6eab-4336-bf63-9725879cfb74');

update personnytddetail set elementvalue = 'not applicable', updatedon = now() where summaryid ='8a9bbc4e-483a-468b-90bf-2916d28ddf33' and elementid in ('ce0f19c9-f729-43b1-93e2-30028f78b3c9',
'2ee71064-b5e3-408d-add0-3349b7b57182','d3412f6b-6eab-4336-bf63-9725879cfb74');

update personnytddetail set elementvalue = 'not applicable', updatedon = now() where summaryid ='427f04da-384e-420e-9222-47ab58a08c9e' and elementid in ('ce0f19c9-f729-43b1-93e2-30028f78b3c9',
'2ee71064-b5e3-408d-add0-3349b7b57182','d3412f6b-6eab-4336-bf63-9725879cfb74');

update personnytddetail set elementvalue = 'not applicable', updatedon = now() where summaryid ='0b2a0f8e-05ac-4822-9ada-0708db066370' and elementid in ('ce0f19c9-f729-43b1-93e2-30028f78b3c9',
'2ee71064-b5e3-408d-add0-3349b7b57182','d3412f6b-6eab-4336-bf63-9725879cfb74');

update personnytddetail set elementvalue = 'not applicable', updatedon = now() where summaryid ='f3a52e66-93ed-4baa-9a83-f0fc7044e1af' and elementid in ('ce0f19c9-f729-43b1-93e2-30028f78b3c9',
'2ee71064-b5e3-408d-add0-3349b7b57182','d3412f6b-6eab-4336-bf63-9725879cfb74');

update personnytddetail set elementvalue = 'not applicable', updatedon = now() where summaryid ='c342146f-10d7-486f-92ac-30918d350ea9' and elementid in ('ce0f19c9-f729-43b1-93e2-30028f78b3c9',
'2ee71064-b5e3-408d-add0-3349b7b57182','d3412f6b-6eab-4336-bf63-9725879cfb74');

update personnytddetail set elementvalue = 'not applicable', updatedon = now() where summaryid ='eda6c891-86ff-4e8b-990a-79829e3eb04a' and elementid in ('ce0f19c9-f729-43b1-93e2-30028f78b3c9',
'2ee71064-b5e3-408d-add0-3349b7b57182','d3412f6b-6eab-4336-bf63-9725879cfb74');

update personnytddetail set elementvalue = 'not applicable', updatedon = now() where summaryid ='eb80fe5a-c270-4643-8fb6-1995b2513b9a' and elementid in ('ce0f19c9-f729-43b1-93e2-30028f78b3c9',
'2ee71064-b5e3-408d-add0-3349b7b57182','d3412f6b-6eab-4336-bf63-9725879cfb74');

update personnytddetail set elementvalue = 'not applicable', updatedon = now() where summaryid ='eebc1f67-270c-4df7-a2de-09ed58df1bab' and elementid in ('ce0f19c9-f729-43b1-93e2-30028f78b3c9',
'2ee71064-b5e3-408d-add0-3349b7b57182','d3412f6b-6eab-4336-bf63-9725879cfb74');

update personnytddetail set elementvalue = 'not applicable', updatedon = now() where summaryid ='45624c0b-5b3d-4a5e-bf2a-5b5a6d909a01' and elementid in ('ce0f19c9-f729-43b1-93e2-30028f78b3c9',
'2ee71064-b5e3-408d-add0-3349b7b57182','d3412f6b-6eab-4336-bf63-9725879cfb74');