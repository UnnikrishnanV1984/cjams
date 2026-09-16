-- CDM-34253 - Need to un-restrict CPS 231021067232
/*
-- Issue Description: 
	User Request to un-restrict CPS 231021067232

-- Category/ Module: CPS IR CASE 
-- Root cause: User error/Data issue, Intake is restricted without giving access to any user.
-- Fix Provided: Datafix has been promoted to un-restrict the requested CPS 231021067232
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- CPS 231021067232
-- Before
select restricteditemsid, objecttypekey, objectid, accessuserid, updatedby, updatedon, activeflag 
	from restricteditems
where objectid = '5813f763-2060-4951-9feb-0a5f7ff6ab4b'
	and activeflag = 1 ;

update restricteditems
set activeflag = 0,
	updatedby = 'CDM-34253',
	updatedon = now()
where objectid = '5813f763-2060-4951-9feb-0a5f7ff6ab4b'
	and activeflag = 1 ;	