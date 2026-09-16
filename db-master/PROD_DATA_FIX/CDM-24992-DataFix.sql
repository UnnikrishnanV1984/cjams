
/*
   Issue Description: CDM-24992
   Category/ Module  : Child Removal
   Root cause: User requested to remove draft child removal 
   Pull request# for code fix: 
   Reason why no related code fix: 
*/
/*
select personid from person where cjamspid = 200948678;

select intakeservreqchildremovalid from intakeservreqchildremoval where 
personid = 'b91a1ae6-dbff-4f0e-8977-4fd7298db3f1';

-- No Records in placement and routing table
select * from placement where 
intakeservreqchildremovalid = 'adcd7b6d-4ac8-40c7-866d-6fcd0a7781e8';

select * from routing where objectid = 'adcd7b6d-4ac8-40c7-866d-6fcd0a7781e8';
*/
update cjams.intakeservreqchildremoval set 
activeflag=0, updatedby='CDM-24992', updatedon=now()
where intakeservreqchildremovalid='adcd7b6d-4ac8-40c7-866d-6fcd0a7781e8'
and activeflag!=0;