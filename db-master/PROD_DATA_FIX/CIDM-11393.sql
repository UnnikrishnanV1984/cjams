/*
   Issue Description: CIDM-11393 -
   Category/ Module  :  241022041347 - Inactivate the older case closure record
   Root cause:Requested to remove the duplicate closure record since we have inserted through datafix and user has also added a closure record due to which a duplicate record is appearing
   Fix provided: Data fix has been done to remove the older closure record from decision tab
   Is code fix required: N 
   Status of the code fix if already submitted and expected prod fix date: 

*/


update intakeservicerequestdispositioncode set  activeflag =0,
updatedby ='CIDM-11393',updatedon =now()
where intakeservicerequestdispositioncodeid ='4f8ce938-7085-4492-9568-ccb1cd810a63' and activeflag =1;


update routing 
set activeflag =0,updatedby ='CIDM-11393',updatedon =now()
where routingid ='f9fe9eb7-16de-4a04-9635-b59d86f5437a' and activeflag =1;