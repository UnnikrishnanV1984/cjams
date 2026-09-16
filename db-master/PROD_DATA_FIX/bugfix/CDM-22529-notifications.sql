/*
--CDM-22529-notifications

-- Issue Description: 
User has duplicate notifications
-- Root cause: Closed all the duplicated notifications
-- Pull request# 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update usernotification 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-22529'
where usernotificationid in ('f1e8c588-ca36-4efc-8ddc-ee672b2dc34b','85bd3b1b-8a35-4e76-8bcc-b5809a4e0ce8', 'c5411c4a-8e17-44bf-8997-916051decf5a', 
'b92c4bf4-b762-42be-b6f5-944793f7c97a', '773120f8-b7d2-43a1-8e38-fd935ba05280', '286c47b9-5967-40ba-85b9-617a79cb3d50', 'bcaf247d-4828-494b-9fe0-fb89a257587e', 'd7c678f2-dfa8-4200-b9d5-828c5161d104',
'6bd3a3b6-20cf-4de1-99f9-efed2cfd5f8f','b283165d-ccdf-492f-8a83-8ab2bf330927','f6f0e09d-4561-43ec-8bcc-bb7a14567b84', '1092dacc-c169-4d10-919b-5661f3d0b5e4','b211c03d-0b27-471c-8ab6-de4444414661',
'0e0092f4-7798-4740-8ca4-2e8dfc3c6972','3f192c37-4ced-416e-b6b8-6e903651ce74', '90d24328-bb48-4728-8870-4440efd4a309','ea439f2b-b765-4216-b080-8023d171a260', '0c7150ee-9ad6-4e79-8418-585346a33d62','68a69396-3a89-4c14-8785-6cd92f44af7b',
'1a2b5532-46c5-4310-b8ff-0a554c5cc5cb','ba55f81f-5151-4b60-8e34-1de574050eb0') ;