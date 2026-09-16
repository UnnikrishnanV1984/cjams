--D-23408 Approval Dashboard this Case Connect should not show here 
 
UPDATE routing  
SET  activeflag = 0
,updatedby = 'admin-D-23408'
,updatedon = now() 
WHERE  servicerequestnumber = '2020013014522'
and routingid = '33d44d2d-73a3-4c4c-9681-91e988148df5' 
and routingstatustypeid =  15 
and activeflag =1;