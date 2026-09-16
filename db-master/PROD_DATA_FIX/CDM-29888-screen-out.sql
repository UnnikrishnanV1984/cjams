/*
   Issue Description: CDM-29888
   Category/ Module  : Referral needs to be screen out
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

--Giving access to approve supervisor becuase for this record there is no intakesnapshot record 

update intakedastatus 
set status = null, updatedby = 'CDM-29888', updatedon = now()
where intakenumber = 'I202100646733' and activeflag = 1;


update intakedastaging 
set status = 'pending', updatedby = 'CDM-29888', updatedon = now()
where intakenumber = 'I202100646733' and activeflag = 1;

update cjams.routing set eventcode ='XXXX', routingstatustypeid =1, activeflag =0
where routingid ='f0a1e111-fdd5-4ba4-8d50-16e4d620d35f';