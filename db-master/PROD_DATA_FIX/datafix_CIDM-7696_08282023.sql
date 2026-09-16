-- CIDM-7696 - Adoptive Parent Duplicate CJAMS PIDs Fix - Data Fix
/*
-- Issue Description: 
   Adoptive Parent Duplicate CJAMS PIDs Fix
   
-- To replace Adoptive Parent Person (CJAMS PIDs) with Applicant & Co-applicant Person CJAMS PIDs 
   from the Provider Module side 

-- Category/ Module: Documents (Case Document Management) 
-- Root cause: While creating the Adoption case, 
--	           CJAMS is creating new Adoptive Parents person records (CJAMS PIDs) for each case. 
--			   Code fix was promoted as a part of CIDM-7695
-- Fix Provided: Datafix has been promoted to replace Adoptive Parents (CJAMS PIDs) with Applicant & Co-applicant Person CJAMS PIDs from the Provider Module side 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A

@Devops:

This fix is having new Stored Procedure and a datafix script 

So, the order of deployment is 
1) Deploy SP first sp_adoptive_parents_data_sync.sql
2) then run datafix_CIDM-7696_08282023.sql
*/

select al_sqlcode, as_mess 
from cjams.sp_adoptive_parents_data_sync('CIDM-7696'::character varying) ;

/*
-- SQL to Revert data (If needed)
 
select -- adoptioncaseactorid, personid, updatedby, updatedon,
(case when updatedon is not null then 
	'update adoptioncaseactor set personid = ''' || personid || ''', updatedby = ''' || updatedby || ''', updatedon = ''' || updatedon || ''' where adoptioncaseactorid = ''' || adoptioncaseactorid || ''' and activeflag = 1 and updatedby = ''CIDM-7696''; '
else
	'update adoptioncaseactor set personid = ''' || personid || ''', updatedby = ''' || updatedby || ''' where adoptioncaseactorid = ''' || adoptioncaseactorid || ''' and activeflag = 1 and updatedby = ''CIDM-7696''; '
end ) as to_revert	
from adoptioncaseactor adc
where actortypekey = 'ADOPTIVEPARENT'
	and activeflag = 1
order by  insertedon desc ;
*/