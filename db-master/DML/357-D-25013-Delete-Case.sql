UPDATE intakeservicerequest  
SET   
    actiontype = null, intakeservicerequestclassid = '00000000-0000-0000-0000-000000000000', activeflag = 0, 
    updatedby = 'admin-D-25013', updatedon = now() 
WHERE 
    servicerequestnumber = '2020036015304'
AND intakeserviceid = '00ba1558-e98d-4605-963f-a616859ccf23' 
AND activeflag = 1;

UPDATE personprogramarea
SET activeflag = 0,
updatedon = now(),
updatedby = 'admin-D-25013'
where objectid = '00ba1558-e98d-4605-963f-a616859ccf23' and activeflag =1;