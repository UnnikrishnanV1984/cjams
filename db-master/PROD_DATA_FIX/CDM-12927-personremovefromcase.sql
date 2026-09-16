update intakeservicerequestactor i set activeflag = 0, updatedon = now(), updatedby = 'CDM-12927' where servicecaseid = '5fe6fb83-1ae1-46dd-8325-f32b64d2624e' and personid in (
'd76b0f08-c420-47ee-b37c-46f94142ee13',
'25bf11cd-9eeb-4c8b-a847-b2becddd0bbd',
'4fd7f4da-eda6-403c-b1bf-1ed53e18e665',
'4f970b23-abe9-4449-8aa2-65cecd5aa89c'
);

update actor set activeflag = 0, updatedon = now(), updatedby = 'CDM-12927' where servicecaseid = '5fe6fb83-1ae1-46dd-8325-f32b64d2624e' and personid in (
'd76b0f08-c420-47ee-b37c-46f94142ee13',
'25bf11cd-9eeb-4c8b-a847-b2becddd0bbd',
'4fd7f4da-eda6-403c-b1bf-1ed53e18e665',
'4f970b23-abe9-4449-8aa2-65cecd5aa89c'
);
