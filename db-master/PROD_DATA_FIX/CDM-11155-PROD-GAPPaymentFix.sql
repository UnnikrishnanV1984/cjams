update intakeservicerequestactor i 
set activeflag =1, updatedon =now(), updatedby ='CDM-11155'
where intakeservicerequestactorid ='50fec628-2571-421c-835e-d39c30c60f07';

update gapratesrevision 
set approvaldate =now(), updatedon =now(), updatedby ='CDM-11155'
where gaprateid ='62db3977-9a53-466e-8ecd-6b256857d575';