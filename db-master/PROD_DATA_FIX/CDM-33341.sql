/*
 * CDM-33341 - Screenout
 * Customer Email ID:smita.shandelya@maryland.gov
 * Customer Name:Smita Shandelya
 * Focus Area:Decision
 * I231010716618:Hello, I am trying to screen this case out. However, I am not able to click the "Approve" button
 * data fix to change the Intake jurisdiction as Baltimore City so you can take action on this intake. 
 * 
 */

update intakedastaging
set updatedby = 'CDM-33341', updatedon = now(), jsondata = (select jsonb(jsondata) - 'General' || jsonb(json_build_object('General',(select jsonb(jsondata->>'General')-'countyid' || jsonb(json_build_object('countyid','7665ca54-5374-4174-be07-a687b811a82c') )
from intakedastaging i 
where intakenumber = 'I231010716618' and activeflag = 1)))
from intakedastaging i2
where intakenumber = 'I231010716618' and activeflag = 1)
where intakenumber = 'I231010716618' and activeflag = 1; 

update intakesnapshot
set updatedby = 'CDM-33341', updatedon = now(), jsondata = (select jsonb(jsondata) - 'General' || jsonb(json_build_object('General',(select jsonb(jsondata->>'General')-'countyid' || jsonb(json_build_object('countyid','7665ca54-5374-4174-be07-a687b811a82c') )
from intakesnapshot i 
where intakenumber = 'I231010716618' and activeflag = 1)))
from intakesnapshot i2
where intakenumber = 'I231010716618' and activeflag = 1)
where intakenumber = 'I231010716618' and activeflag = 1; 