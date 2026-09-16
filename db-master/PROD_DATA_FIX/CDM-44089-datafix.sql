/*
   Issue Description: CDM-44089
   Category/ Module  : Pending Approval
   Root cause: user requeseted to remove pending approvals. 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update routing set activeflag =0, updatedby ='CDM-44089', updatedon =now()
where routingid in ('f9a5eb1f-db45-404d-a475-14d39c46c66b' ,'c14f5d9c-68e2-47c9-ba84-f3a92d845dd7') and activeflag=1;