-- CDM-36793 - Placement exit not approving
/*
-- Issue Description: Placement exit details are not saving after approval
-- Category/ Module: Placement
-- Root cause: case worker primary role is not correct in teammember table. 
--			   Data fix needed to change roletypekey from LDSSRW to CWCW
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select roletypekey from teammember where teammemberid = '029dc14e-48a3-444c-9823-10dd313ebd87';

update teammember 
	set roletypekey = 'CWCW',  
		updatedon = now(),
		updatedby = 'CDM-36793'
	where teammemberid = '029dc14e-48a3-444c-9823-10dd313ebd87';