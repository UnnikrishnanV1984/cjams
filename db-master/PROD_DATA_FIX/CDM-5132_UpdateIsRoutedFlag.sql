-- CDM-5132 - Set isrouted flag to true

update intakeservicerequest set isrouted = true, updatedby = 'CDM-5132', updatedon = now() where intakeserviceid = '7f5d4677-62e6-42d8-9c15-cc95bbed6a39' and activeflag =1 and isrouted = false 