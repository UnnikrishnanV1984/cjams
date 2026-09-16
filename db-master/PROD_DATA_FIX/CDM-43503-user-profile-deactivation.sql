/*
   Issue Description: CDM-43503 Delete Users
   Category/ Module  : User Management
   Root cause: Data fix to deactivate user profiles who are inactive in sailpoint
   User list:   chelsea.presock@maryland.gov
                courtney.barzandeh@maryland.gov
                stephanie.pinchback@maryland.gov
                katie.hitch@maryland.gov
                regina.bailey1@maryland.gov
                gereka.simms2@maryland.gov
                kuronda.purnell2@maryland.gov
                erin.leffew@maryland.gov
                landrie.armstrong@maryland.gov
                jeremy.tyler@maryland.gov
                ginger.shimek@maryland.gov
   Fix Provided: Data fix to Soft delete the users from rolemapping, user resource, userprofile, muser,userprofileaddress,teammemberassignment,teammember and securityusers tables for user profile deactivation.
   Data/Code fix ticket#: CDM-43503
   Regression Impacts: N/A
   Is Code fix Required?: No
   Code fix ticket#: N/A
   Reason why no related code fix: Sailpoint issue
   Status of the code fix if already submitted and expected prod fix date:  
*/

update userprofile 
set activeflag = 0, 
    updatedby = 'CDM-43503',
    updatedon = now() 
    where email in ('chelsea.presock@maryland.gov','courtney.barzandeh@maryland.gov','stephanie.pinchback@maryland.gov','katie.hitch@maryland.gov','regina.bailey1@maryland.gov','gereka.simms2@maryland.gov','kuronda.purnell2@maryland.gov','erin.leffew@maryland.gov','landrie.armstrong@maryland.gov','jeremy.tyler@maryland.gov','ginger.shimek@maryland.gov')
    and activeflag=1;

update muser 
set activeflag = 0, 
    updatedby = 'CDM-43503',
    updatedon = now() 
    where email in ('chelsea.presock@maryland.gov','courtney.barzandeh@maryland.gov','stephanie.pinchback@maryland.gov','katie.hitch@maryland.gov','regina.bailey1@maryland.gov','gereka.simms2@maryland.gov','kuronda.purnell2@maryland.gov','erin.leffew@maryland.gov','landrie.armstrong@maryland.gov','jeremy.tyler@maryland.gov','ginger.shimek@maryland.gov')
    and activeflag=1;

update rolemapping 
    set activeflag = 0, 
    updatedby = 'CDM-43503', 
    updatedon = now() 
    where principalid in ('37486','14528','14033','14775','14111','15550','23877','34879','29350','29383','36284')
    and activeflag = 1;

update userresource 
    set activeflag = 0, 
    updatedby = 'CDM-43503', 
    updatedon = now() 
    where userid in ('37486','14528','14033','14775','14111','15550','23877','34879','29350','29383','36284')
    and activeflag = 1;

update userprofileaddress
    set activeflag = 0,
    updatedby = 'CDM-43503', 
    updatedon = now()
    where securityusersid in('6c610d8a-7ddb-48b6-85ea-944f80ceb7e2','3de3d6b0-677b-4a87-ac7f-0796b2daf7f0','87940a8f-4718-435e-b938-96825302c923','e1ad8939-3ea6-4f52-aa1a-0b862440ea6c','09c583fd-71e3-47b3-ac99-435321ec7f4f','5c1860ce-7966-44ea-ab88-4c6d133adebf','79802096-5a14-4413-ae2a-0e28acb39904','4e6f4360-4014-4156-acd6-6b133bbce7d9','ab35cb84-ce8c-4005-ac98-d8eae4c7c5e9','62d8ad39-4240-4e91-8582-c6fb0af77236','0457f633-bbfa-4cd3-bff2-8f013193488f')
    and activeflag=1;

update teammemberassignment
    set activeflag = 0,
    updatedby = 'CDM-43503', 
    updatedon = now()
    where securityusersid in('6c610d8a-7ddb-48b6-85ea-944f80ceb7e2','3de3d6b0-677b-4a87-ac7f-0796b2daf7f0','87940a8f-4718-435e-b938-96825302c923','e1ad8939-3ea6-4f52-aa1a-0b862440ea6c','09c583fd-71e3-47b3-ac99-435321ec7f4f','5c1860ce-7966-44ea-ab88-4c6d133adebf','79802096-5a14-4413-ae2a-0e28acb39904','4e6f4360-4014-4156-acd6-6b133bbce7d9','ab35cb84-ce8c-4005-ac98-d8eae4c7c5e9','62d8ad39-4240-4e91-8582-c6fb0af77236','0457f633-bbfa-4cd3-bff2-8f013193488f')
    and activeflag=1;

update securityusers
    set activeflag = 0,
    updatedby = 'CDM-43503', 
    updatedon = now()
    where securityusersid in('6c610d8a-7ddb-48b6-85ea-944f80ceb7e2','3de3d6b0-677b-4a87-ac7f-0796b2daf7f0','87940a8f-4718-435e-b938-96825302c923','e1ad8939-3ea6-4f52-aa1a-0b862440ea6c','09c583fd-71e3-47b3-ac99-435321ec7f4f','5c1860ce-7966-44ea-ab88-4c6d133adebf','79802096-5a14-4413-ae2a-0e28acb39904','4e6f4360-4014-4156-acd6-6b133bbce7d9','ab35cb84-ce8c-4005-ac98-d8eae4c7c5e9','62d8ad39-4240-4e91-8582-c6fb0af77236','0457f633-bbfa-4cd3-bff2-8f013193488f')
    and activeflag=1;

update teammember
    set activeflag = 0,
    updatedby = 'CDM-43503', 
    updatedon = now()
    where teammemberid in('b702b2f3-6a68-48f6-a1d5-fdd805a317ff','6a592706-60ed-452d-a38a-5c47aff51596','84260a3e-2171-4ea0-b930-95fe6480e105','b5722155-2bbf-4ccb-9fd8-0a6fe23bf07d','6aa74011-ec15-4b65-8989-4d8a90cbc5b6','ebf2f336-301e-4c61-b7c3-cf8d6e877f2c','def8dded-3e50-4b8a-b789-2aedbdf107ae','8d4eddd8-5584-4112-bd9b-68ff31640ebd','fc26900b-cd76-4353-90e0-c029d58b98f8','a789bd01-3314-471f-bb35-6bb98c079da2','f6ce0cf6-8e5f-4d96-b033-5e12f03965b8')
    and activeflag=1;



