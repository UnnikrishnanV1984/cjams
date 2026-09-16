/* 
 Issue Description: CDM-26317
 Case # 221020253190 is completed on 11/03/2022, So there should not be any disposition request in 
 the pending approval inbox. I can see the disposition request in supervisor's approval inbox also.
 Also in decision tab, there is one disposition request in review status that needs to be removed.
 Category/ Module  : Duplicate Entry
 Customer Email ID: shaina.boyd1@maryland.gov
 Root cause: Data fix to remove disposition request in review status & disposition request in 
 the pending approval inbox.
 Reason why no related code fix: 
 Status of the code fix if already submitted and expected prod fix date: Need to do data fix
*/


update intakeservicerequestdispositioncode
set activeflag = 0, updatedby = 'CDM-26317', updatedon = now()
where intakeservicerequestdispositioncodeid = 'ca1b1890-4062-455b-8015-e2bca6b5b689';

update routing set activeflag = 0, updatedon = now(), updatedby = 'CDM-26317' 
where objectid = 'ca1b1890-4062-455b-8015-e2bca6b5b689';