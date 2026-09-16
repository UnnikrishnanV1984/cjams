/*
   Issue Description: CJAMS-68755
   Category/ Module  :  Approval inbox
   Root Cause:  Issue is not replicable in stg3 env, Requested to  remove the cases from case pending dashboard of shaquan.brown@maryland.gov
   Fix provided: Data fix has been done to remove case from case pending dashboard
   Is code fix required: N
   Pull request for code fix: 
   Reason why no related code fix: 
   
*/


update routing set activeflag=0,
updatedby='CJAMS-68755',updatedon=now()
where objectid in ('5364b170-c571-4c9c-a289-17886af21302','8f30fa34-33a3-4dc2-be36-7781b126d4c1','d3da0255-7667-4a8a-a283-401ed7d056f2','998ea762-c434-4431-ad5e-a6ed50e62c2a',
'2f1ece2f-3c75-4845-b24f-7540ec95cf71','1272a8f3-aae4-4fa3-8256-36199b7fd70c') and activeflag=1;