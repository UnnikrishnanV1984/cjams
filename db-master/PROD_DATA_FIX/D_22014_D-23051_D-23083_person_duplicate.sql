--D-22014 2 people listed pid 10045695 and 1241498 . 10045695 is inactivated
update person set activeflag = 0, updatedon= now() where personid = '72711126-6c0f-45bb-baa2-8d6fb9cca390' ;
update intakeservicerequestactor set personid = 'ada3194c-412a-49b0-8175-ac851e53dba6', updatedon = now()
where personid in ( '72711126-6c0f-45bb-baa2-8d6fb9cca390') ;

--D-23051 - D-23083 Duplicate person 1275725, 8939208, 10285264

update person set activeflag = 0, updatedon= now() where personid = '1f4f5250-4b8d-4e70-9200-bdbfa9ec1577' ;
update intakeservicerequestactor set personid = 'ddc9498e-7a86-4d16-92a9-52e2800ba666', updatedon = now()
where personid in ( '1f4f5250-4b8d-4e70-9200-bdbfa9ec1577') ;

update person set activeflag = 0, updatedon= now() where personid = 'd3526e30-ab62-46b3-b819-a25a4af7a9c9' ;
update intakeservicerequestactor set personid = 'ddc9498e-7a86-4d16-92a9-52e2800ba666', updatedon = now()
where personid in ( 'd3526e30-ab62-46b3-b819-a25a4af7a9c9') ;

update personidentifier set personidentifiervalue='MDT-130811688', updatedon=now() 
where personidentifiertypekey='MDM_ID' and personid = 'ddc9498e-7a86-4d16-92a9-52e2800ba666';

