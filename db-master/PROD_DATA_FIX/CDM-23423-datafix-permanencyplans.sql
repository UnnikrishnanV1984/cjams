--CDM-23423


update permanencyplan p set p.activeflag = 0, p.updatedon = now(), p.updatedby = 'CDM-23423'
where p.permanencyplanid  in ('c48d4d47-ad22-44c0-981d-ae5d88b095e6', '2a81d664-b7ea-49d3-b4e2-0dd35461d342') and p.intakeservicerequestactorid = '11110398-bd25-49e5-a006-8e926361212e';

update permanencyplan p set p.and intakeservicerequestactorid = 'e3e4a325-e3ef-425f-a510-ec5dd407f317', p.updatedon = now(), p.updatedby = 'CDM-23423'
where p.permanencyplanid  in ('9efb61b7-07aa-48a5-bd99-59a91e59bad7') and p.intakeservicerequestactorid = '11110398-bd25-49e5-a006-8e926361212e';