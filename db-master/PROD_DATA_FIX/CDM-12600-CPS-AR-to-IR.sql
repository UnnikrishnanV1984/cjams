update intakeservicerequest set actiontype = 'IR', intakeservicerequestclassid = '3e026a57-247c-4203-82b7-62749c98ccc5', updatedon = now(),updatedby = 'CDM-12600' where intakeserviceid = 'f786522b-a35a-452e-8160-d3b188d9d36f';
update intakeservicerequestsdm set isir = true, updatedon = now(),updatedby = 'CDM-12600' where intakeserviceid = 'f786522b-a35a-452e-8160-d3b188d9d36f';
