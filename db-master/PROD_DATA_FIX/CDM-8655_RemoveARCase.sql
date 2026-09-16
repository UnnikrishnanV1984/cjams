-- CDM-8655 - Remove AR Case that has been accidentally created

update intakeservicerequest set activeflag = 0, updatedby = 'CDM-8655', updatedon = now() where intakenumber ='I202000464079' and activeflag =1 and intakeserviceid = 'e047df58-1c03-43d3-b1cf-c8b8fecad538';