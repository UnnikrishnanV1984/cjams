/*Root cause: Once Maltreatment type has been changed by Appeal worker . Currently application is not displaying latest maltreatment type due to Check box from SDM is not matching
Fix: Did Data fix in reverting the previous allegationid in investigationallegation and investigationallegationtreator table.
Regression: NA
Is Code fix Required?: NA
Code fix ticket#: This is a design change will taken as an enhancement story
*/

/*
select oahmaltreatmenttypeid ,oahearingdecision ,overridefindingtypekey ,updatedon ,* 
from investigationallegationmaltreators i 
where investigationallegationid ='f4d0809d-bb4e-4db0-babf-325a4e538049' and activeflag =1
order by updatedon desc ;

select updatedby ,maltreatmentid ,allegationid ,* from investigationallegation i where investigationid ='7d9bf7b3-28d6-4d42-9381-0fbeb7190aba'; --5d8d1262-36cc-4464-b5d3-4f50cf0073ae
*/

update investigationallegation 
set allegationid = '627b574e-aa98-48c1-98c3-cf6f5d155eff',
    updatedby = 'CJAMS-60078', updatedon = now()
where investigationallegationid in('f4d0809d-bb4e-4db0-babf-325a4e538049') 
and allegationid = 'e11fc4b5-1edf-4f17-af54-b536bbf6df31';

UPDATE investigationallegationmaltreators
SET oahmaltreatmenttypeid = '627b574e-aa98-48c1-98c3-cf6f5d155eff',
    updatedby = 'CJAMS-60078',
    updatedon = NOW()
WHERE investigationallegationmaltreatorsid  = (
  SELECT investigationallegationmaltreatorsid 
  FROM investigationallegationmaltreators
  WHERE investigationallegationid = 'f4d0809d-bb4e-4db0-babf-325a4e538049'
    AND activeflag = 1
  ORDER BY updatedon DESC
  LIMIT 1
);