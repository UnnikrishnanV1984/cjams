/*
   Issue Description: CDM-30581
   Category/ Module  : remove the service case connected and create a new service
   Root cause:  Still appearing in user's inbox.

   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Data fix: Updating activeflag to 0 in the routing table for the servicerequest
*/


UPDATE intakeservicerequest 
SET servicecaseid = null,
updatedon = now(),
updatedby = 'CDM-30581'
WHERE activeflag = 0 AND servicerequestnumber = '231020508509';


select * from cjams.createservicecase('76e3f315-5207-4a7e-abe9-a76e6b4534e1', null, 1, '251ca32d-4b6f-460e-ab34-0d740c55b6dd', 'intake', '');

update servicecasedisposition set activeflag = 0, updatedon = now(),
updatedby = 'CDM-30581' where servicecasedispositionid = '549e0fa5-e3ad-4db3-87b7-afa6043569a4';
