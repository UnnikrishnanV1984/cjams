/*
   Issue Description: CJAMS-68615
   Category/ Module  : Annual Review date change
   Root cause: user wants to change gap annual date review start date, Primary Caregiver Sign Date and  Director Sign Date and econdary Caregiver Sign .
   Fix provided: Data fix is done to modify the Annual Review Date as 2/1/2026, Primary Caregiver Sign Date as 2/1/2026, Director Sign Date as 2/1/2026, Secondary Caregiver Sign Date as Blank.
   Is code fix required: N 
   Why no code fix is required: User error
   Status of the code fix if already submitted and expected prod fix date: 
*/

update gapannualreview
set reviewdate = '2026-02-01 15:00:00.000',cgprimarydate ='2026-02-01 05:00:00.000',cgsecondarydate =null ,directorsigndate ='2026-02-01 05:00:00.000', 
updatedby = 'CJAMS-68615', updatedon = now()
where gapannualreviewid = 'ec1a6205-5887-490b-b3db-7f190579020b';