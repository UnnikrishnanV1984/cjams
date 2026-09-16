update intakeservicerequest 
set actiontype = 'IR', 
    intakeservicerequestclassid = '3e026a57-247c-4203-82b7-62749c98ccc5', 
    updatedon = now(),
    updatedby = 'CDM-13851' 
where intakeserviceid = 'da284850-06b2-4d4b-a4f9-43bb2da84bdb';

update intakeservicerequestsdm 
set isir = true, 
    updatedon = now(),
    updatedby = 'CDM-13851' 
where intakeserviceid = 'da284850-06b2-4d4b-a4f9-43bb2da84bdb';