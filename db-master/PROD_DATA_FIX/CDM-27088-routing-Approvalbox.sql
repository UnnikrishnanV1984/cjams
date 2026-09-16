-- CDM-27088 -Approval box
/*
   File Name: CDM-27088-routing-Approvalbox
-- Issue Description: 
    All these case 221030017802,3256920,3248198,3088733,3281273,3292645,2021010207209,3299702,3188406,221030015626,3289579 have been approved and need to be removed from Approval inbox  
    Customer Email ID:kim.compton@maryland.gov
  
-- Resolution: Updated the Flag to zero in the routing table for the above case numbers.

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
	updatedby = 'CDM-27088',
	updatedon = now()
where
	routingid in ('6157c179-e6e8-42da-8644-52b5bffa4cf1',
	'2dcbb0b4-8e6c-4ea7-b128-2e6c0459f668',
	'f7bd999e-1caf-4484-a478-73706773204a',
	'7cf807dd-6801-454f-901e-3d51130ce647',
	'cb8e735a-345d-4ca4-9b94-d919343a384b',
	'43dec0c0-faff-4467-834f-464a8cb624ab',
	'628406aa-4922-4921-8ddc-3fe5b677e3ac',
	'156d1ab6-a1ef-4e89-8254-1b3870bd4510',
	'aef7baed-b977-4651-8118-9bd4b3187729',
	'055f9f6d-6b01-494e-921c-43a8748e3f0a',
	'd8d39220-7065-4761-8327-ebdec3adf48d',
	'57b26c2e-dbbd-4821-af22-9e17914a6813')
	and activeflag = 1;