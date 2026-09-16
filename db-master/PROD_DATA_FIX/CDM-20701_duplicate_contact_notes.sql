/*
   Issue Description: CDM-20701
   Category/ Module  : Contact notes
   Root cause: user asked to remove duplicate contact notes
*/

UPDATE progressnote 
SET activeflag = 0, updatedby = 'CDM-20701', updatedon = now() 
WHERE progressnoteid in ('32016c2d-45b8-4169-9382-ef135cf16514', '00ca2dac-bb96-4976-b811-f9de6010b282', 'f9fab36e-d472-42a9-aaf0-2ae838c7c51d', '989ed8cf-0c33-41df-9b15-c82a0edea82f', '9f8e1996-1a9b-4ed0-8e43-f74c4178cfbf');

UPDATE progressnotedetail 
SET activeflag  = 0, updatedby = 'CDM-20701', updatedon = now()
WHERE progressnoteid in ('32016c2d-45b8-4169-9382-ef135cf16514', '00ca2dac-bb96-4976-b811-f9de6010b282', 'f9fab36e-d472-42a9-aaf0-2ae838c7c51d', '989ed8cf-0c33-41df-9b15-c82a0edea82f', '9f8e1996-1a9b-4ed0-8e43-f74c4178cfbf');
