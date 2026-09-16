-- CDM-8656 - Remove AR Case that has been accidentally created

update intakeservicerequest set activeflag = 0, updatedby = 'CDM-8656', updatedon = now() where intakenumber ='I202000161313' and activeflag =1 and intakeserviceid = '9cc1ca89-e604-415c-818f-a6d26506e53a';