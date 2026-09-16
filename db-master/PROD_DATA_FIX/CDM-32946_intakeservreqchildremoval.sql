/*
   Issue Description: CDM-32946
   Category/ Module  :  Child Removal
   Root cause: Code fix is done as part of CDM-33194
   Pull request# for code fix: 
   Reason why no related code fix: 
   this is a defect raised from person merge 
*/

update intakeservreqchildremoval r
set removalcircumstances = (select rh.removalcircumstances from intakeservreqchildremoval_history rh where rh.rowtype = 'REVISION' and rh.intakeservreqchildremovalid = r.intakeservreqchildremovalid order by updatedon desc limit 1)
where intakeservreqchildremovalid in ('ed36346d-fb5d-4d96-b7d2-7cbdacce8cd1','48e805df-f8af-421c-9016-69f35114cf6c','1ff3dd55-6ce0-4e81-b5f8-8b7b220250ae',
'1e30124a-fb7d-4a67-a871-0577519d35df','58a4f0d6-d183-48c6-91af-428c08f1e92f','49468237-2481-4ebe-aa00-e43821808ac7',
'60f0d62a-ba5a-4af6-86cc-c868fdc97e7b','f52c3b3b-9b12-4cb6-9c71-9c91272f622c','fe75fd8f-d686-4da1-a2b7-5ab76dd60cf4',
'e93765bc-027e-496e-b8c1-cb9bb1d48e50');