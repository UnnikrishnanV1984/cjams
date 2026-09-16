/*
   Issue Description: CDM-32025
   Category/ Module  : Prod data fix to update inserted user details for contact notes
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/



-- CDM-32125
--114a224a-7890-46bd-866c-0a5a6f021a86
--18dcbaa8-a77d-4671-9535-c49430bed7bd
--dffeeac8-06ad-4124-8f8d-8660da1c6262
--eb422c47-a919-41e0-84bd-113600205444
 update documentproperties set insertedby = 'f1a66612-7506-401f-9a75-47446839debf', updatedby = 'CDM-32125', updatedon = now()
where documentpropertiesid in ('d2119220-2a8b-45b0-ad98-a5efadb04376','10f082a9-3f76-4b98-b2eb-4ac758bf9c6a', '1d4bd4e1-13ad-4629-a4ac-a6b5cebf4919','867a64b8-8755-4264-8b81-9ad6995741e1');


-- d6c2ad8f-ab3f-4420-9287-2aab0c338f48 
update documentproperties set insertedby = '7fa341da-4746-46af-af86-dfe9cfed7342', updatedby = 'CDM-32125', updatedon = now()
where documentpropertiesid = '7d475cb2-4386-4f76-9bcf-6b3a01fbd23b';







-- CDM-32175
-- 6e89b8fa-8cbf-48cf-9a04-eec765476e9b
update documentproperties set insertedby = '669f5972-d784-44ee-8dbd-00a013e444da', updatedby = 'CDM-32175', updatedon = now()
where documentpropertiesid = '3a85a8c9-9e1d-4da7-859f-82c25f161caa';

-- e6e2fe7b-cbab-48c0-b7ef-06bbffd7ad26
update documentproperties set insertedby = '669f5972-d784-44ee-8dbd-00a013e444da', updatedby = 'CDM-32175', updatedon = now()
where documentpropertiesid = '49f7a2d2-18a0-438e-bf78-f73948ae33ac';




-- CDM-32175
-- 6e89b8fa-8cbf-48cf-9a04-eec765476e9b
update documentattachment set insertedby = '669f5972-d784-44ee-8dbd-00a013e444da', updatedby = 'CDM-32175', updatedon = now()
where documentpropertiesid = '3a85a8c9-9e1d-4da7-859f-82c25f161caa';

-- e6e2fe7b-cbab-48c0-b7ef-06bbffd7ad26
update documentattachment set insertedby = '669f5972-d784-44ee-8dbd-00a013e444da', updatedby = 'CDM-32175', updatedon = now()
where documentpropertiesid = '49f7a2d2-18a0-438e-bf78-f73948ae33ac';

