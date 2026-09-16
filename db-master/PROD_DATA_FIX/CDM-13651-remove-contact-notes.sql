update progressnote 
set activeflag = 0, updatedby = 'CDM-13651', updatedon = now() 
where progressnoteid in ('7110a806-3e53-4016-9aa5-777c5b15bb3d', 'df2e7589-a1b9-477f-905f-6205a86ceb48');