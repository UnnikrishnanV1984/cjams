/*
  Issue Description: CDM-32768- Missing service case
  Root cause: Service case is not being populated 
  Fix provided: Did datafix to create servicecase 
  clone ticket : CDM-32799
*/


--no need to delete 231020664404  this case becuase this is not searchable now also , whenever we are creating servicecase it will delete this case and do the nessary things
--For this defect user created servicecase but due to some glich it was not hapened 

--select * from intakeservicerequest where servicerequestnumber ='231020664404';
--intakeserviceid ='b8d8d484-1c96-4775-9866-ad4d35ff6eab';


select * from cjams.createservicecase('b8d8d484-1c96-4775-9866-ad4d35ff6eab', null, 1, '846a2ba6-4b62-45db-af56-076ab5d0b400', 'intake', '');