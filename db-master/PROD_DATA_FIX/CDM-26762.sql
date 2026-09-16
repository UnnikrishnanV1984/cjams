update intakeservicerequest 
set actiontype = 'IR', 
    intakeservicerequestclassid = '3e026a57-247c-4203-82b7-62749c98ccc5', 
    updatedon = now(),
    updatedby = 'CDM-26762' 
where intakeserviceid = '434963d9-3951-4a4e-8832-f10b9e36ecc9';

update intakeservicerequestsdm 
set isir = true, 
    updatedon = now(),
    updatedby = 'CDM-26762' 
where intakeserviceid = '434963d9-3951-4a4e-8832-f10b9e36ecc9';