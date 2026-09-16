update intakeservicerequest 
set activeflag =0, updatedon =now(), updatedby ='CDM-4909'
where intakeserviceid ='7d480987-2319-430f-83f0-5a9bddac3ee1';

update intakeservicerequestactor
set activeflag =0, updatedon =now(), updatedby ='CDM-4909'
where intakeserviceid ='7d480987-2319-430f-83f0-5a9bddac3ee1';