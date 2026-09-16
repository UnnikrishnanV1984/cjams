update permanencyplan
set intakeservicerequestactorid ='39015f90-7410-4177-a237-d05891324883', updatedon =now(), updatedby ='CDM-7627'
where permanencyplanid ='a243110c-0471-45ec-a645-4e77924b3a48';

update routing 
set activeflag =0, updatedon =now(), updatedby ='CDM-7627'
where routingid ='7016a2ad-fa72-4160-b66a-5b09c44df687';