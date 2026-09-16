/*
   Issue Description: CDM-32834
   Category/ Module  :  person
   Root cause: user wants to remove the remove the persons from case and intake
   Fix Provided: Did data fix to remove persons and personprogramareas  
*/

update intakeservicerequestactor
set activeflag = 0, updatedby = 'CDM-32834', updatedon = now()
where intakeservicerequestactorid in ('ebbe6c6f-2e35-4aef-8be9-d49dc9bba30a','ba00f2ea-0cae-4c30-92b5-62f53b74afd8','b3b1094f-c48d-4d52-95ff-be390e500b4b',
'8a25acb2-4039-4b1f-bb28-8777fd16e7a3','1b90ef74-beb9-4ef8-ae1f-2447413b7b1d','ac8ef3b0-9941-4789-bc5a-b70b2d0b295b','a777c136-0b8a-4db3-bbed-1f839624e925',
'd042afe5-9420-4d81-acc8-ffdcf7331aa8')and personid in ('18cf403e-cc84-4f7b-bfca-8a210ba6fff9','b165f356-3f0d-4f12-9234-9a3ef4666a21',
'eea3347f-9e94-41ed-910d-7681715a3347','6d37065e-6012-4029-8898-35c716643511') and (intakeserviceid = '6ae24207-c698-4433-bcd5-272fe42c5c0b' 
or intakenumber = 'I231010602292') and activeflag = 1;

--personrole
update personrole
set activeflag = 0,	updatedby = 'CDM-32834', updatedon = now()
where personid in ('18cf403e-cc84-4f7b-bfca-8a210ba6fff9','b165f356-3f0d-4f12-9234-9a3ef4666a21',
'eea3347f-9e94-41ed-910d-7681715a3347','6d37065e-6012-4029-8898-35c716643511') and (intakeserviceid = '6ae24207-c698-4433-bcd5-272fe42c5c0b' 
or intakenumber = 'I231010602292') and activeflag = 1 ;
    
update actor
set activeflag = 0,	updatedby = 'CDM-32834', updatedon = now()
where personid in ('18cf403e-cc84-4f7b-bfca-8a210ba6fff9','b165f356-3f0d-4f12-9234-9a3ef4666a21',
'eea3347f-9e94-41ed-910d-7681715a3347','6d37065e-6012-4029-8898-35c716643511')and (intakeserviceid = '6ae24207-c698-4433-bcd5-272fe42c5c0b' 
or intakenumber = 'I231010602292') and activeflag = 1 ;

update actorrelationship
set activeflag = 0,	updatedby = 'CDM-32834', updatedon = now()
where intakeservicerequestactorid in (	
select intakeservicerequestactorid from intakeservicerequestactor
where personid in ('18cf403e-cc84-4f7b-bfca-8a210ba6fff9','b165f356-3f0d-4f12-9234-9a3ef4666a21','eea3347f-9e94-41ed-910d-7681715a3347','6d37065e-6012-4029-8898-35c716643511') 
and (intakeserviceid = '6ae24207-c698-4433-bcd5-272fe42c5c0b' or intakenumber = 'I231010602292')) and activeflag = 1;

UPDATE cjams.personprogramarea
SET activeflag = 0, updatedon = now(), updatedby = 'CDM-32834'
WHERE personprogramid in ('c1cbc0cb-aaee-4361-afbd-33df1f9150ec', 'a59b8d4e-aa6c-41ee-83fc-e1b074a6708d', '1dcf4af8-3b51-4bd9-98f5-a56586bc3494', 
'41623b67-d09a-4e64-b1be-cc09d04875ed') and  personid in ('18cf403e-cc84-4f7b-bfca-8a210ba6fff9','b165f356-3f0d-4f12-9234-9a3ef4666a21',
'eea3347f-9e94-41ed-910d-7681715a3347','6d37065e-6012-4029-8898-35c716643511') and objectid = '6ae24207-c698-4433-bcd5-272fe42c5c0b';

