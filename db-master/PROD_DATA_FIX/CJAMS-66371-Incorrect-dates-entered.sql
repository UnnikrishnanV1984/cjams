/*
   Issue Description: CJAMS-66371
   Category/ Module  : Annual Review sign date change
   Root cause: user wants to change gap annual sign date review
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/


update gapannualreview
set cgprimarydate = '2026-03-17 05:00:00',cgsecondarydate = '2026-03-17 05:00:00', 
directorsigndate = '2026-03-17 05:00:00',updatedby = 'CJAMS-66371', updatedon = now()
where gapannualreviewid = '6f0ebeca-d7e1-449b-acd9-6fcba8649d67' and activeflag = 1;