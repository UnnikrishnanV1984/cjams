/*
   Issue Description: CDM-25904
   Replace 200963369  with Person ID 3328164 
   Replace 200963368  with Person ID 4424276
   Category/ Module  :  Need to Screen this Out
   Root cause: user wanted to merge person
   Reason why no related code fix: data
    
*/
update actor set updatedon = now(), 
updatedby = 'CDM-25904', personid = '9b84af4b-65b2-49c7-b3d1-4be4f891c3db' where personid  = 'bd90da03-f5fa-47e0-9268-ec8157340294' and intakenumber = 'I221010322305';

update actor set updatedon = now(), 
updatedby = 'CDM-25904', personid = '632d042c-5ba9-481a-98a7-d729359757e7' where personid  = 'f905e914-ae0e-4bee-b097-031a25d5c378'  and intakenumber = 'I221010322305';



-----------------------------------------------------------------

update intakedastaging 
set jsondata = replace(jsondata ::text , '"Pid": "bd90da03-f5fa-47e0-9268-ec8157340294"', '"Pid": "9b84af4b-65b2-49c7-b3d1-4be4f891c3db"')::json,
updatedon = now(), 
updatedby = 'CDM-25904'
where intakenumber = 'I221010322305' and activeflag = 1;


update intakedastaging 
set jsondata = replace(jsondata ::text , '"Pid": "f905e914-ae0e-4bee-b097-031a25d5c378"', '"Pid": "632d042c-5ba9-481a-98a7-d729359757e7"')::json,
updatedon = now(), 
updatedby = 'CDM-25904'
where intakenumber = 'I221010322305' and activeflag = 1;


update intakedastaging 
set jsondata = replace(jsondata ::text , '"cjamspid": "200963369"', '"cjamspid": "3328164"')::json,
updatedon = now(), 
updatedby = 'CDM-25904'
where intakenumber = 'I221010322305' and activeflag = 1;


update intakedastaging 
set jsondata = replace(jsondata ::text , '"cjamspid": "200963368"', '"cjamspid": "4424276"')::json,
updatedon = now(), 
updatedby = 'CDM-25904'
where intakenumber = 'I221010322305' and activeflag = 1;

-----------------------------------------------------------------

update intakesnapshot
set jsondata = replace(jsondata ::text , '"Pid": "bd90da03-f5fa-47e0-9268-ec8157340294"', '"Pid": "9b84af4b-65b2-49c7-b3d1-4be4f891c3db"')::json,
updatedby = 'CDM-25904',
updatedon = now()
where intakenumber = 'I221010322305';


update intakesnapshot
set jsondata = replace(jsondata ::text , '"Pid": "f905e914-ae0e-4bee-b097-031a25d5c378"', '"Pid": "632d042c-5ba9-481a-98a7-d729359757e7"')::json,
updatedby = 'CDM-25904',
updatedon = now()
where intakenumber = 'I221010322305';


update intakesnapshot
set jsondata = replace(jsondata ::text , '"cjamspid": "200963369"', '"cjamspid": "3328164"')::json,
updatedby = 'CDM-25904',
updatedon = now()
where intakenumber = 'I221010322305';


update intakesnapshot
set jsondata = replace(jsondata ::text , '"cjamspid": "200963368"', '"cjamspid": "4424276"')::json,
updatedby = 'CDM-25904',
updatedon = now()
where intakenumber = 'I221010322305';

-----------------------------------------------------------------


update intakeservicerequestactor 
set personid = '9b84af4b-65b2-49c7-b3d1-4be4f891c3db',
updatedby = 'CDM-25904',
updatedon = now()
where intakenumber = 'I221010322305' and personid = 'bd90da03-f5fa-47e0-9268-ec8157340294';

update intakeservicerequestactor 
set personid = '632d042c-5ba9-481a-98a7-d729359757e7',
updatedby = 'CDM-25904',
updatedon = now()
where intakenumber = 'I221010322305' and personid = 'f905e914-ae0e-4bee-b097-031a25d5c378';