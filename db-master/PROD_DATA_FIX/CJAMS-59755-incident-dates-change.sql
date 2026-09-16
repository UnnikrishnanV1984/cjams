/*
   Issue Description: 241022952138:The child stated that the incidents occurred when she was 5, while in her mother's care. The dates should be changed to 10/01/2016-8/20/2017. The approximate box should be checked.Wanda Nolt
   Category/ Module  : maltreatment allegation
   Root cause: Incorrect data was entered 
   Pull request# for code fix: na
   Reason why no related code fix: User error
*/

update investigationallegation 
set incidentdate = '2016-10-01 00:00:00.000'::timestamp, 
enddate = '2017-08-20 00:00:00.000'::timestamp,
isapproximatedate = 1,
updatedby='CJAMS-59755',
updatedon=now()
where maltreatmentid = '63bcdded-1e2d-4dc3-a49f-c5987c6e6cc3';


update investigationallegation 
set incidentdate = '2016-10-01 00:00:00.000'::timestamp,
enddate = '2017-08-20 00:00:00.000'::timestamp,
isapproximatedate = 1,
updatedby='CJAMS-59755',
updatedon=now()
where maltreatmentid = 'a2429fcd-a8ef-4a47-8f3a-4bdbd0318f83';
