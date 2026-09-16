/*  Issue Description:CJAMS-62929-service case
  Root cause: User accidentally connected the CPS IR# 251023147208 with a new service case # 251030581986. The CPS IR should connected to case number 3178890.
  Fix provided : Data fix is done to Disconnect the CPS IR# 251023147208 with a new service case # 251030581986.
  and Delete the service case # 251030581986 and Connect the CPS IR# 251023147208 with case number 3178890
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date:  
   Backup before update/ delete:
*/



update     intakeservicerequest 
set        servicecaseid = NULL , updatedby = 'CJAMS-62929', updatedon = now()
WHERE     servicerequestnumber = '251023147208' and activeflag = 1;

update servicecase 
set activeflag =0, 
    updatedby = 'CJAMS-62929', 
    updatedon = now() 
where 
    servicecaseid = '9e737c07-e8a6-4c53-b3d1-0571d0db8553';

update caseassignment 
set activeflag = 0, 
    updatedby = 'CJAMS-62929', 
    updatedon = now() 
where 
    objectid = '9e737c07-e8a6-4c53-b3d1-0571d0db8553' and activeflag = 1 ;

update servicecasedisposition 
set activeflag = 0, 
    updatedby = 'CJAMS-62929', 
    updatedon = now() 
where 
    servicecaseid = '9e737c07-e8a6-4c53-b3d1-0571d0db8553';
 
  
update routing 
set activeflag = 0, 
    updatedby = 'CJAMS-62929', 
    updatedon = now() 
where 
    objectid = '9e737c07-e8a6-4c53-b3d1-0571d0db8553' 
    and activeflag = 1;
    
   
update actor 
set activeflag = 0, 
    updatedby = 'CJAMS-62929', 
    updatedon = now() 
    where 
        servicecaseid = '9e737c07-e8a6-4c53-b3d1-0571d0db8553' 
        and activeflag = 1;
    
update intakeservicerequestactor 
set activeflag = 0, 
    updatedby = 'CJAMS-62929', 
    updatedon = now() 
where 
    servicecaseid = '9e737c07-e8a6-4c53-b3d1-0571d0db8553' 
    and activeflag = 1;
    
select * from createservicecase('6c17501e-7b3c-48c3-bf4c-15535a567297', 'abf54bf0-5d3a-403a-8954-f2044f7901f2',0,'a559b92f-9553-41ea-bc3c-37d1ab92f872',null,'intake','IHM',null);
