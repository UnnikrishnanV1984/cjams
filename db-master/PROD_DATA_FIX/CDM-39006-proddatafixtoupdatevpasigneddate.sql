/*
   Issue Description: CDM-39006
   Category/ Module  : Prod data fix to update removal VPA Sign date
   Root cause: user error
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/



update intakeservreqchildremoval set vpaparentssigneddate  = '2024-03-06', parent2signeddate = '2024-03-06', agencysigneddate = '2024-03-06 00:00:00.000',parent1id = '201079051', parent2id = '1032483', updatedby = 'CDM-39006' , updatedon = now()
where intakeservreqchildremovalid = '7d63b76e-5e47-455d-97d9-bb9ad43e5826';
