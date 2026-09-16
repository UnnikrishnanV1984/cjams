/*
   Issue Description: CDM-29570
   Category/ Module  :  SENS case open in error. Now showing on the SENS Milestone report. Charles County needs to screen out report. 
   Root cause: User error case connect
   Pull request# for code fix: 
   Reason why no related code fix: 
   user error - requested a data fix
*/

update servicecase set activeflag = 0, updatedby = 'CDM-29570', updatedon = now()
where servicecaseid = '0109b616-16f2-4c5b-8176-d63105df7a9d';

update servicecasedisposition set activeflag = 0, updatedon = now(), updatedby = 'CDM-29570' 
where servicecaseid = '0109b616-16f2-4c5b-8176-d63105df7a9d';

update routing set activeflag = 0, updatedon = now(), updatedby = 'CDM-29570' 
where routingid in('2ce54658-60ce-4308-8b16-6698ec35f094',
'890e7ab6-5c03-461b-a4aa-914513828f79');

update intakesnapshot
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-29570'
where intakesnapshotid::character varying = '15815070-249e-482c-9451-74fd4bef5cae';

UPDATE intakeservicerequest 
SET activeflag = 0,
updatedon = now(),
updatedby = 'CDM-29570'
where intakeserviceid = '338b69b3-9e97-48de-bfe3-b1e1fcafc3ef';

update routing
set routingstatustypeid  = 1,
eventcode = 'INTR',
updatedon = now(),
updatedby = 'CDM-29570'
where objectid = 'I231010430649';

update intakedastatus
set status = 1,
updatedon = now(),
updatedby = 'CDM-29570'
where intakenumber = 'I231010430649' and activeflag=1;

update intakedastaging
set status = 'pending',
ispreintake = FALSE,
updatedon = now(),
updatedby = 'CDM-29570'
where intakenumber = 'I231010430649' and activeflag = 1;


---Need to reset the SDM "Risk of Harm" checkbox too
UPDATE intakesnapshot 
SET updatedby  ='CDM-29570',
updatedon =now() ,
jsondata = replace(jsondata::text, '"isnegrh_exposednewborn": true', '"isnegrh_exposednewborn": false')::json
 WHERE intakenumber = 'I231010430649' AND activeflag = 1;


 UPDATE intakedastaging 
SET updatedby  ='CDM-29570',
updatedon =now() ,
jsondata = replace(jsondata::text, '"isnegrh_exposednewborn": true', '"isnegrh_exposednewborn": false')::json
 WHERE intakenumber = 'I231010430649' AND activeflag = 1;

 update cjams.person set substanceexposednewbornflag=NULL,substanceexposednewbornsourcetypekey=NULL,
substanceexposednewbornsourceid=NULL,substanceexposednewborntimetamp=NULL,substanceclasses=NULL,othersubstances=NULL,senstatusflag = null,
updatedby  ='CDM-29570',
updatedon =now() where cjamspid = 201071727;
