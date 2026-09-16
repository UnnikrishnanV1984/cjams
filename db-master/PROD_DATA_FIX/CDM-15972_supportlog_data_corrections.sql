/*
    CDM-15972
    Root cause: User unable to approve/reject a support log
    Issue : Insertedby record is not updated 
    Solution: Done a code fix for handling inserted record and data fix for the exiting record   

*/

update defecttracking.supportlog set insertedby = '2749e1a9-7e03-45ec-9127-cbdd9870b55d', updatedby = 'CDM-15972', updatedon = now() 
where supportlogid = '698033ee-f59b-4a5d-b287-ad237fb5ec67';

update defecttracking.supportlog set insertedby = 'e4271184-e42a-4639-88a5-4168eb1814f7', updatedby = 'CDM-15972', updatedon = now() 
where supportlogid = 'cf945162-1c38-45c7-813a-b7543aeb6443';

update defecttracking.supportlog set insertedby = '42af682f-5487-4fc2-bf00-05ec8b9c185b', updatedby = 'CDM-15972', updatedon = now() 
where supportlogid in (
    '434c0903-68e9-43f5-ae29-dfa334ffec27', 
    'd7fad557-9fba-4753-b582-4c8f9191f407', 
    '399d9368-1a6f-4271-9a9b-ee2266e62e19', 
    '78ed701b-1b13-4655-a6a1-29ec1110e1f7',
    '1137c0b9-db91-4ed0-9dfb-8e228b45af71', 
    'bc03dca8-2bfe-4bd7-ac4b-a43dfe8118e1'
);