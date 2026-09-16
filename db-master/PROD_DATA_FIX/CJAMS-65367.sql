/*
   Issue Description: CJAMS-65367
   Category/ Module  : Child Welfare
   Root cause: user wants remove the CPS-AR,  from Cjams
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Need to do data fix
*/ 



UPDATE intakeservicerequest  
SET  actiontype = null, intakeservicerequestclassid = '00000000-0000-0000-0000-000000000000', activeflag = 0, 
updatedby = 'CJAMS-65367', updatedon = now() 
WHERE servicerequestnumber = '261023619968' AND intakeserviceid = '62c08c78-2bfe-42ac-87b3-f8e7cd9cb913' AND activeflag = 1;

UPDATE personprogramarea
SET activeflag = 0, updatedon = now(), updatedby = 'CJAMS-65367'
WHERE objectid = '62c08c78-2bfe-42ac-87b3-f8e7cd9cb913' AND activeflag =1;

update caseassignment
set activeflag = 0, updatedby = 'CJAMS-65367', updatedon = now() 
where objectid = '62c08c78-2bfe-42ac-87b3-f8e7cd9cb913';

update routing
set activeflag = 0, updatedby = 'CJAMS-65367', updatedon = now() 
where objectid = '62c08c78-2bfe-42ac-87b3-f8e7cd9cb913' and activeflag = 1;