
/*
   Issue Description:CDM-16550
   Category/ Module  : Person 
   Root cause:  Duplicates beacuase of removals 
   Reason why no related code fix: web fix already raised 
*/



update cjams.personprogramarea set startdate ='2020-09-11 00:00:00',updatedby ='CDM-16550', updatedon =now()

where personprogramid ='6cd04d20-7d03-4dde-b7d6-69f69a12acd3';


update cjams.personprogramarea set activeflag =0,updatedby ='CDM-16550', updatedon =now()

where personprogramid ='94259457-b605-431a-bbed-a5058ee8d096';



update cjams.personprogramarea set startdate ='2020-09-11 00:00:00',updatedby ='CDM-16550', updatedon =now()

where personprogramid ='013fd5f4-503b-4af8-9d9a-04155c7310a6';


update cjams.personprogramarea set activeflag =0,updatedby ='CDM-16550', updatedon =now()

where personprogramid ='bc624188-2ba8-44f0-88cf-5984c5a540cc';


update cjams.personprogramarea set startdate ='2020-09-11 00:00:00',updatedby ='CDM-16550', updatedon =now()

where personprogramid ='d0605848-c407-4510-8bd4-73b22d5cab96';


update cjams.personprogramarea set activeflag =0,updatedby ='CDM-16550', updatedon =now()

where personprogramid ='5529d5de-58d6-41bf-800f-235266d53442';