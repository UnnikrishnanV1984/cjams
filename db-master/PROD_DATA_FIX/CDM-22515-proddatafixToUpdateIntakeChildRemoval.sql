/*
   Issue Description: CDM-22515
   Category/ Module  : Prod data fix to update removal info
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/



--2021-12-06 09:30:20.000
update intakeservreqchildremoval set exitdate = null , updatedby = 'CDM-22515', updatedon = now()  where intakeservreqchildremovalid = '18dcc4f8-6c70-4510-bff1-d58f38693a2b' and activeflag = 1;
update intakeservreqchildremoval set activeflag = 0, updatedby = 'CDM-22515', updatedon = now() where intakeservreqchildremovalid = '46a202ff-b28e-4c17-9006-fbc04b80e6c2' and activeflag = 1;


update personprogramarea set activeflag = 0, updatedon = now(), updatedby = 'CDM-22515'
where personprogramid  ='588df621-af77-4b18-a4f8-bab23df09b42';
----2021-12-06 09:30:20.000
update personprogramarea set enddate  = null, updatedon = now(), updatedby = 'CDM-22515'
where personprogramid  ='2669a32d-9037-466d-9e27-986e5dc29fea';
