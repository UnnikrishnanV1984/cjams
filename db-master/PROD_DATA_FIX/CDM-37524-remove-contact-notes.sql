/*
   Issue Description: CDM-37524
   Category/ Module  : Inappropriate Contact/ contact notes
   Root cause: user wants to remove the contact notes
   Resolution: removed the contact notes by making active flag to 0
*/


select activeflag , * from progressnote where progressnoteid  = '86e2ae22-8405-4488-8a19-1c6773b66769';

select activeflag, * from progressnote where progressnoteid  = '052c677b-fe19-4817-b888-54beb3e952a7';

UPDATE progressnote 
SET activeflag = 0, updatedby = 'CDM-37524' , updatedon = now()
WHERE progressnoteid in ('86e2ae22-8405-4488-8a19-1c6773b66769', '052c677b-fe19-4817-b888-54beb3e952a7');

select activeflag ,* from progressnotedetail where progressnoteid in ('86e2ae22-8405-4488-8a19-1c6773b66769', '052c677b-fe19-4817-b888-54beb3e952a7');

update progressnotedetail set activeflag = 0, updatedby = 'CDM-37524' , updatedon = now()
WHERE progressnoteid in ('86e2ae22-8405-4488-8a19-1c6773b66769', '052c677b-fe19-4817-b888-54beb3e952a7');

select activeflag, * from contactparticipant where progressnoteid in ('86e2ae22-8405-4488-8a19-1c6773b66769', '052c677b-fe19-4817-b888-54beb3e952a7') and activeflag = 1;

update contactparticipant
SET activeflag = 0, updatedby = 'CDM-37524' , updatedon = now()
WHERE progressnoteid in ('86e2ae22-8405-4488-8a19-1c6773b66769', '052c677b-fe19-4817-b888-54beb3e952a7') and activeflag = 1;
