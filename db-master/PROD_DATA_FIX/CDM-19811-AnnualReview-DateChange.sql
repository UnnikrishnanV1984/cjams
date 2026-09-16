/*
   Issue Description: CDM-19811
   Category/ Module  : Annual Date 
   Root cause: user wants to chnage annual date review. 
   Pull request# for code fix: 4673
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/

update gapannualreview
set reviewdate = '2021-12-15 05:00:00', updatedby = 'CDM-19811', updatedon = now()
where gapannualreviewid = '358ad115-8f6b-4170-8870-3e55bd4cfd9f';