/*
   Issue Description: CDM-27754
   Category/ Module  : Prod data fix to Remove Pending GAP Agreement Rate
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update gapagreementrate set activeflag = 0 , updatedby = 'CDM-27754', updatedon = now()
where gapagreementrateid = 'c6796dc5-1edb-4e3e-9dfc-93b5c62d3f53' and activeflag = 1;


update gapratesrevision set activeflag = 0 , updatedby = 'CDM-27754', updatedon = now()
where gaprateid = 'c6796dc5-1edb-4e3e-9dfc-93b5c62d3f53' and activeflag = 1;

update routing set activeflag = 0, updatedby = 'CDM-27754', updatedon = now()
where routingid = '2736b0de-b0d0-4659-85e6-5c6880c74365' and activeflag = 1;