UPDATE intakeservicerequest
SET intakeserreqstatustypeid = '642f18b0-ef6e-4d4b-9871-acc0734f3f5a',
    intakeservicerequestclassid = '00000000-0000-0000-0000-000000000000',
    actiontype = null,
    isaccepted = null,
    accepteddate = null,
    updatedby = 'CDM-13531',
    updatedon = now()
WHERE intakenumber = 'I202000459702';

UPDATE intakeservicerequestdispositioncode 
SET activeflag = 0, 
    updatedby = 'CDM-13531',
    updatedon = now()
WHERE intakeservicerequestdispositioncodeid = '54d5163b-f37c-4a3c-b93f-56396c404710';
