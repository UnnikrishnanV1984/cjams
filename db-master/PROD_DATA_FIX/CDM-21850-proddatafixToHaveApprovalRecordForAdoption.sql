
/*
   Issue Description: CDM-21850
   Category/ Module  : Prod data fix for Adoption Agreement Approval
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update adoptioncaseagreementrevision set approvalstatustypekey = '3047', approvaldate = now(), updatedby = 'CDM-21850', updatedon = now() 
where adoptioncaseagreementrevisionid in ('af3bfc39-a622-4008-b7bb-5a44f844aaea','aa57877e-79af-4911-97d8-88bda7dc6d8c');
