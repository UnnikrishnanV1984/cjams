-- CDM-13122 - Reinstate the provider's suspension
/*
-- Issue Description: 
   Datafix to Remove the GAP Suspension with no routing record.
   
-- Case ID: 3154045 - kparker@maryland.gov
-- Client ID: 2041272 (JAYLIN P	DILLARD) - 0e8e4e03-3e7c-4725-a0b3-fdbfd3f96206
-- Provider ID: 5026452	(Sheavron Fortune)
-- GAP ID: 2617 - 01/23/2013 To 02/16/2022 - af12b524-bc57-4353-a746-59a9a1c8166c

-- Category/ Module: GAP (Case Management) 
-- Root cause: Date Issue (GAP Suspension with no routing record) 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select gapsuspensionid, startdate, enddate, activeflag, updatedby, updatedon 
    from cjams.gapsuspension 
where gapid = 'af12b524-bc57-4353-a746-59a9a1c8166c'
	and activeflag  = 1 ;

update cjams.gapsuspension  
set enddate = startdate,
	updatedon = now(), 
	updatedby = 'CDM-13122'
where gapid = 'af12b524-bc57-4353-a746-59a9a1c8166c'
	and activeflag  = 1 ;
	
select gapsuspensionrevisionid, startdate, enddate, approvaldate, approvalstatustypekey, updatedby, updatedon 
	from gapsuspensionrevision
where guardiansubsidyid  = 'af12b524-bc57-4353-a746-59a9a1c8166c'
	and suspensionid  
		in ( select gapsuspensionid 
				from gapsuspension g2 
			where gapid = 'af12b524-bc57-4353-a746-59a9a1c8166c'
				and activeflag  = 1
			) ;
	
update cjams.gapsuspensionrevision  
set enddate = startdate,
	approvaldate = now(),
	updatedon = now(), 
	updatedby = 'CDM-13122'
where guardiansubsidyid  = 'af12b524-bc57-4353-a746-59a9a1c8166c'
	and suspensionid  
		in ( select gapsuspensionid 
				from gapsuspension g2 
			where gapid = 'af12b524-bc57-4353-a746-59a9a1c8166c'
				and activeflag  = 1
			) ;