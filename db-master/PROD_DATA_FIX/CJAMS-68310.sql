/*
   Issue Description: CJAMS-68310
   Category/ Module  : Annual Review date change
   Root cause: user wants to change gap annual date review
   Fix provided: Data fix is done to modify the gap annual date
   Is code fix required: N 
   Why no code fix is required: User error
   Status of the code fix if already submitted and expected prod fix date: 
*/

update gapannualreview
set reviewdate = '2025-07-21 04:00:00.000', updatedby = 'CJAMS-68310', updatedon = now()
where gapannualreviewid = '860c2bf1-ee0a-4052-acae-d6d44435571c';