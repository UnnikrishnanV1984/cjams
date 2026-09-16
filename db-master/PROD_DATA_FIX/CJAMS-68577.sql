/*
  Issue Description:  CJAMS-68577
   Category/ Module  :  Decision
   Root cause: user requested to change Indicated finding to unsubstantiated
   Fix provided: Data fix is done to modify the findings from indiacted to unsubstantiated
   Is code fox required : N 
   Reason why no related code fix: user error
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/


update investigationfinding
set investigationfindingtypekey = 'UD',
updatedby = 'CJAMS-68577',
    updatedon = now()
    where investigationfindingid ='b15b0cb6-d336-424c-b116-4227ea8c4f2c' and activeflag =1;