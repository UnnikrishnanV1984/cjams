-- CDM-32866 - Need to un-restrict Intake I231010595928
/*
-- Issue Description: 
	User Request to un-restrict Intake I231010595928

-- Category/ Module: Intake Referral (Intake Management) 
-- Root cause: User error/Data issue, Intake is restricted without giving access to any user.
-- Fix Provided: Datafix has been promoted to un-restrict the requested Intake I231010595928
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Intake I231010595928
-- Before
select restricteditemsid, objecttypekey, objectid, accessuserid, updatedby, updatedon, activeflag 
	from restricteditems
where objectid = 'I231010595928'
	and activeflag = 1 ;

update restricteditems
set activeflag = 0,
	updatedby = 'CDM-32866',
	updatedon = now()
where objectid = 'I231010595928'
	and activeflag = 1 ;	