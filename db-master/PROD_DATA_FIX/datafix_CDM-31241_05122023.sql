-- CDM-31241 - Bug/Payments
/*
-- Issue Description: 
   Caroline County User Patricia Linder is not a option when selecting a supervisor for service log approval
	
-- Usre ID: Patricia Linder - f4cb516d-5e0c-4515-823b-fcfe1d6687b8
	
-- Category/ Module: Placement (Case Management) 
-- Root cause: User setup issue, Patricia Linder is having a wrong roletypekey in teammember table (LDSSSP)
-- Fix Provided: Datafix has been promoted to update the user roletypekey as CWSP (Supervisor,CW)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Patricia Linder - patricia.linder@maryland.gov (f4cb516d-5e0c-4515-823b-fcfe1d6687b8)
-- Update roletypekey = CWSP (Old Values: LDSSSP)
select roletypekey, description, updatedby, updatedon  
	from teammember
where teammemberid = 'aef6496f-3b5f-4700-a41d-7ccf9bd8319f'
	and activeflag  = 1 ;

Update teammember 
set roletypekey = 'CWSP',
	updatedon = now(),
	updatedby = 'CDM-31241'
where teammemberid = 'aef6496f-3b5f-4700-a41d-7ccf9bd8319f'
	and activeflag  = 1 ;	
