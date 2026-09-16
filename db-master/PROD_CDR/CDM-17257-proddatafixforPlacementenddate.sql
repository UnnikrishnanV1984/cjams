/*
    CDM-17257
    Issue: Removing Living arrangement record
    Root cause: user requested
    Fix: Done data fix for now
*/


update placement set activeflag = 0, updatedby = 'CDM-17257', updatedon = now() where placementid = '638774ae-e4d4-4097-af22-6230bc2d217d';
update livingarrangement set activeflag = 0, updatedby = 'CDM-17257', updatedon = now() where livingid =  '0a32ceab-c817-438e-9434-a21103e8850a';