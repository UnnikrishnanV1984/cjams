
/*
   Issue Description: CDM-32160
   Category/ Module  : Prod data fix to update correct inserted user details 
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

-- 628da123-2ce7-4c64-b7b4-d9949fd8c23a    JenniferStevenson    16d86b76-38c0-45dd-9bce-80503cd7e539
-- 24b7331d-f52d-4e13-bb62-ae8bc29dcbbf    JenniferStevenson    3de38392-9852-4ec3-9f38-1ed01d4940bf
-- fcb353c5-30db-4bb7-96fb-cdc67404c643    JenniferStevenson    65affd20-00d4-4c67-b401-0f62a05cf9d8
-- cc84a589-645c-4f6a-8f06-6909cc4c0663    JenniferStevenson    8c5ae9a5-dd41-4749-b583-4a518fac63f6
-- 5d8350c8-163d-4128-94f5-b0ec76fd6910    TyshelleAugustus    eb938f5e-ef52-43f9-b3e2-bc1ce2ee633e

 update documentproperties set insertedby = 'cc84a589-645c-4f6a-8f06-6909cc4c0663', updatedby = 'CDM-32160', updatedon = now()
where documentpropertiesid in 
('eb938f5e-ef52-43f9-b3e2-bc1ce2ee633e','3de38392-9852-4ec3-9f38-1ed01d4940bf','8c5ae9a5-dd41-4749-b583-4a518fac63f6','65affd20-00d4-4c67-b401-0f62a05cf9d8','16d86b76-38c0-45dd-9bce-80503cd7e539');	


 update documentattachment 
 set insertedby = 'cc84a589-645c-4f6a-8f06-6909cc4c0663', updatedby = 'CDM-32160', updatedon = now()
where documentpropertiesid in 
('eb938f5e-ef52-43f9-b3e2-bc1ce2ee633e','3de38392-9852-4ec3-9f38-1ed01d4940bf','8c5ae9a5-dd41-4749-b583-4a518fac63f6','65affd20-00d4-4c67-b401-0f62a05cf9d8','16d86b76-38c0-45dd-9bce-80503cd7e539');	
