/*
   Issue Description: CDM-18681
   Category/ Module  : case connect
   Root cause: user wants to connect case to intake and remove service case
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update intakeservicerequest set activeflag=0, updatedby='CDM-16594',updatedon=now() where servicerequestnumber in ('211020134374') and
intakeserviceid in ('a955a752-bc2e-419a-8077-bee6182cc66b');

--new servicecase - 211030012514
   select * from cjams.createservicecase('a955a752-bc2e-419a-8077-bee6182cc66b', null, 1,'d2c20361-572e-464c-82e3-a190535b702b', 'intake' );