/*
   Issue Description: CDM-28790
   Category/ Module  : Permanency Plan for Chase Trueman
   Root cause: 3307322:CJAMS will not allow me to create a Permanency Plan for Chase Trueman. It keeps listing his permanency plan under the other two children in the case.
   Pull request# for code fix: It's a data fix
   Reason why no related code fix:  
   
*/


-- 4486385 ROBERT    TRUEMAN
update placement set personid  ='9b194811-034c-4570-816d-2da43d4e4345',  updatedby ='CDM-28790', updatedon = now()
where alternateid  = 1565994;

-- 4486380    CARTER    TRUEMAN
update placement set personid  ='9722db42-f722-45cc-8acf-2d9bfd69975e',     updatedby ='CDM-28790', updatedon = now() 
where alternateid  = 1565993;