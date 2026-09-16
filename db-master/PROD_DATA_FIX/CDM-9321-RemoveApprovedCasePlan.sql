-- CDM-9321 - Remove approved case plan so that permanency details can be populated in the newly created case plan

update snapshothist set activeflag = 0, updatedby = 'CDM-9321', updatedon = now() where id = '5e590e24-59c9-496c-b852-47338cf14a59' and objectid = 'dd97a4b7-35f5-41cf-907b-985f9174ed24' and approvalstatus = 'Approved' and activeflag = 1;
