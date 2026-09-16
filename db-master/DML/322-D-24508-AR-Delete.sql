UPDATE intakeservicerequest  
SET   
    actiontype = null, intakeservicerequestclassid = '00000000-0000-0000-0000-000000000000', activeflag = 0, 
    updatedby = 'admin-D-24508', updatedon = now() 
WHERE 
    servicerequestnumber = '20190324013826'
AND intakeserviceid = '294cca35-09ec-424d-9dfb-640b3c496848' 
AND activeflag = 1;