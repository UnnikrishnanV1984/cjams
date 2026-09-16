-- To Verify 
select af.afcarsfostercareid, af.caseid, af.fk_id as cjamspid, af.removalid,
   (select up.email 
		from caseassignment ca,
			userprofile up,
			county ct	
	where ca.objectid = ( select servicecaseid from servicecase where servicecasenumber =  af.caseid )
		and ca.toworkeridno = up.securityusersid
		and up.primarycountycd = ct.statecountycode
		and ca.responsibilitytypekey = 'family'
		and ca.activeflag = 1
		and ca.enddate is null
	order by ca.startdate desc
	limit 1) as caseworker
	, rm.intakeservreqchildremovalid 
from cjams.afcarsfostercare_new af,
	cjams.intakeservreqchildremoval rm
where af.removalid = rm.removalid
	and af.activeflag = 1
	and rm.activeflag = 1
	and (select rur.routingstatustypeid
			from routing rur 
		 where rur.objectid = rm.intakeservreqchildremovalid::character varying
			and rur.eventcode = 'CHRR'
			and rur.activeflag = 1
			and rur.routingstatustypeid in ('16', '17')
			order by rur.updatedon desc
		limit 1	
		) = '17'
; 
				
-- Soft delete Rejected Removals 
update cjams.afcarsfostercare_new af1
	set activeflag = 0,
		updatedby = 'DFXRejRem',
		updatedon = now()
where af1.afcarsfostercareid		
	in (
	select af.afcarsfostercareid 
	from cjams.afcarsfostercare_new af,
		cjams.intakeservreqchildremoval rm
	where af.removalid = rm.removalid
		and af.activeflag = 1
		and rm.activeflag = 1
		and (select rur.routingstatustypeid
				from routing rur 
			 where rur.objectid = rm.intakeservreqchildremovalid::character varying
				and rur.eventcode = 'CHRR'
				and rur.activeflag = 1
				and rur.routingstatustypeid in ('16', '17')
				order by rur.updatedon desc
			limit 1	
			) = '17'
	); 
		
		