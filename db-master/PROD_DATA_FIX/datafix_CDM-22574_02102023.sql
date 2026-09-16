-- CDM-22574 - Source data missing for table removal dim
/*
-- Issue Description: 
   Removal Data discrepancy between CJAMS application DB & Reporting Mart
   

-- Category/ Module: Removal (Case Management) 
-- Root cause: Data issue (Exception scenario, 3 removal records with NO Service case or CPS case association)
-- Fix Provided: Data fix has been promoted to soft-delete the 3 removal records. 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Before 
select removalid, removaldate, exitdate, removalexitreason, updatedby, updatedon, activeflag 
	from cjams.intakeservreqchildremoval
where activeflag =1 
	and intakeserviceid is null 
	and servicecaseid is null ;
		
-- Update Eligibility
select client_id, start_dt, end_dt, delete_sw, update_ts, update_user_id 
	from cjams.tb_client_eligibility
where delete_sw = 'N' 
	and eligibility_status_cd  = '2909' -- Pending
	and removal_id 
	in ( select removalid	 
			from cjams.intakeservreqchildremoval
		 where activeflag  =1 
			and intakeserviceid is null 
			and servicecaseid is null
	   ) ;

update cjams.tb_client_eligibility
set delete_sw = 'Y',
	update_user_id = 'CDM-22574',
	update_ts = now()
where delete_sw = 'N' 
	and eligibility_status_cd  = '2909' -- Pending
	and removal_id 
	in ( select removalid	 
			from cjams.intakeservreqchildremoval
		 where activeflag  =1 
			and intakeserviceid is null 
			and servicecaseid is null
	   ) ;

-- Update Routing
select routingid, eventcode, routingstatustypeid, activeflag, updatedby, updatedon  
	from routing  
where objectid in 
	( select intakeservreqchildremovalid::character varying 
		from intakeservreqchildremoval i 
	  where activeflag  =1 
		and intakeserviceid is null 
		and servicecaseid is null
	)
	and activeflag = 1 ;
	
update routing
set activeflag = 0,
	updatedby = 'CDM-22574',
	updatedon = now()
where objectid in 
	( select intakeservreqchildremovalid::character varying 
		from intakeservreqchildremoval i 
	  where activeflag  =1 
		and intakeserviceid is null 
		and servicecaseid is null
	)
	and activeflag = 1 ;
	
-- Update Removal	
select removalid, removaldate, exitdate, removalexitreason, updatedby, updatedon, activeflag 
	from cjams.intakeservreqchildremoval
where activeflag =1 
	and intakeserviceid is null 
	and servicecaseid is null ;
	
update cjams.intakeservreqchildremoval
set activeflag = 0,
	updatedby = 'CDM-22574',
	updatedon = now()
where activeflag = 1 
	and intakeserviceid is null 
	and servicecaseid is null ;
	
-- No OOH & Placements

-- After 
select removalid, removaldate, exitdate, removalexitreason, updatedby, updatedon, activeflag 
	from cjams.intakeservreqchildremoval
where activeflag =1 
	and intakeserviceid is null 
	and servicecaseid is null ;
	