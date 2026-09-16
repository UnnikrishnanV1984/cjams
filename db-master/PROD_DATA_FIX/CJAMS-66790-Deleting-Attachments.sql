
/*
   Issue Description: CJAMS-66790-Deleting-Attachments
   Category/ Module  : Documents
   Root cause: 261023653298:Documents were attempted to be uploaded from an iPad. Document action reflects as "upload/scan in progress" with no 
      ability to view or edit the documents. Looking to delete any documents that have the action as "upload/scan in progress".
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update documentproperties 
set activeflag =0, updatedby ='CJAMS-66790', updatedon = now()
where documentpropertiesid in ('e238df42-119a-4b92-ae86-f6bbed750de4','b39cfb85-54fb-4b98-959e-7801140677e0','f8d168d7-66e5-45eb-9f03-a1d113647f0a','15177ec6-c5ef-480c-b369-da5ba41196e5','8e1df864-07a2-483e-b20d-5e5a2fa009ff','bfc6201a-27b3-4465-91f5-03ccffb15949','602c33a3-a199-4d08-b006-06e574363d6c','e6ae137c-f56d-4594-be12-3e31a5e1c6f3','6e6bbb87-bd01-4302-8837-f98ac0cbbe8e','7f064da1-d5e9-4d34-a75e-d1128758286b','b40b3746-6b0d-4c7d-9c08-7563ec982ce2','4ca257da-8a45-4630-b4c4-81d1395310f1','2bbd4503-939f-4b4b-9d08-53ceb7016a44') and activeflag =3;


update documentattachment 
set activeflag =0, updatedby ='CJAMS-66790', updatedon = now()
where documentpropertiesid in ('e238df42-119a-4b92-ae86-f6bbed750de4','b39cfb85-54fb-4b98-959e-7801140677e0','f8d168d7-66e5-45eb-9f03-a1d113647f0a','15177ec6-c5ef-480c-b369-da5ba41196e5','8e1df864-07a2-483e-b20d-5e5a2fa009ff','bfc6201a-27b3-4465-91f5-03ccffb15949','602c33a3-a199-4d08-b006-06e574363d6c','e6ae137c-f56d-4594-be12-3e31a5e1c6f3','6e6bbb87-bd01-4302-8837-f98ac0cbbe8e','7f064da1-d5e9-4d34-a75e-d1128758286b','b40b3746-6b0d-4c7d-9c08-7563ec982ce2','4ca257da-8a45-4630-b4c4-81d1395310f1','2bbd4503-939f-4b4b-9d08-53ceb7016a44') and activeflag =1;
