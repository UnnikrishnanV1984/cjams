-- CDM-9653 - Change the updatedby to case worker instead of Supervisor

update cjams.assessment set updatedby =  '4356aea9-455d-42a8-994f-67d90dd95291' where assessmentid = '26aec25a-fe61-4c99-925a-03bd737bd591' and activeflag = 1;
