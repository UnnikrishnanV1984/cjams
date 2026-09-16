/*
 * CDM-39637 - AFCARS - delete living arrangement
 * Customer Email ID:julie.boyd@montgomerycountymd.gov
 * Description - 3300007:PID 4118025, August. There is a placement and LA entered for the same dates (9/1/21-9/30/21). For AFCARS clean up, 
 * please delete this living arrangement as it is already entered via placement and this is a duplicate. 
 * remove the highlighted record for the client AUGUST RYANS(PID: 4118025)
 * 
 */


--select activeflag , * from placement where placementid = '1297d6f1-17e0-4fc0-97b1-b9493c49c8c2';
UPDATE cjams.placement
SET activeflag=0, updatedby='CDM-39637', updatedon=now() 
WHERE placementid='1297d6f1-17e0-4fc0-97b1-b9493c49c8c2'::uuid;
--select activeflag , * from placementrevision WHERE placementid='1297d6f1-17e0-4fc0-97b1-b9493c49c8c2'::uuid;
UPDATE cjams.placementrevision
SET activeflag=0, updatedby='CDM-39637', updatedon=now() 
WHERE placementid='1297d6f1-17e0-4fc0-97b1-b9493c49c8c2'::uuid;

update livingarrangement 
set activeflag = 0,
	updatedby = 'CDM-39637',
	updatedon = now()
where placementid ='1297d6f1-17e0-4fc0-97b1-b9493c49c8c2'
	and activeflag = 1 ;

update routing 
set activeflag = 0,
	updatedby = 'CDM-39637',
	updatedon = now()
where objectid ='1297d6f1-17e0-4fc0-97b1-b9493c49c8c2'
	and eventcode = 'PLTR'
	and activeflag = 1 ;