update intakeservicerequest
set activeflag =0, updatedon =now(), updatedby ='CDM-6870'
where intakeserviceid ='19977a1a-da82-4617-bf41-d76af7a902e8';

update intakedastatus
set activeflag =0, updatedon =now(), updatedby ='CDM-6870'
where intakenumber ='CW2189241';

update intakeservicerequestactor
set activeflag =0, updatedon =now(), updatedby ='CDM-6870'
where intakeserviceid ='19977a1a-da82-4617-bf41-d76af7a902e8';