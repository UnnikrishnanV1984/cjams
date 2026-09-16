-- CIDM-7001 - Duplicate Person Cards in a Case
/*
-- Issue Description: 
	There are duplicate clients in the attached cases.

-- Category/ Module: Interface 
-- Root cause: Flaw in the code, Code fix was promoted to prod as a part CIDM-6960
-- Fix Provided: Mass Datafix to to fix all cases with duplicate Person Cards 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select al_sqlcode, as_mess from cjams.sp_personrole_fix('CIDM-7001'::character varying) ;
