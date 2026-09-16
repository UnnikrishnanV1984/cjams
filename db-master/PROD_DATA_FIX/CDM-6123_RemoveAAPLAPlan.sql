-- CDM-6123 - Remove AAPLA Plan from the case permanency plan

update cjams.assessment set activeflag =0,updatedon=now(),updatedby='CDM-6123' where assessmentid = '1c990cac-9134-4b0b-b92b-8aeccd6e5c21' and activeflag=1;