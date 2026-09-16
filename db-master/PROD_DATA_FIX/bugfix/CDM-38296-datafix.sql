/*
   Issue Description: CDM-38296
   Category/ Module  : Reopen Placement
   Root cause:  Remove the Provider Placement Exit Record (Reopen the provider placement), child removal end date and OOH Program Assignment end date.
   Pull request# for code fix: 
   Reason why no related code fix:  
   Status of the code fix if already submitted and expected prod fix date: 
   Case is closed without closing removal and placement. Need to do data fix
*/


-- Placement
select alternateid, startdatetime, starttime, enddatetime, enddatetime, 
	exitreasontypekey, exittypekey, isvoided, updatedby, updatedon 
from cjams.placement 
where placementid = 'b2dc82b6-d6cb-4b8d-88cb-7be852a33d1f'
	and activeflag  = 1 ;

update cjams.placement  
set enddatetime = null, 
	endtime = null, 
	exitreasontypekey = null,
	exittypekey = null,
	updatedon = now(), 
	updatedby = 'CDM-38296'
where placementid = 'b2dc82b6-d6cb-4b8d-88cb-7be852a33d1f'
	and activeflag  = 1 ;

-- Placement Revision

select exitdate, exittime, exitreasontypkey, exittypekey, updatedby , updatedon  
	from cjams.placementrevision  
where placementid = 'b2dc82b6-d6cb-4b8d-88cb-7be852a33d1f' 
	and exitdate is not null ;

update cjams.placementrevision  
set exitdate = null, 
	exittime = null, 
	exitreasontypkey = null,
	exittypekey = null,
	updatedon = now(), 
	updatedby = 'CDM-38296'
where placementid = 'b2dc82b6-d6cb-4b8d-88cb-7be852a33d1f' 
	and exitdate is not null ;

    update intakeservreqchildremoval set exitdate =null, updatedby ='CDM-38296', updatedon = now() 
where intakeservreqchildremovalid ='70b4e69d-5432-4f87-8646-7e786ec3eb2d' and activeflag =1;


update personprogramarea set enddate = null, updatedby ='CDM-38296', updatedon = now()  
where personprogramid ='5fb0a60d-45b0-451c-9531-b36f513ea157' and activeflag =1;

update tb_client_eligibility set  end_dt = null,
update_user_id = 'CDM-38296', update_ts = now()
where removal_id ='269929';
