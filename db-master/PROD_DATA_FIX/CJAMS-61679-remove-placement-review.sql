/*
    CJAMS-61679
    Issue: This placement should be voided as there was an issue with entry and the provider has not been paid. 
    Root cause:User requested to delete review provider placement
    Resolution: provided a data fix to remove placement.
*/

--select * from placement where placementid = 'fe380a14-a7e5-433f-aae0-fac780acd7c3';
update placement set activeflag = 0, updatedby = 'CJAMS-61679', updatedon = now() 
where placementid='fe380a14-a7e5-433f-aae0-fac780acd7c3' and activeflag =1; 

--select activeflag,* from routing where objectid='fe380a14-a7e5-433f-aae0-fac780acd7c3' and activeflag=1;
update routing 
set updatedby = 'CJAMS-61679', updatedon = now(), activeflag = 0
where objectid='fe380a14-a7e5-433f-aae0-fac780acd7c3' and activeflag=1;

/*
select 	activeflag, * from placementrevision 
where 	activeflag = 1 and placementid = 'fe380a14-a7e5-433f-aae0-fac780acd7c3';
*/
update placementrevision set activeflag = 0, updatedby = 'CJAMS-61679', updatedon = now() 
where placementid = 'fe380a14-a7e5-433f-aae0-fac780acd7c3' and activeflag =1;
