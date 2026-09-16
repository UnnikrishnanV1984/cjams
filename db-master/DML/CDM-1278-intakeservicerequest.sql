UPDATE cjams.intakeservicerequest
SET intakeservicerequestclassid='00000000-0000-0000-0000-000000000000', activeflag=0,updatedby='CDM-1278', updatedon=now() 
WHERE intakeserviceid='03a52fdf-e7c2-4fbf-aaae-9d0f2f86203a';

UPDATE cjams.personprogramarea
SET updatedby='CDM-1278', updatedon=now(), activeflag=0, datatransferflag='D'
WHERE personprogramid in ('deb33302-3fd6-41a1-8ac7-5fc653aa43bf', 'c2203fb6-d5d7-4a98-9712-6bd1039ee6d5', '8d2872bf-ed1a-4dba-baa0-35ab3ab4a477', 'b7f04972-0d02-4126-9074-9f8bd4139791', 'cc4af261-1bca-4308-b096-ac8f860bc2c9',
'42bf6bf2-8885-4e1d-80e3-be7c00959f9a', 'ed334552-7c59-4d66-9ebe-73878f0ad47d', '57dfe877-dc86-4045-8160-4fbd7ae2d7ab', 'b04b1b67-2d64-4863-9f94-d69007831130', '780e23a0-5f95-4b5b-90a9-b4977cc1e502', '9ab64477-fdcd-49ca-9d16-0598be203c05' );

SELECT * FROM assigncase('SRVC','b7dd5e96-f60c-4c5e-823a-26da689bb5ae','9e9f9f17-2889-499f-a35b-ec0d8d9f24d6',
'[{"userid": "3d99e5fd-e66e-4284-b736-7adbf58c03b1", "username": "Corey Magee", "responsibilitytypekey": "family"}]','IHSFP','CS')