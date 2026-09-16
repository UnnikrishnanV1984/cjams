/*
  Issue Description:  CDM-33623
   Category/ Module  :  Services 
   Root cause: Service plan in pending status but the record not insupervisor approval inbox
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/

update snapshothist set approvalstatus =null,updatedby ='CDM-33623',updatedon = now() where objectid ='613462dc-bff0-4c23-9687-f36e62b6e44d' and approvalstatus ='Pending' and id  ='ab4c4018-bdee-4bc3-b928-97311b1b3d2d';