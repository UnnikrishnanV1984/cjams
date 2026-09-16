update intakeservicerequest set activeflag = 0, updatedby = 'CJAMS-17889', updatedon = now() 
where intakenumber in ('20200171021752', '20200167021169', '20200160020498', '20200150019656');