--D-22154 This AR was created in error when a service case was launched.  This case needs deleted

UPDATE intakeservicerequest SET IntakeServiceRequestClassId = '00000000-0000-0000-0000-000000000000', updatedon = NOW()
WHERE servicerequestnumber = '20190324013836';
