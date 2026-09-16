/*
   Issue Description: CDM-37791
   Category/ Module  :Living Arrangement
   Root cause: 1. update the end date against first placement (Living Arrangement Relative/fictive kin home) as 07/20/2021 1:00 PM.  
               2. update the end time against second placement (Living Arrangement Relative/fictive kin home) as 09/16/2021 12:45 PM
   Pull request# for code fix: na
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

--placementid = '042cf300-f8e1-4338-8bb0-3349c38eb163';
update
    livingarrangement
set
    livingenddate = '2021-07-20 13:00:00.000' ,
    updatedon = now(),
    updatedby = 'CDM-37791'
where
    placementid = '042cf300-f8e1-4338-8bb0-3349c38eb163' and livingid='ac08a8b6-2cb0-4ce9-9980-912df6c9a6f6';


update
    placement
set
    enddatetime = '2021-07-20 13:00:00.000',
    updatedon = now(),
    updatedby = 'CDM-37791'
where
    placementid = '042cf300-f8e1-4338-8bb0-3349c38eb163';


update
    placementrevision
set
    exitdate = '2021-07-20 13:00:00.000',
    updatedby = 'CDM-37791',
    updatedon = now()
where
    placementid = '042cf300-f8e1-4338-8bb0-3349c38eb163'
    and activeflag = 1;
   
   
--placementid = '9ce3d2bb-0cde-4485-b214-a1f6adf6fe7b'

update
    livingarrangement
set
    livingenddate = '2021-09-16 12:45:00.000',
    updatedon = now(),
    updatedby = 'CDM-37791'
where
    placementid = '9ce3d2bb-0cde-4485-b214-a1f6adf6fe7b' and livingid='f53ff188-ab5a-4f25-a885-5ad62f1483ae';


update
    placement
set
    enddatetime = '2021-09-16 12:45:00.000', endtime='12:45',
    updatedon = now(),
    updatedby = 'CDM-37791'
where
    placementid = '9ce3d2bb-0cde-4485-b214-a1f6adf6fe7b';


update
    placementrevision
set
    exitdate = '2021-09-16 12:45:00.000', exittime='12:45',
    updatedby = 'CDM-37791',
    updatedon = now()
where
    placementid = '9ce3d2bb-0cde-4485-b214-a1f6adf6fe7b'
    and activeflag = 1;