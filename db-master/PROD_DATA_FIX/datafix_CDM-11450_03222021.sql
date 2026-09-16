-- CDM-11450 - Purchase Authorization Error
/*
-- Issue Description: 
   Purchase Authorization supervisory approval requests are going to the wrong staff.
   
	Montgomery County
	Megan Walsh (Case Worker) - b0874c67-558d-4b44-8e63-b4b897e82e6c
	
	Correct Supervisor 
	Susannah Wybenga - c3233284-80c4-41a0-8485-d168b93d2a6d

	In-correct Supervisor (Current Data)
	Dianne Nelson - 4cabe5f3-b733-409e-a9ba-d206f9c20486
    
-- Category/ Module: User Profile Management
-- Root cause: User Setup Data Issue.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- User Profile of Megan Walsh (Case Worker) - b0874c67-558d-4b44-8e63-b4b897e82e6c
-- Old VALUES
-- 4cabe5f3-b733-409e-a9ba-d206f9c20486	AS-ADMIN	2021-03-06 00:48:52

select supervisorid, updatedby, updatedon, *  
	from cjams.userprofile  
where securityusersid = 'b0874c67-558d-4b44-8e63-b4b897e82e6c'
	 and activeflag  = 1 ;

update cjams.userprofile  
set supervisorid = 'c3233284-80c4-41a0-8485-d168b93d2a6d', 
	updatedon = now(), 
	updatedby = 'CDM-11450'
where securityusersid = 'b0874c67-558d-4b44-8e63-b4b897e82e6c'
	 and activeflag  = 1 ;

