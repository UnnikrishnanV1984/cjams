--D-26423

--data fix to updatedby insertedby

update documentproperties set insertedby = '73928a5f-a1ce-443b-a0c7-2f7fe2d6f4bb', 
updatedby ='73928a5f-a1ce-443b-a0c7-2f7fe2d6f4bb', updatedon =now() where documentpropertiesid = 'dd6ec25e-a7c5-489b-8cd5-2dd6f6182820'

--D-26539
update intakeservicerequestactor set = activeflag = 1, updatedby= 'D-26539', updatedon=now() where intakeservicerequestactorid = 'db3a1b85-9a7f-478b-8f26-515f0cc50afb' and activeflag=0