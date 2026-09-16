/*
   Issue Description: CDM-36066
   Category/ Module  : Decision
   Root cause: Routing record inactive and un nessary dispostion records inserted.
   Fix Provided: code fix done and did data fix also as part of this one 
*/


update cjams.routing set activeflag =1 , updatedon = now(), updatedby ='CDM-36066'
where routingid ='7d8642d7-b02f-4e6a-841b-106040f8d2ec';

update cjams.intakeservicerequestdispositioncode set activeflag =0, updatedon = now(), updatedby ='CDM-36066'
where intakeservicerequestdispositioncodeid in('d1ad8c95-ee87-40b1-a920-ed84d9793f62','87e69bef-f3bd-450e-bdd8-5dadd43eb2c3');