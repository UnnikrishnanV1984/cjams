/*
 * CDM-33467 - Screen out referral
 * Customer Email ID:kim.hardy@maryland.gov
 * Customer Name:Kim Hardy
 * Description - I231010899630:This referral was received in Baltimore City and was being screened out; however, it will not allow the 
 * screening supervisor to complete the screen out process. The screening supervisor is only allowed to submit screen out but not the approve button. 
 * data fix to change the jurisdiction to Baltimore City for intake # I231010899630 
 * 
 */

update intakedastaging
set updatedby = 'CDM-33467', updatedon = now(), jsondata = (select jsonb(jsondata) - 'General' || jsonb(json_build_object('General',(select jsonb(jsondata->>'General')-'countyid' || jsonb(json_build_object('countyid','7665ca54-5374-4174-be07-a687b811a82c') )
from intakedastaging i 
where intakenumber = 'I231010899630' and activeflag = 1)))
from intakedastaging i2
where intakenumber = 'I231010899630' and activeflag = 1)
where intakenumber = 'I231010899630' and activeflag = 1; 

update intakesnapshot
set updatedby = 'CDM-33467', updatedon = now(), jsondata = (select jsonb(jsondata) - 'General' || jsonb(json_build_object('General',(select jsonb(jsondata->>'General')-'countyid' || jsonb(json_build_object('countyid','7665ca54-5374-4174-be07-a687b811a82c') )
from intakesnapshot i 
where intakenumber = 'I231010899630' and activeflag = 1)))
from intakesnapshot i2
where intakenumber = 'I231010899630' and activeflag = 1)
where intakenumber = 'I231010899630' and activeflag = 1; 