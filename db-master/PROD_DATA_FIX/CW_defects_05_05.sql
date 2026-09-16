update intakeservreqchildremoval
set exitdate ='2021-04-12 12:00:00' , updatedon =now(), updatedby ='CDM-12922'
where  intakeservreqchildremovalid in ('00087d32-4c79-45fe-934f-e4495829546b','05659b5e-caa4-40d8-a535-017bb63978e4');

update serviceplan
set activeflag=0, updatedon =now(), updatedby ='CDM-12910'
where serviceplanid = 'a8e83894-0d7e-4849-8f5a-9cb36cbe7927';

update personprogramarea
set enddate = null, updatedon =now(), updatedby = 'CDM-12823'
where  personprogramid = '0475fd42-8542-4ce2-ab83-549bec8d29fc';


