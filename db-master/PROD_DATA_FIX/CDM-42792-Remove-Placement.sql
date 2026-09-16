/*

   Issue Description: CDM-42792-Delete rejected placement

   Category/ Module  : Person

   Root cause: Requested to remove Rejected placement

   Fix provided :Datafix to delete rejected placement

   Code fix ticket#:

   Reason why no related code fix: 

   Status of the code fix if already submitted and expected prod fix date: 

   Backup before update/ delete:

*/

update placement set activeflag = 0, updatedon = now(), updatedby = 'CDM-42792' where placementid= 'cc47cc9b-d07f-44be-9ce7-0e2888716175';

update placementrevision set  activeflag = 0, updatedon = now(), updatedby = 'CDM-42792' where placementid= 'cc47cc9b-d07f-44be-9ce7-0e2888716175';

update livingarrangement set  activeflag = 0, updatedon = now(), updatedby = 'CDM-42792' where placementid ='cc47cc9b-d07f-44be-9ce7-0e2888716175';

update routing  set  activeflag = 0, updatedon = now(), updatedby = 'CDM-42792' where objectid= 'cc47cc9b-d07f-44be-9ce7-0e2888716175' and activeflag =1;