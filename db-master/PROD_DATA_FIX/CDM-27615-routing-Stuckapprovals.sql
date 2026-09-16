--CDM-27615-Stuck approvals
/*
File Name: CDM-27615-routing-Stuckapprovals
-- Issue Description: 
   case - 3229728 stuck with nothing to approve. Need to be removed from approvals.
   CLient Email ID :theresa.kleppinger@maryland.gov

-- Resolution: Updated the activeflag to zero in the routing table

-- Category/ Module: Case Management
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/


update
	routing
set
	activeflag = 0 ,
	updatedby = 'CDM-27615',
	updatedon = now()
where
	routingid in ('4d686ebe-0f89-4181-a0d2-18337f130254')
	and activeflag = 1;
