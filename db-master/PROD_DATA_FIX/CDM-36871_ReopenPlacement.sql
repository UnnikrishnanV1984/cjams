/*
-- CDM-36871 - Reopen Placement
-- Issue Description: 3266470: User requested to re-open the last placement in order to complete GAP entry for this case.
-- Client ID # 200886240 (Mason Michel)
-- Placement ID: 1672574 - 7526152c-0fc5-4453-83c5-7433bf627e33
-- Provider ID # 6043457 (Katelyn Lilly)
-- Child Removal ID: 253960 - 616a0cdd-3da6-4f6e-9adf-b443a74175cb
-- OOH - 2c21c6f8-0afa-4aee-b48c-d9a153de8468
-- Category/ Module: Removal (Case Management) 
-- Root cause: User Error
-- Fix Provided: Datafix has been promoted to re-open the Child Placement / Child Removal / OOH   
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Datafix to re-open the Placement, Removal, OOH & IV-E
-- Placement
update cjams.placement  
set    enddatetime = null, 
	   endtime = null, 
	   exitreasontypekey = null,
	   exittypekey = null,
	   updatedon = now(), 
	   updatedby = 'CDM-36871'
where  placementid = '7526152c-0fc5-4453-83c5-7433bf627e33' and activeflag = 1;

-- Placement Revision
update cjams.placementrevision  
set    exitdate = null, 
	   exittime = null, 
	   exitreasontypkey = null,
	   exittypekey = null,
	   updatedon = now(), 
	   updatedby = 'CDM-36871'
where  placementid = '7526152c-0fc5-4453-83c5-7433bf627e33' and ( exitdate is not null or exittime is not null ) ;

-- Update Removal
update cjams.intakeservreqchildremoval
set    exitdate = Null,
	   returndate = Null,
	   returntime = Null,
	   removalexitreason = NULL,
	   updatedby = 'CDM-36871',
	   updatedon = now()
where  removalid = 253960 and activeflag = 1;

-- Update OOH
update cjams.personprogramarea 
set    enddate = Null, 
	   updatedby = 'CDM-36871',
	   updatedon = now()
where  personprogramid = '2c21c6f8-0afa-4aee-b48c-d9a153de8468' and activeflag = 1;

-- Update Eligibility
update cjams.tb_client_eligibility
set    end_dt = Null,
	   update_user_id = 'CDM-36871',
	   update_ts = now()
where  removal_id =  253960 and delete_sw = 'N' ;