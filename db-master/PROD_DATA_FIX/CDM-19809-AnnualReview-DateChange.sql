/*
   Issue Description: CDM-19809
   Category/ Module  : Annual Review date change
   Root cause: user wants to change gap annual date review
   Pull request# for code fix: 4683
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/
update gapannualreview
set reviewdate = '2021-12-01 05:00:00', updatedby = 'CDM-19809', updatedon = now()
where gapannualreviewid = 'c4cb4600-f409-479d-b0e7-8cead37fdd04';

update gapannualreview
set reviewdate = '2021-12-01 05:00:00', updatedby = 'CDM-19809', updatedon = now()
where gapannualreviewid = 'd4da792b-b4ec-4785-9f99-360334402f11';