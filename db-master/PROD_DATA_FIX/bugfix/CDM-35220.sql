/*
   Issue Description: CDM-35220
   Category/ Module  : Child Welfare
   Root cause: user wants remove the CPS-AR, and Intake cases from Cjams
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Need to do data fix
*/ 
-- Remove the Intake# I231011388393 from CJAMS		

update cjams.intakedastaging 
set activeflag = 0, updatedby = 'CDM-35220', updatedon = now() 
where intakenumber in ('I231011388393') and activeflag=1;

update cjams.intakedastatus 
set activeflag =0, updatedby = 'CDM-35220', updatedon = now() 
where intakenumber in ('I231011388393') and activeflag=1;


-- Remove the CPS AR Case # 231021272879 from CJAMS

UPDATE intakeservicerequest  
SET  actiontype = null, intakeservicerequestclassid = '00000000-0000-0000-0000-000000000000', activeflag = 0, 
updatedby = 'CDM-35220', updatedon = now() 
WHERE servicerequestnumber = '231021272879' AND intakeserviceid = '229d7ddc-a4e5-48e1-8588-e66de159916e' AND activeflag = 1;

UPDATE personprogramarea
SET activeflag = 0, updatedon = now(), updatedby = 'CDM-35220'
WHERE objectid = '229d7ddc-a4e5-48e1-8588-e66de159916e' AND activeflag =1;

update caseassignment
set activeflag = 0, updatedby = 'CDM-35220', updatedon = now() 
where objectid = '229d7ddc-a4e5-48e1-8588-e66de159916e';

update routing
set activeflag = 0, updatedby = 'CDM-35220', updatedon = now() 
where objectid = '229d7ddc-a4e5-48e1-8588-e66de159916e' and activeflag = 1;