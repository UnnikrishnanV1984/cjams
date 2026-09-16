/*
   Issue Description: CJAMS-69789
   Category/ Module  : Delete intake
  Root Cause: User reported that the intake was incorrectly created with the persons switched/mixed together.
Fix Type: Data fix to delete intake I261014143693 as requested.
Is Code Fix Required: N
Reason Why No Related Code Fix: User/intake data error; no application code issue identified.
*/

select * from CW_transactions_dataclenup('INTKE','I261014143693','CJAMS-69789');