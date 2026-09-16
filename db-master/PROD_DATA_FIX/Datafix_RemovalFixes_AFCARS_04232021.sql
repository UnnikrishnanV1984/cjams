-- Datafix for Child Removal (intakeservreqchildremoval) Removal & Return Transaction Timestamps

select returndate, returntime, exitdate, updatedon, updatedby 
	from intakeservreqchildremoval i 
where activeflag = 1
	and exitdate is null
	and ( returntime is not null or returndate is not null );


update intakeservreqchildremoval
set returndate = null,
	returntime = null,
	updatedon = now(),
	updatedby = 'CIDM-2505_1'
where activeflag = 1
	and exitdate is null
	and ( returntime is not null or returndate is not null );

