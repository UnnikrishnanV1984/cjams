--D-27015

DELETE from intakeservicerequestdispositioncode WHERE intakeserreqstatustypeid ='7995cecb-062d-406c-8ea9-b1da4b1877d8' and 
intakeserviceid IN 
(select intakeserviceid from intakeservicerequest where servicerequestnumber = '2020038015395') ;

DELETE from intakeservicerequestdispositioncode WHERE intakeserreqstatustypeid='7995cecb-062d-406c-8ea9-b1da4b1877d8' and 
intakeserviceid IN 
(select intakeserviceid from intakeservicerequest where servicerequestnumber = 'CW2949889') ;

update intakeservicerequest 
set intakeserreqstatustypeid = '52ad4cc7-e8f8-4cbb-9e27-d86f2b817690', 
updatedby = 'D-27015', 
updatedon = now() where intakeserreqstatustypeid='7995cecb-062d-406c-8ea9-b1da4b1877d8' and 
servicerequestnumber IN ('2020038015395', 'CW2949889' ) ;

----D-27013
update intakeservicerequest set intakeservicerequestclassid = '00000000-0000-0000-0000-000000000000', 
actiontype = null, updatedon = now(), 
updatedby ='D-27013' where servicerequestnumber = 2020034015188;