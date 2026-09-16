/*
    CDM-37652
    Issue: Delete placement
    Root cause:User requested to delete placement
    Resolution: provided a data fix to remove placement.
*/

select * from placement where placementid = '34cfdece-d5a2-4ac0-bfe1-723678c919e8';

update placement set activeflag = 0, updatedby = 'CDM-37652', updatedon = now() 
where placementid='34cfdece-d5a2-4ac0-bfe1-723678c919e8' and activeflag =1; 

select activeflag,* from routing where objectid='34cfdece-d5a2-4ac0-bfe1-723678c919e8' and activeflag=1;

update routing 
set updatedby = 'CDM-37652', updatedon = now(), activeflag = 0
where objectid='34cfdece-d5a2-4ac0-bfe1-723678c919e8' and activeflag=1;

select 	activeflag, * from placementrevision 
where 	activeflag = 1 and placementid = '34cfdece-d5a2-4ac0-bfe1-723678c919e8';

update placementrevision set activeflag = 0, updatedby = 'CDM-37652', updatedon = now() 
where placementid = '34cfdece-d5a2-4ac0-bfe1-723678c919e8' and activeflag =1;
