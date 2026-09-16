/*
    CDM-15453
    Root cause: Multiple removal created but OOH program assignment not created. Couldn't find the root cause
    Solution: Doing data fix for now
*/

INSERT INTO personprogramarea (
	personid, programkey, subprogramkey, objecttypekey, objectid, 
	startdate, insertedby, insertedon, updatedby, updatedon, 
	entityid, activeflag, sourcetype
)
values
('9025607b-4fd1-4ee3-a486-b3cc4a5ad6c6', 'OOH', null, 'servicecase', 'bf2d8044-8731-41ab-93cf-4b1e224bcc2e', '2021-06-10 00:00:00', 'CDM-15453', now(), 'CDM-15453', now(), '3232587', 1, 'CW'),     
('ba6d4d24-1c1d-4ba7-92b0-d82212318f61', 'OOH', null, 'servicecase', 'bf2d8044-8731-41ab-93cf-4b1e224bcc2e', '2021-06-10 00:00:00', 'CDM-15453', now(), 'CDM-15453', now(), '3232587', 1, 'CW'),
('dae75834-5e5c-4581-ba37-e79acde54302', 'OOH', null, 'servicecase', 'bf2d8044-8731-41ab-93cf-4b1e224bcc2e', '2021-06-10 00:00:00', 'CDM-15453', now(), 'CDM-15453', now(), '3232587', 1, 'CW'),
('ae280a53-7352-42d5-ab46-b7bb571580d5', 'OOH', null, 'servicecase', 'bf2d8044-8731-41ab-93cf-4b1e224bcc2e', '2021-06-10 00:00:00', 'CDM-15453', now(), 'CDM-15453', now(), '3232587', 1, 'CW'),
('a2bdb8f9-7cc3-4fb1-9499-c5e3faf94aac', 'OOH', null, 'servicecase', 'bf2d8044-8731-41ab-93cf-4b1e224bcc2e', '2021-06-10 00:00:00', 'CDM-15453', now(), 'CDM-15453', now(), '3232587', 1, 'CW'),
('04335657-0a9f-4e9d-bd0e-7830795e1980', 'OOH', null, 'servicecase', 'bf2d8044-8731-41ab-93cf-4b1e224bcc2e', '2021-06-10 00:00:00', 'CDM-15453', now(), 'CDM-15453', now(), '3232587', 1, 'CW'),
('9b8e1da5-33f2-4035-b29a-e1862293f790', 'OOH', null, 'servicecase', 'bf2d8044-8731-41ab-93cf-4b1e224bcc2e', '2021-06-10 00:00:00', 'CDM-15453', now(), 'CDM-15453', now(), '3232587', 1, 'CW'),
('470daf0e-c408-4b4f-bc6c-0f132832b02c', 'OOH', null, 'servicecase', 'bf2d8044-8731-41ab-93cf-4b1e224bcc2e', '2021-06-10 00:00:00', 'CDM-15453', now(), 'CDM-15453', now(), '3232587', 1, 'CW'),
('8ad8aecf-9c28-4703-9b9d-b580f3cb64b7', 'OOH', null, 'servicecase', 'bf2d8044-8731-41ab-93cf-4b1e224bcc2e', '2021-06-10 00:00:00', 'CDM-15453', now(), 'CDM-15453', now(), '3232587', 1, 'CW'),
('cc5b3cdd-bc98-44d2-ba92-6492ce8ed307', 'OOH', null, 'servicecase', 'bf2d8044-8731-41ab-93cf-4b1e224bcc2e', '2021-06-10 00:00:00', 'CDM-15453', now(), 'CDM-15453', now(), '3232587', 1, 'CW'),
('3090408d-b987-4347-9fe0-08c121cfce76', 'OOH', null, 'servicecase', 'bf2d8044-8731-41ab-93cf-4b1e224bcc2e', '2021-06-10 00:00:00', 'CDM-15453', now(), 'CDM-15453', now(), '3232587', 1, 'CW'),
('ab97133e-f00d-4568-9ce8-46886eb52f68', 'OOH', null, 'servicecase', 'bf2d8044-8731-41ab-93cf-4b1e224bcc2e', '2021-06-10 00:00:00', 'CDM-15453', now(), 'CDM-15453', now(), '3232587', 1, 'CW');