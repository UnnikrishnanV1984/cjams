/*
   Issue Description: CDM-21927
   Category/ Module  :  Approved records in pending tab
   Root cause: user wants to delete the records
   Pull request# for code fix: 5309
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update routing set activeflag = 0, updatedon = now(), updatedby = 'CDM-21927' 
where routingid = 'b71fc279-0678-4d0b-bfc0-1855bfcc14ff';
update routing set activeflag = 0, updatedon = now(), updatedby = 'CDM-21927' 
where routingid = '3e543bab-0de6-44c3-b4fd-04ea047a480c';

update routing set activeflag = 0, updatedon = now(), updatedby = 'CDM-21927' 
where routingid = '3512d3a1-042a-4242-88ed-917e02c82a49';
update routing set activeflag = 0, updatedon = now(), updatedby = 'CDM-21927' 
where routingid = '9b2e67b1-40a3-45b2-9c8a-77f88cee976f';


update routing set activeflag = 0, updatedon = now(), updatedby = 'CDM-21927' 
where routingid = '7d20d1e0-92b1-46c9-86a0-b72835dfe4f6';
update routing set activeflag = 0, updatedon = now(), updatedby = 'CDM-21927' 
where routingid = '54c36a3b-ddd9-450e-9410-a9249ab6fc4e';
