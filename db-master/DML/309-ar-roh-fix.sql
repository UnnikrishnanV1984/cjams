UPDATE intakeservicerequest  
SET   
    actiontype = null, intakeservicerequestclassid = '00000000-0000-0000-0000-000000000000', activeflag = 0, 
    updatedby = 'admin-D-23407', updatedon = now() 
WHERE 
    servicerequestnumber = '20190323013820'
AND intakeserviceid = '889eb056-336a-4fee-940b-5a35fb3c6196' 
AND activeflag = 1;