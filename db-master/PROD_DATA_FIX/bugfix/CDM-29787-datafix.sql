/*
   Issue Description: CDM-28797
   Category/ Module  : Investigation Maltreatment 
   Root cause: As requested by user
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update Investigationmaltreatment 
set activeflag = 0, updatedby ='CDM-29787', updatedon = now()
where maltreatmentid in ('2f3e2302-10ac-4a7f-91a2-0b6c4c2043f8','fe30784d-fb88-4efe-9ffc-e6c7063540dc');

update Investigationallegation
set activeflag = 0, updatedby ='CDM-29787', updatedon = now()
where maltreatmentid in ('2f3e2302-10ac-4a7f-91a2-0b6c4c2043f8','fe30784d-fb88-4efe-9ffc-e6c7063540dc');


