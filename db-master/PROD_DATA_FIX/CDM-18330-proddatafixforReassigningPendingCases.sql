
/*
   Issue Description: CDM-18330
   Category/ Module  : Reassigning Pending Approval Cases
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


-- c2bd800d-5bc0-4bf1-bd7c-18d231fd0710
update routing set tosecurityusersid = 'dcc31ede-4dc7-446b-bc6d-fda4d8755cc2', updatedby = 'CDM-18330', updatedon = now() where 
tosecurityusersid = 'c2bd800d-5bc0-4bf1-bd7c-18d231fd0710' and activeflag =1 and routingstatustypeid = 15;
--routingid in ('c0d9db16-e32e-4db9-a20c-997d558e40e0','40620663-08c7-40c4-ad1f-bbd747a4f833');