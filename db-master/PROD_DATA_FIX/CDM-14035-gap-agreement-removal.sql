UPDATE gapagreement 
SET activeflag = 0, 
    updatedby = 'CDM-14035',
    updatedon = now()
WHERE gapagreementid = '18901e13-2720-4a4e-99bd-1df10adc28fa';

UPDATE gapagreementrate 
SET activeflag = 0, 
    updatedby = 'CDM-14035',
    updatedon = now()
WHERE gapagreementrateid = 'c0eeffad-8536-49bb-8a99-0ed4614dac66';

UPDATE gapratesrevision 
SET activeflag = 0, 
    updatedby = 'CDM-14035',
    updatedon = now()
WHERE gaprateid = 'c0eeffad-8536-49bb-8a99-0ed4614dac66';


UPDATE routing 
SET activeflag = 0, 
    updatedby = 'CDM-14035',
    updatedon = now()
WHERE objectid in ('18901e13-2720-4a4e-99bd-1df10adc28fa', 'c0eeffad-8536-49bb-8a99-0ed4614dac66');

update permanencyplan 
set activeflag = 0,
	updatedby = 'CDM-14035',
	updatedon = now()
where permanencyplanid = 'c4a28eba-1ad2-4d6c-9fe7-160ad30780b8';

UPDATE guardianship 
SET activeflag = 0,
	updatedby = 'CDM-14035',
	updatedon = now()
WHERE gapid = '4e35c56d-6a97-4e79-8fd1-71841114b7be';