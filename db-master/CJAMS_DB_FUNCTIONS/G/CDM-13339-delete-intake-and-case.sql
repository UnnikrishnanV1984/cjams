update intakeservicerequest set activeflag = 0, updatedby = 'CDM-13339', updatedon = now()
where intakenumber = 'I211010158404';

update caseassignment c set activeflag = 0, updatedby = 'CDM-13339', updatedon = now()
where objectid = '1c66db7a-df6a-49a3-af6b-4f6b3e0d57c0';

update intakeservicerequestactor set activeflag = 0, updatedby = 'CDM-13339', updatedon = now()
where intakeserviceid = '1c66db7a-df6a-49a3-af6b-4f6b3e0d57c0';

update actor set activeflag = 0, updatedby = 'CDM-13339', updatedon = now()
where intakeserviceid = '1c66db7a-df6a-49a3-af6b-4f6b3e0d57c0';

update personprogramarea set activeflag = 0, updatedby = 'CDM-13339', updatedon = now()
where objectid = '1c66db7a-df6a-49a3-af6b-4f6b3e0d57c0';

update intakedastaging set 
activeflag = 0,
updatedby = 'CDM-13339',
updatedon = now()
where intakenumber = 'I211010158404';

update intakedastatus set 
activeflag = 0,
updatedby = 'CDM-13339',
updatedon = now()
where intakenumber = 'I211010158404';

update intakesnapshot set 
activeflag = 0,
updatedby = 'CDM-13339',
updatedon = now()
where intakenumber = 'I211010158404';