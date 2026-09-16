
/*
   Issue Description: CDM-32956
   Category/ Module  : Assignment
   Root cause: Objectkey was wrong while insertion 
   Fix Provided: Did data fix to update the correct objecttypekey 

*/

update cjams.caseassignment set objecttypekey ='adoptioncase', updatedby ='CDM-32956', updatedon = now()
where caseassignmentid ='9a0fed4e-bab0-4918-9ca6-57f6fd7b3e3c';


--Feby Requested to fix reaming cases for that user also as part of this defect 

--3037342
update cjams.caseassignment set objecttypekey ='adoptioncase', updatedby ='CDM-32956', updatedon = now()
where caseassignmentid in('6565de6f-7d09-460c-8ec4-70ff9f48bbb4','8cd80c75-4fef-4168-9c1e-a0720979d793','4416177f-b396-4a2b-8841-d2af094fe42f');

--3191266
update cjams.caseassignment set objecttypekey ='adoptioncase', updatedby ='CDM-32956', updatedon = now()
where caseassignmentid in('5298fb79-5604-4f80-8f22-65d7c0a6b903','fdc81d75-5814-4130-bdd3-83e19012161b','68f3689e-8a85-4ba0-a134-d92d0a5aed06');


--3205379
update cjams.caseassignment set objecttypekey ='adoptioncase', updatedby ='CDM-32956', updatedon = now()
where caseassignmentid in('66bc86df-b77c-4b42-85b6-d60dccdffa6d','d618bfda-b282-46da-b01c-167144d74315','66e28914-9017-44d1-85b3-e37e959b7cf2');


--3229043
update cjams.caseassignment set objecttypekey ='adoptioncase', updatedby ='CDM-32956', updatedon = now()
where caseassignmentid in('cc97ef83-143b-43ab-9027-26a9234dd887','c1bc2f5f-beae-4082-ba23-4853d3fc85ad','afcd6f2b-c0cb-4a28-94de-53698ef5d190');


--3229045
update cjams.caseassignment set objecttypekey ='adoptioncase', updatedby ='CDM-32956', updatedon = now()
where caseassignmentid in('29ea5a0f-ac55-420e-99c4-0a8cfe1df2e1','56e5057b-49d1-440b-b142-f92a9aab7632','8146b5c0-e967-4147-8057-ce81b3b9741d');

--3257994
update cjams.caseassignment set objecttypekey ='adoptioncase', updatedby ='CDM-32956', updatedon = now()
where caseassignmentid in('66a5ea91-9776-4e98-aa46-c15d6bc051b8','c95f1637-c6be-43ad-a064-ca8dba50c399','f770464e-91ab-4a6c-8397-994062704692');


--3270838
update cjams.caseassignment set objecttypekey ='adoptioncase', updatedby ='CDM-32956', updatedon = now()
where caseassignmentid in('f0e31ef6-20aa-43b3-a75e-ba5c30bdf1df','9287faf2-61a2-431c-817f-3ddafd136ab6','10f1dd85-5392-4ee5-9c7f-8ebac0caa0f3');
