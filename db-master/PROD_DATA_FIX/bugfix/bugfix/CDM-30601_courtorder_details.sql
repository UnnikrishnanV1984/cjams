/*
   Issue Description: CDM-30601
   Category/ Module  : court order details unable to save and show in the ui.
   Root cause: intakeservicerequestactorid is null in the courtorder 
   Pull request# for code fix: 
   Reason why no related code fix:  
   Status of the code fix if already submitted and expected prod fix date: 
*/

update intakeservreqcourtorder set intakeservicerequestactorid = 'f6a5da03-dea2-4cf8-a97b-c778ff0a1def' ,
updatedby = 'CDM-30601' , updatedon = now()
where intakeservreqcourtorderid in ('a2f34cb2-3adc-4fb9-9368-702c5eabc93f'
,'8314a563-bf47-42a5-91f5-0df8f30a4fc3'
,'db411b3f-3c53-4773-a057-e16bda8a3a4f'
,'9d668784-d00c-4949-bc4b-9896ed08e828'
,'d096971e-d156-464c-9803-4f15aab90dbe'
,'6bd933eb-db46-4f74-b370-8cc9161c809b'
,'fb2e9c95-51a0-476a-ac45-0544fb2d462e'
,'09593aa2-2c6e-4d24-8a88-520c7c8d3311'
,'e17acf7e-83fb-4142-9921-b5a8ce97f3e5'
,'47f8d3b3-1781-47f9-93b4-501314e599e2'
,'371d8f67-3b40-4f73-b835-851baa54b963'
,'15046ab1-19ef-4e78-a582-019ed6d84564'
,'0b2a384b-7b44-468d-84df-53d0fcfabb12'
,'465216f3-cfe4-4222-a2e5-42097d1b1f36'
,'6c9c6a66-1171-4d59-8008-0d089211d89b'
,'ad1e437d-b3f0-4b46-a658-da610b7fa1c0');