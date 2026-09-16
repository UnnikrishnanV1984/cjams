/*
   Issue Description: CJAMS-68425
   Category/ Module  : Annual Review date change
   Root cause: user wants to change  Primary Caregiver Sign Date and  Director Sign Date .
   Fix provided: Data fix is done to modify the  Primary Caregiver Sign Date as 7/21/2026, Director Sign Date as 7/21/2026.
   Is code fix required: N 
   Why no code fix is required: User error
   Status of the code fix if already submitted and expected prod fix date: 
*/

update gapannualreview
set cgprimarydate ='2026-07-21 05:00:00.000',directorsigndate ='2026-07-21 05:00:00.000', 
updatedby = 'CJAMS-68425', updatedon = now()
where gapannualreviewid = 'ccd47d92-9040-4b43-b6ab-8cb2e762822d';