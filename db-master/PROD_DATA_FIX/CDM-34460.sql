/*
 * CDM-34460 - Cannot screen out
 * Customer Email ID:smita.shandelya@maryland.gov
 * Customer Name:Smita Shandelya
 * Description - I231010874576:Hello,I am trying to screen this case out, but the "Save" and "Approve" buttons don't work. I am not able to click them. 
 * Able to select the supervisor decision as Screen Out but not able to Save/Approve as the button is disable.
 * data fix to change the jurisdiction to Baltimore City for intake # I231010874576 
 * 
 */

--select * from county where countyid in ('f5214cb2-953e-41a9-a4ad-71341501e2ad','7665ca54-5374-4174-be07-a687b811a82c');

update intakedastaging
set updatedby = 'CDM-34460', updatedon = now(), jsondata = (select jsonb(jsondata) - 'General' || jsonb(json_build_object('General',(select jsonb(jsondata->>'General')-'countyid' || jsonb(json_build_object('countyid','7665ca54-5374-4174-be07-a687b811a82c') )
from intakedastaging i 
where intakenumber = 'I231010874576' and activeflag = 1)))
from intakedastaging i2
where intakenumber = 'I231010874576' and activeflag = 1)
where intakenumber = 'I231010874576' and activeflag = 1; 

update intakesnapshot
set updatedby = 'CDM-34460', updatedon = now(), jsondata = (select jsonb(jsondata) - 'General' || jsonb(json_build_object('General',(select jsonb(jsondata->>'General')-'countyid' || jsonb(json_build_object('countyid','7665ca54-5374-4174-be07-a687b811a82c') )
from intakesnapshot i 
where intakenumber = 'I231010874576' and activeflag = 1)))
from intakesnapshot i2
where intakenumber = 'I231010874576' and activeflag = 1)
where intakenumber = 'I231010874576' and activeflag = 1; 

--select ispreintake, * from intakedastaging where intakenumber = 'I231010874576' and activeflag = 1;

update intakedastaging
set
updatedby = 'CDM-34460', updatedon = now(),
ispreintake = FALSE
where intakenumber = 'I231010874576' and activeflag = 1;
