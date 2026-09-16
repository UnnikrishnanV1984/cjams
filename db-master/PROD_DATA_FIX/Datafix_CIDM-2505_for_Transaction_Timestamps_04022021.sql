-- Datafix for Child Removal (intakeservreqchildremoval) Removal & Return Transaction Timestamps

-- Removal Transaction Timestamps
select intakeservreqchildremovalid, removaldate, removaltransts, insertedon, updatedon, updatedby 
	from intakeservreqchildremoval
where activeflag = 1
   and removaldate is not null
   and ( removaltransts is null or removaltransts = '1900-01-01');
   

update intakeservreqchildremoval
set removaltransts = insertedon,
	updatedon = now(),
	updatedby = 'CIDM-2505'
where activeflag = 1
   and removaldate is not null
   and ( removaltransts is null or removaltransts = '1900-01-01');


select intakeservreqchildremovalid, removaldate, removaltransts, insertedon, updatedon 
	from intakeservreqchildremoval
where activeflag = 1
	and removaldate is null
	and ( removaltransts is not null or removaltransts = '1900-01-01');

update intakeservreqchildremoval
set removaltransts = null,
	updatedon = now(),
	updatedby = 'CIDM-2505'
where activeflag = 1
	and removaldate is null
	and ( removaltransts is not null or removaltransts = '1900-01-01');

	
-- Return Transaction Timestamp
select intakeservreqchildremovalid, exitdate, returntransts, insertedon, updatedon 
	from intakeservreqchildremoval
where activeflag = 1
	and exitdate is not null
	and ( returntransts is null or returntransts = '1900-01-01');
	
update intakeservreqchildremoval	
set	returntransts = updatedon,
	updatedon = now(),
	updatedby = 'CIDM-2505'
where activeflag = 1
	and exitdate is not null
	and ( returntransts is null or returntransts = '1900-01-01');	
	
	
select intakeservreqchildremovalid, exitdate, returntransts, insertedon, updatedon
	from intakeservreqchildremoval
where activeflag = 1
	and exitdate is null
	and ( returntransts is not null or returntransts = '1900-01-01');
	
update intakeservreqchildremoval	
set	returntransts = null,
	updatedon = now(),
	updatedby = 'CIDM-2505'
where activeflag = 1
	and exitdate is null
	and ( returntransts is not null or returntransts = '1900-01-01');
	
	