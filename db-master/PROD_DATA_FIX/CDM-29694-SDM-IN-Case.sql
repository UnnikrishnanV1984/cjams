/*
   Issue Description: CDM-29694
   Category/ Module  : intake sdm
   Root cause: user already added this kid SDM in other case and removed
   Pull request# for code fix: 8642
   Reason why no related code fix: data fix
   
*/
update intakeservicerequestsdm
set drugexposednewbornflag = '1', updatedby = 'CDM-29694',
updatedon =now() 
where intakeserviceid = '991d1831-6c75-43a9-9e0b-3e426d804d3d';