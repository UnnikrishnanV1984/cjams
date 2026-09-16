-- D-24653

update intakeservicerequest set activeflag = 0, updatedon = now(), updatedby = 'D-24653' where intakenumber = 'I202000357036' and activeflag = 1;
update intakedastatus set activeflag = 0, updatedon = now(), updatedby = 'D-24653' where intakenumber = 'I202000357036' and activeflag = 1;
update intakedastaging set activeflag = 0, updatedon = now(), updatedby = 'D-24653' where intakenumber = 'I202000357036' and activeflag = 1;
update intakeservicerequestactor set activeflag = 0, updatedon = now(), updatedby = 'D-24653' where activeflag= 1 and intakeserviceid in (select intakeserviceid from intakeservicerequest where intakenumber = 'I202000357036');

--D-24598

update intakeservicerequest set activeflag = 0, updatedon = now(), updatedby = 'D-24598' where intakenumber = 'I202000256977' and activeflag = 1;
update intakedastatus set activeflag = 0, updatedon = now(), updatedby = 'D-24598' where intakenumber = 'I202000256977' and activeflag = 1;
update intakedastaging set activeflag = 0, updatedon = now(), updatedby = 'D-24598' where intakenumber = 'I202000256977' and activeflag = 1;
update intakeservicerequestactor set activeflag = 0, updatedon = now(), updatedby = 'D-24598' where activeflag= 1 and intakeserviceid in (select intakeserviceid from intakeservicerequest where intakenumber = 'I202000256977');

--D-25017

update intakedastatus set activeflag = 0, updatedby ='D-25017', updatedon = now() where intakedastatusid 
in ('c8ca7ecf-57e6-462a-9b2c-e55e6cd48c67', 'be1c713f-4516-4dca-912c-ab0e99146a6d', '1f586b99-60cf-4ce6-8cd3-e1c58e28c54c');
