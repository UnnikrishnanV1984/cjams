update cjams.assessment
set updatedby = '3dbbca9f-7f35-4e26-b361-c262045be88c' 
where assessmentid = '97d9cba3-c8bc-409f-9b81-76566564b97e';


update cjams.routing
set activeflag = 0
where routingid = '348da5f9-0b8b-4fef-806c-c7e0beb4af28';

update cjams.routing
set activeflag = 1, updatedby = '3dbbca9f-7f35-4e26-b361-c262045be88c' 
where routingid = '37191410-e01d-40c3-b446-274a61d1ac47';


