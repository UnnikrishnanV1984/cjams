/*
   Issue Description: CIDM-10567
   Category/ Module  :Living Arrangement
   Root cause: update the end date against placement (Living Arrangement ER Psychiatric) as 04/19/2022.  
   Pull request# for code fix: na
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

--placementid = '402e8e48-68ec-4cfa-9a85-62a2c32630cc'

--select * from placement p where placementid ='402e8e48-68ec-4cfa-9a85-62a2c32630cc';

update
    placement
set
    enddatetime = '2022-04-19 00:00:00.000',
    updatedon = now(),
    updatedby = 'CIDM-10567'
where
    placementid = '402e8e48-68ec-4cfa-9a85-62a2c32630cc';

--select * from placementrevision p where placementid ='402e8e48-68ec-4cfa-9a85-62a2c32630cc' and activeflag =1;

update
    placementrevision
set
    exitdate = '2022-04-19 00:00:00.000',
    updatedby = 'CIDM-10567',
    updatedon = now()
where
    placementid = '402e8e48-68ec-4cfa-9a85-62a2c32630cc'
    and activeflag = 1;
   
--select * from livingarrangement where placementid = '402e8e48-68ec-4cfa-9a85-62a2c32630cc' and livingid='ae0762d1-b99e-451d-aa16-f592e97da85c';

update
    livingarrangement
set
    livingenddate = '2022-04-19 00:00:00.000' ,
    updatedon = now(),
    updatedby = 'CIDM-10567'
where
    placementid = '402e8e48-68ec-4cfa-9a85-62a2c32630cc' and livingid='ae0762d1-b99e-451d-aa16-f592e97da85c';

