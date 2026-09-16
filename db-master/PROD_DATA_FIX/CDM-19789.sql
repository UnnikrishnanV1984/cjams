/*
   Issue Description: CDM-19789
   Category/ Module  : Annual Date 
   Root cause: user wants to chnage annual date review. 
   Pull request# for code fix: 4673
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/



update cjams.gapannualreview set effectivedate ='2021-11-29 05:00:00.000', reviewdate ='2021-11-29 05:00:00.000', updatedby ='CDM-19789',  updatedon = now()

where gapannualreviewid ='afe3e972-131e-4151-bba5-c87b39d5867b' and activeflag =1;