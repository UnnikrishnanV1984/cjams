
/*
   Issue Description: CDM-35872
   Category/ Module  : Referral Stuck, cannot approve
   Root cause: Referral/Intake #231011635772 was overridden and changed from screen in to screen out.
   Resolution: update routing and instakedstaging for reassigning the case to supervisor for approval.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


update routing set eventcode='INTR', activeflag=1, updatedby = 'CDM-35872', updatedon = now()
where objectid='I231011635772' and routingid='fd943198-b362-4c81-a573-9b45cdf208cb';


UPDATE intakedastaging
 set updatedby = 'CDM-35872', updatedon = now(),
 jsondata = jsonb_set(jsondata, '{DAType}', 
            jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
            jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
            jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '""'))))
WHERE intakenumber = 'I231011635772' AND activeflag=1;