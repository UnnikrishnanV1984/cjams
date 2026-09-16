/*
  Issue Description: CDM-26248
   Category/ Module  : Contact notes 
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   data fix issue, 
   Backup before update/ delete:
*/ 
update cjams.progressnote set contactdate ='2022-10-24 00:00:00', updatedby ='CDM-26248', updatedon = now()

where progressnoteid ='88bcfeeb-012e-46ba-bb24-42b8e77b447d';


update cjams.progressnotedetail set effectivedate ='2022-10-24 00:00:00', updatedby ='CDM-26248', updatedon = now()

where progressnoteid ='88bcfeeb-012e-46ba-bb24-42b8e77b447d';