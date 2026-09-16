/*
   Issue Description: CJAMS-68620
   Category/ Module  : Annual Review date change
   Root cause: user wants to change gap annual date review start date, Primary Caregiver Sign Date and  Director Sign Date.
   Fix provided: Data fix is done to modify the gap annual date as 3/1/2026 and Primary Caregiver Sign Date and  Director Sign Date as 3/1/2026.
   Is code fix required: N 
   Why no code fix is required: User error
   Status of the code fix if already submitted and expected prod fix date: 
*/

update gapannualreview
set reviewdate = '2026-03-01 15:00:00.000',cgprimarydate ='2026-03-01 04:00:00.000',directorsigndate ='2026-03-01 04:00:00.000', 
updatedby = 'CJAMS-68620', updatedon = now()
where gapannualreviewid = '13b8091a-ef71-4822-97bc-748bc65bf1bc';