/*
   Issue Description: CDM-22664
   Category/ Module  : contact notes
   Root cause: user wants add all missing clients
   Pull request# for code fix: 5790
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed. Need to do data fix
*/

UPDATE progressnote  
SET entitytypeid  = 'a61bd6c0-f1d7-429d-b3b6-8bdddf5dd06c', updatedby = 'CDM-22664', updatedon = now()
where entitytypeid  = 'c6761e3e-2372-47e5-b069-ac7eabbd9b43'
and contactdate::date >= '2021-11-12'::date;


update assessment set objectid = 'a61bd6c0-f1d7-429d-b3b6-8bdddf5dd06c',
servicecaseid = 'a61bd6c0-f1d7-429d-b3b6-8bdddf5dd06c',
updatedby = 'CDM-22664', updatedon = now(), objectname = 'servicecase'
where assessmentid in ('a2540160-8373-4680-b5ae-192783d55f11','0129d598-6767-42fc-8561-2f5ee5b5102c') 
and objectid = 'c6761e3e-2372-47e5-b069-ac7eabbd9b43';

UPDATE serviceplan  
SET objectid  = 'a61bd6c0-f1d7-429d-b3b6-8bdddf5dd06c', updatedby = 'CDM-22664', updatedon = now()
where serviceplanid in ('4819481e-89d3-4189-b5b0-453d9fb7d5de', 'ccdb41e6-cddd-4c06-8e2e-9759303f4fbe');