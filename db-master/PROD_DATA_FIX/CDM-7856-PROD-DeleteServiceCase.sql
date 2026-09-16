
update servicecase 
set activeflag =0, updatedon =now(), updatedby ='CDM-7856'
where servicecaseid ='a406326e-33fa-408e-b0b5-790ca7ef3b3c';

update intakeservicerequestactor
set activeflag =0, updatedon =now(), updatedby ='CDM-7856'
where servicecaseid ='a406326e-33fa-408e-b0b5-790ca7ef3b3c';