select * from createservicecase('b67384fb-04a5-457d-a21a-41324906926e', '5fe6fb83-1ae1-46dd-8325-f32b64d2624e', 0, '2bc44bbe-5920-49a3-9e05-ef79c400bf9e') ;


update intakeservicerequest set servicecaseid = null, updatedby = 'CDM-9454', updatedon = now() where intakenumber = 'I202000203423';