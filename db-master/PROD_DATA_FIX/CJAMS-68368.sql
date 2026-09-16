/*
   Issue Description: CJAMS-68368
   Category/ Module  : Annual Review date change
   Root cause: user wants to change gap annual date review
   Fix provided: Data fix is done to modify the gap annual date
   Is code fix required: N 
   Why no code fix is required: User error
   Status of the code fix if already submitted and expected prod fix date: 
*/

update gapannualreview
set reviewdate = '2026-02-14 15:00:00.000', updatedby = 'CJAMS-68368', updatedon = now()
where gapannualreviewid = '0791bc10-30f9-40cc-aedf-2d6e676d7046';
