	/*
Issue Description: 231030112352:I am trying to add a new placement for the youth and because there is a rejected placement, the system is preventing me from being able to add the new placement. The rejected placement needs to be removed to allow the new placement to be added to CJAMS
Root cause: 
Fix provided :yes,write db query
Code fix ticket#: CJAMS-59947
Reason why no related code fix: Status of the code fix already submitted
Status of the code fix if already submitted and expected prod fix date: N/A
Backup before update/ delete:
*/

--Placement Table
update cjams.placement
set activeflag = 0,
updatedby = 'CJAMS-59947',
updatedon = now()
where placementid = '3842e55b-f235-45b0-90dd-0a551bb9f492';

--Routing Table
update cjams.routing 
set activeflag = 0,
updatedby = 'CJAMS-59947',
updatedon = now()
where routingid = 'c14ab00e-189a-4693-8910-b4f9e53e2ac5';

--Placementrevision Table
update cjams.placementrevision 
set activeflag = 0,
updatedby = 'CJAMS-59947',
updatedon = now()
where placementrevisionid = '081fe0ac-9159-4988-a3f0-bbf31fc25c68';

--Livingarrangement Table
update cjams.livingarrangement 
set activeflag = 0,
updatedby = 'CJAMS-59947',
updatedon = now()
where placementid = '3842e55b-f235-45b0-90dd-0a551bb9f492' and activeflag=1;
