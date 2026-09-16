
/*
-- Issue Description: 
   User request to Remove duplicated Investigation findings
-- Category/ Module: Inverstigation Finding  (Case Management) 
-- Root cause: User error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/


update investigationallegation set activeflag = 0, updatedby = 'CDM-19280', updatedon= now() where investigationallegationid in ('5acc967f-b847-4dc8-a266-e16a557f96cf',
'c91f5492-e306-4e18-afa8-d7f5825b21f3','945e09b0-5723-4915-a196-fc86e8de7ef2','79d4f803-d04e-4112-b79b-b6a7a1c837a2'
,'8ae2cdd4-8333-45fb-a6ff-6e6d027f9c23','48e09a37-c388-470e-8515-c264751ebad2',
'd638808f-ef80-4208-a75a-1c1b19d2eb75','ce1ea67e-3d4e-4f87-a678-f2d8391e66c4'
);