/*
   Issue Description: CDM-18626
   Category/ Module  : Pending approval
   Root cause: user wants to remove pending approvals.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update routing set activeflag =0, updatedby = 'CDM-18626', updatedon = now() where routingid = '99f5a606-fc8d-4a87-92f3-c3dc8e3d3857';

update routing set activeflag =0, updatedby = 'CDM-18626', updatedon = now() where routingid = '6e1a4962-345e-4cab-9a22-fb9ff5d7c7f1';

update routing set activeflag =0, updatedby = 'CDM-18626', updatedon = now() where routingid = '71fd88dc-be9c-404c-a1a5-fee94784f65f';
