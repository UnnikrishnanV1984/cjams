/*
 * CDM-39639 - AFCARS duplicate living arrangement
 * Customer Email ID:larissa.royal@montgomerycountymd.gov
 * Description - 3279685:For AFCARS cleanup, there are duplicate living arrangements for Antoine Young Jr on 1/10/2021-2/26/2021 
 * with the same dates. One needs to be deleted in order to add caregiver to the other. 
 */


--select activeflag , * from placement where placementid = '266f348a-8057-4c93-b7fd-ccca17dbfe7c';
UPDATE cjams.placement
SET activeflag=0, updatedby='CDM-39639', updatedon=now() 
WHERE placementid='266f348a-8057-4c93-b7fd-ccca17dbfe7c'::uuid;
--select activeflag , * from placementrevision WHERE placementid='266f348a-8057-4c93-b7fd-ccca17dbfe7c'::uuid;
UPDATE cjams.placementrevision
SET activeflag=0, updatedby='CDM-39639', updatedon=now() 
WHERE placementid='266f348a-8057-4c93-b7fd-ccca17dbfe7c'::uuid;

update livingarrangement 
set activeflag = 0,
	updatedby = 'CDM-39639',
	updatedon = now()
where placementid ='266f348a-8057-4c93-b7fd-ccca17dbfe7c'
	and activeflag = 1 ;

	update routing 
set activeflag = 0,
	updatedby = 'CDM-39639',
	updatedon = now()
where objectid ='266f348a-8057-4c93-b7fd-ccca17dbfe7c'
	and eventcode = 'PLTR'
	and activeflag = 1 ;
