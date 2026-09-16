/*
  Issue Description:  CDM-43706
   Category/ Module  :placement tab
   Root cause: User request: As per system design the placement validation is considering based on the selected placement structure. 
    Need an enhancement user story to accommodate the Pre-finalized Adoptive Home Non-Paid scenario as a placement structure so the child can be placed with the provider without generating any payment.
    BA/QA request to data fix to remove the placement exit date for both children. to remove the placement exit date for both children.
    
    Case ID: 3272745
    Client ID: 4031899 (ARIES X DERSIN)
    Client ID: 4031896 (AALIYAH Jayde DERSIN)

    Pull request# for code fix: 
   Reason why no related code fix: user requested 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete:
   
*/

--Alliyah J Dersin placementid: bdcfaf6e-9376-44fd-aec5-19e684f49aaa
--Aries X Dersin placementid: c162aa0f-848a-4269-a670-afa7d4e7ca24
/*select alternateid, startdatetime, starttime, enddatetime, endtime, 
	exitreasontypekey, exittypekey, isvoided, updatedby, updatedon 
from cjams.placement 
where placementid in ('c162aa0f-848a-4269-a670-afa7d4e7ca24','bdcfaf6e-9376-44fd-aec5-19e684f49aaa')
	and activeflag  = 1 ;
	*/

update cjams.placement  
set enddatetime = null, 
	endtime = null, 
	exitreasontypekey = null,
	exittypekey = null,
	updatedon = now(), 
	updatedby = 'CDM-43706'
where placementid in ('c162aa0f-848a-4269-a670-afa7d4e7ca24','bdcfaf6e-9376-44fd-aec5-19e684f49aaa')
	and activeflag  = 1 ;


-- Placement Revision
/*
select exitdate, exittime, exitreasontypkey, exittypekey, updatedby , updatedon, activeflag,* 
	from cjams.placementrevision  
where placementid in ('c162aa0f-848a-4269-a670-afa7d4e7ca24','bdcfaf6e-9376-44fd-aec5-19e684f49aaa')
	and ( exitdate is not null or exittime is not null ) and activeflag = 1 ;
*/

update cjams.placementrevision  
set exitdate = null, 
	exittime = null, 
	exitreasontypkey = null,
	exittypekey = null,
	updatedon = now(), 
	updatedby = 'CDM-43706'
where placementid in ('c162aa0f-848a-4269-a670-afa7d4e7ca24','bdcfaf6e-9376-44fd-aec5-19e684f49aaa')
	and ( exitdate is not null or exittime is not null ) 
	and activeflag = 1;

/*
in DB: placementrevisionid: c21a871b-7ea1-4e8e-bef0-20ecfd3901ff ,e9f8612c-066d-4af6-a171-1f7dc0ff4a33 with active flag 
in page: placementrevisionid: 735a4b0f-0537-421c-a7a9-52a812c6131b, 639ef384-3bd9-4573-9595-1ef4c37aeb68
*/
	
/* placement_id 1727397 
 * placement_id 1727364 has no entry
 * select placement_id, placement_entry_dt , placement_exit_dt,
	validation_start_dt, validation_end_dt, validation_status_cd,
	update_ts, update_user_id, delete_sw,*
from tb_placement_validation 
where placement_id = 1727397 
	and delete_sw = 'N';

Update tb_placement_validation 
set placement_exit_dt = null,
	update_ts = now(),
	update_user_id = 'CDM-43706'
where placement_id = 1564997
	and delete_sw = 'N' ;
	*/	