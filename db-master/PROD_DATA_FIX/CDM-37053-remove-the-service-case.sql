/*
   Issue Description: CDM-37053
   Root cause: The service case # 231030250158 has been removed but it still appear under the pending approval inbox.
   Fix provided: Data fix provided to remove the service case from pending approval inbox.
   Pull request# for code fix: 
   Reason why no related code fix: 
*/

--Backup
select activeflag,objectid,servicerequestnumber,routingid,updatedby,updatedon from routing where servicerequestnumber='231030250158' and activeflag=1;

-- UPDATE cjams.routing
-- SET activeflag=1, objectid='fb649e09-42d0-4179-b270-c98c5cff42f9', servicerequestnumber='231030250158', updatedby='1cf5f5f2-3532-4a79-ba65-ccba0fec3431', updatedon='2024-01-03 14:19:57.098'
-- WHERE routingid='b7176b00-e350-4768-87ac-38e689717899';
-- UPDATE cjams.routing
-- SET activeflag=1, objectid='571a3913-f8cc-484c-8adc-54955d7b4e66', servicerequestnumber='231030250158', updatedby='19043820-05ba-4851-8ee5-3e6a1750d2b2', updatedon='2024-01-03 14:41:05.526'
-- WHERE routingid='e36daa24-78fd-4a25-8f8b-2f9c1d3fa28a';

--Update
update routing set activeflag = 0, updatedon = now(), updatedby = 'CDM-37053' where servicerequestnumber='231030250158' and activeflag=1;