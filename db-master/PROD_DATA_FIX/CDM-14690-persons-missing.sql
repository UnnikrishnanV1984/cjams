update intakeservicerequestactor 
set
isprimary = true,
updatedon = now(),
updatedby = 'CDM-14690'
where 
intakeservicerequestactorid in ('2c6cd97a-93a7-40d0-9dbd-afa532e8aacb', '34b4033c-78e2-402b-957f-731923a96523');