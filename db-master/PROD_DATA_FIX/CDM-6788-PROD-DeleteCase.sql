update intakeservicerequest
set activeflag =0, updatedon =now(), updatedby ='CDM-6788'
where intakeserviceid ='c14a00a3-c704-4d67-be9c-0b98856ee8e3';

update intakedastatus
set activeflag =0, updatedon =now(), updatedby ='CDM-6870'
where intakenumber ='CW2172791';

update intakeservicerequestactor
set activeflag =0, updatedon =now(), updatedby ='CDM-6788'
where intakeserviceid ='c14a00a3-c704-4d67-be9c-0b98856ee8e3';