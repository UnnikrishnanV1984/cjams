/*
   Issue Description: CDM-30755
   Category/ Module  :placement 
   Root cause:  
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Data fix: Updating activeflag to 0 in the routing table for the servicerequest
*/

update personeducation 
set bestdetermination=
'{
   "bestDeterminationList":[
      {
         "placementid":"4359fbb0-255f-4d8f-81ac-d6efa6f26409",
         "determinationvalue":0,
         "placementdate":"04/01/2023",
         "updatedon":"04/20/2023 09:34:48 AM",
         "updatedby":"Janet Reyes"
      }
   ]
}'::json 
 where personeducationid = '2115a8e4-c52e-4a84-91a4-1773e89379e4';