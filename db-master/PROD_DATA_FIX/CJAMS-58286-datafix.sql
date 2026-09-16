/*
   Issue Description: CJAMS-58286
   Category/ Module  : Decision
   Root cause: Data fix is promoted to update the jurisdiction name 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update intakedastaging
set  updatedby = 'CJAMS-58286', updatedon = now(),jsondata = (select jsonb(jsondata) - 'General' || jsonb(json_build_object('General',(select jsonb(jsondata->>'General')-'countyid' || jsonb(json_build_object('countyid','bbce9638-24f9-4336-993c-007f6755c980') )
from intakedastaging i
where intakenumber = 'I251013236326' and activeflag = 1)))
from intakedastaging i2
where intakenumber = 'I251013236326' and activeflag = 1)
where intakenumber = 'I251013236326' and activeflag = 1;


update intakesnapshot
set updatedby = 'CJAMS-58286', updatedon = now(), jsondata = (select jsonb(jsondata) - 'General' || jsonb(json_build_object('General',(select jsonb(jsondata->>'General')-'countyid' || jsonb(json_build_object('countyid','bbce9638-24f9-4336-993c-007f6755c980') )
from intakesnapshot i 
where intakenumber = 'I251013236326' and activeflag = 1)))
from intakesnapshot i2
where intakenumber = 'I251013236326' and activeflag = 1)
where intakenumber = 'I251013236326' and activeflag = 1;

