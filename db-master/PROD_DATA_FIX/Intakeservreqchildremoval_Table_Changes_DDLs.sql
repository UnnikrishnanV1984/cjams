Alter table cjams.intakeservreqchildremoval alter column removaltransts set default now() ;


-- ******* NOTE: fn_childremoval_exit function needs to deploy first ******* --

-- Add Trigger on intakeservreqchildremoval
Create trigger tr_childremoval_exit after
	update of exitdate on cjams.intakeservreqchildremoval 
	for each row execute procedure fn_childremoval_exit();