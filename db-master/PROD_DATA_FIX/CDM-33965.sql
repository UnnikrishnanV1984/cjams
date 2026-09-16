/*
 * CDM-33965 - Referral Stuck
 * Customer Email ID:kelly.glotfelty@maryland.gov
 * Customer Name:Kelly Glotfelty
 * Severity:Critical
 * Description - I231011061887:We entered a report that is a conflict for Montgomery County. Frederick will be making the screening decision and handling the resulting case. 
 * The jurisdiction needs to be updated to FREDERICK so that we can screen the referral. CJAMS will not let our screener update the 
 * jurisdiction to Frederick from Montgomery County and as a result the referral is stuck. 
 * do a data fix as below;
 * 1) Change the jurisdiction of Intake # I231011061887 from Montgomery County to Frederick County
 * 2) Change the Date/Time Received and Date/Time Recorded of Intake # I231011061887 to 8/30/2023, 9:49 AM
 * 3) Delete Intake # I231011055417
 */

-- select countyid from county where countyname = 'Frederick'; -- d0a6f218-4dee-45c3-b842-be7446a5ef41

update intakedastaging
set updatedby = 'CDM-33965', updatedon = now(), jsondata = (select jsonb(jsondata) - 'General' || jsonb(json_build_object('General',(select jsonb(jsondata->>'General')-'countyid' || jsonb(json_build_object('countyid','d0a6f218-4dee-45c3-b842-be7446a5ef41') )
from intakedastaging i
where intakenumber = 'I231011061887' and activeflag = 1)))
from intakedastaging i2
where intakenumber = 'I231011061887' and activeflag = 1)
where intakenumber = 'I231011061887' and activeflag = 1;

update intakesnapshot
set updatedby = 'CDM-33965', updatedon = now(), jsondata = (select jsonb(jsondata) - 'General' || jsonb(json_build_object('General',(select jsonb(jsondata->>'General')-'countyid' || jsonb(json_build_object('countyid','d0a6f218-4dee-45c3-b842-be7446a5ef41') )
from intakesnapshot i 
where intakenumber = 'I231011061887' and activeflag = 1)))
from intakesnapshot i2
where intakenumber = 'I231011061887' and activeflag = 1)
where intakenumber = 'I231011061887' and activeflag = 1; 

update intakedastaging
set updatedby = 'CDM-33965', updatedon = now(), jsondata = (select jsonb(jsondata) - 'General' || jsonb(json_build_object('General',(select jsonb(jsondata->>'General')-'CreatedDate' || jsonb(json_build_object('CreatedDate','2023-08-30 09:49:00') )
from intakedastaging i 
where intakenumber = 'I231011061887' and activeflag = 1)))
from intakedastaging i2
where intakenumber = 'I231011061887' and activeflag = 1)
where intakenumber = 'I231011061887' and activeflag = 1; 

update intakesnapshot
set updatedby = 'CDM-33965', updatedon = now(), jsondata = (select jsonb(jsondata) - 'General' || jsonb(json_build_object('General',(select jsonb(jsondata->>'General')-'CreatedDate' || jsonb(json_build_object('CreatedDate','2023-08-30 09:49:00') )
from intakesnapshot i 
where intakenumber = 'I231011061887' and activeflag = 1)))
from intakesnapshot i2
where intakenumber = 'I231011061887' and activeflag = 1)
where intakenumber = 'I231011061887' and activeflag = 1; 

update routing
set activeflag = 0, updatedon = now(), updatedby = 'CDM-33965'
where objectid = 'I231011055417';

update intakedastatus
set activeflag = 0, updatedon = now(), updatedby = 'CDM-33965'
where intakenumber = 'I231011055417';

update intakedastaging
set activeflag = 0, updatedon = now(), updatedby = 'CDM-33965'
where intakenumber = 'I231011055417';

update intakesnapshot
set activeflag = 0, updatedon = now(), updatedby = 'CDM-33965'
where intakenumber = 'I231011055417';
