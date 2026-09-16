-- CDM-11239 - Payments made to non approved removals
/*
-- Issue Description: 
   Clients with Active Placements and Closed corresponding Removals (reported by Pierre)
    
-- Category/ Module: Removal (Case Management) 
-- Root cause: Need more analysis 
-- Pull request# TDB
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TDB
*/

-- Datafix to Remove End date of the Removals, OOHs & IV-Es
-- Update OOH
select p.personprogramid, p.startdate, p.enddate, p.programkey 
	from cjams.personprogramarea p 
where (p.personid, p.objectid, p.startdate ) 
		in (
			select i.personid, 
				i.servicecaseid::character varying,
				i.removaldate 
			from cjams.intakeservreqchildremoval i 
			where removalid in (196532, 59108, 251406, 193616, 194241, 251402, 250557, 199442, 193368, 195017)
				and activeflag = 1
				and exitdate is not null
		)
and p.programkey = 'OOH'
and (select count(*)
	from cjams.personprogramarea p1
  where p1.personid = p.personid
  	and p1.activeflag  = 1
  	and p1.enddate is null
  	and p1.programkey = 'OOH'
  ) = 0 ;
  
update cjams.personprogramarea p1 
	set p1.enddate = NULL, 
		p1.updatedby = 'CDM-11239',
		p1.updatedon = now()
where p1.personprogramid 
	in ( 
		select p.personprogramid
			from cjams.personprogramarea p 
		where (p.personid, p.objectid, p.startdate ) 
				in (
					select i.personid, 
						i.servicecaseid::character varying,
						i.removaldate 
					from cjams.intakeservreqchildremoval i 
					where removalid in (196532, 59108, 251406, 193616, 194241, 251402, 250557, 199442, 193368, 195017)
						and activeflag = 1
						and exitdate is not null
				)
		and p.programkey = 'OOH'
		and (select count(*)
			from cjams.personprogramarea p1
		  where p1.personid = p.personid
			and p1.activeflag  = 1
			and p1.enddate is null
			and p1.programkey = 'OOH'
		  ) = 0
		)
	and p1.activeflag = 1
	and p1.enddate is not null ;	
	
	
-- Update Eligibility
select eligibility_period_id, eligibility_id, start_dt, end_dt, update_ts, update_user_id
	from cjams.tb_eligibility_period
where delete_sw = 'N' 
	and eligibility_id 
		in ( select eligibility_id 
				from cjams.tb_client_eligibility
			where removal_id in (196532, 59108, 251406, 193616, 194241, 251402, 250557, 199442, 193368, 195017)
				and delete_sw = 'N' 
				and end_dt is not null
			)
	and end_dt is not null;		
	
update cjams.tb_eligibility_period
	set end_dt = NULL,
		update_user_id = 'CDM-11239',
		update_ts = now()
where delete_sw = 'N' 
	and eligibility_id in 
		(	select eligibility_id
				from cjams.tb_eligibility_period
			where delete_sw = 'N' 
				and eligibility_id 
					in ( select eligibility_id 
							from cjams.tb_client_eligibility
						where removal_id in (196532, 59108, 251406, 193616, 194241, 251402, 250557, 199442, 193368, 195017)
							and delete_sw = 'N' 
							and end_dt is not null
						)
				and end_dt is not null	
		
		);	


select eligibility_id, client_id, start_dt, end_dt, update_ts, update_user_id 
	from cjams.tb_client_eligibility
where removal_id in (196532, 59108, 251406, 193616, 194241, 251402, 250557, 199442, 193368, 195017)
	and delete_sw = 'N' 
	and end_dt is not null;

update cjams.tb_client_eligibility
	set end_dt = NULL,
		update_user_id = 'CDM-11239',
		update_ts = now()
where removal_id in (196532, 59108, 251406, 193616, 194241, 251402, 250557, 199442, 193368, 195017)
	and delete_sw = 'N' 
	and end_dt is not null;


-- Update Removal
select removalid, removaldate, exitdate, returndate, returntime, returntransts, updatedby, updatedon
	from cjams.intakeservreqchildremoval 
where removalid in (196532, 59108, 251406, 193616, 194241, 251402, 250557, 199442, 193368, 195017)
	and activeflag = 1
	and exitdate is not null ;


update cjams.intakeservreqchildremoval 
set exitdate = NULL,
	returndate = NULL,
	returntime = NULL,
	returntransts = NULL,
	updatedby = 'CDM-11239',
	updatedon = now()
where removalid in (196532, 59108, 251406, 193616, 194241, 251402, 250557, 199442, 193368, 195017)
	and activeflag = 1
	and exitdate is not null ;
