/*
   Issue Description: CDM-38364 Dashboard:It appears that the Gap Program is not connected to the foster care program / service case 
   Category/ Module  : Title IV-E GAP
   Root cause: Service case is not connected to GAP case.
   Fix Provided : Data fix has been promoted to update the GAP service case id in Permanency plan and intakeservreqchildremoval tables 
*/

update permanencyplan
set intakeservicerequestactorid='300eb9ee-f354-4226-955d-1bff8d405a0a',
    updatedby = 'CDM-38364', 
    updatedon =  now()
where permanencyplanid = '39d24825-0ab8-4a01-b2dd-73ec0befa85f';

