/*
Issue Description: The last 900+ Case Plan listed for youth, Michael Thompson (CJAMS PID #4146230; Case #3281022) should read 12/22/2023 6/11/2024 and not 6/24/2023-6/11/2024. Foster Care Supervisor, Megan Murphy approved the Case Plan for the worker, but noted the dates auto populated incorrectly. Please correct the dates to reflect 12/22/2023 - 6/11/2024
Category/ Module :BUG
Root cause: error in data entry
Fix provided: Yes, write DB query.
Code fix ticket#: CDM-39990
Reason why no related code fix: Status of the code fix already submitted 
Status of the code fix if already submitted and expected prod fix date: 
void the rejected provider placement from backend
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/


update snapshothist
set
   fromdate = '2023-12-22',
   updatedby = 'CDM-39990',
   updatedon = now()
   where 
      id = 'bc1fc2d2-366d-494a-8659-4ff56fb51c89' and activeflag = 1;