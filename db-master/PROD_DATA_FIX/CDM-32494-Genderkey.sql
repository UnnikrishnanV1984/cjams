/*
   Issue Description: CDM-32494
   Category/ Module  : person 
   Root cause: gendertypekey insertion missing 
   Fix Provided: Did data fix to insert gendertypekey
   Status of the code fix if already submitted and expected prod fix date: 

*/

update cjams.person set gendertypekey ='M', updatedby ='CDM-32494', updatedon = now()
where personid ='ea12a4ee-8db6-400d-8904-52147469d04e';