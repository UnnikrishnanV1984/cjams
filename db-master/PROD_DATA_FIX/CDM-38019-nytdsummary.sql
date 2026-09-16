UPDATE cjams.personnytdsummary
SET updatedby='CDM-38019', updatedon=now(), activeflag=0
where summaryid='5805b022-0d1a-44d5-a2df-c0263b6ad15f' and personid='8611b1e9-d7ac-4207-a5de-6c118ec1c14c' and activeflag = 1;

UPDATE cjams.personnytddetail
SET updatedby='CDM-38019', updatedon=now(), activeflag=0
where summaryid='5805b022-0d1a-44d5-a2df-c0263b6ad15f' and activeflag = 1;