update intakeservicerequest set
activeflag = 0,
updatedby = 'CDM-12841',
updatedon = now()
where intakeserviceid in 
('b3b7ce0c-7324-4470-8568-b384f4a058ea', '7979eedb-c03e-4670-be63-4c79364e7318', '39ad9579-9906-4467-a10e-3ce6ee410359', 'fc988812-e5e3-4501-897d-80092e7f3d4b');