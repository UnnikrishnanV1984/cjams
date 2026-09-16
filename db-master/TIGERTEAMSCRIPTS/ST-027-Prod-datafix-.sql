UPDATE intakeservicerequest 
SET   actiontype = null, intakeservicerequestclassid = '00000000-0000-0000-0000-000000000000', activeflag = 0
WHERE  servicerequestnumber = '20190322013801' AND intakeserviceid = '04fd067a-a98b-482a-ab09-e48f8cf22a25';
update intakedastatus set activeflag=0 where intakenumber='I202000456725';