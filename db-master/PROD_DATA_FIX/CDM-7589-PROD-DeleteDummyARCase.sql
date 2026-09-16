update intakeservicerequest 
set activeflag =0, updatedon =now(), updatedby ='CDM-7589'
where intakeserviceid ='d8853515-5add-4be6-8b35-59232d69ba6e';

update intakeservicerequestactor 
set activeflag =0, updatedon =now(), updatedby ='CDM-7589'
where intakeserviceid ='d8853515-5add-4be6-8b35-59232d69ba6e';