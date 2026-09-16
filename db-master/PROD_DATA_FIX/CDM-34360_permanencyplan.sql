/* 
   Issue Description: CDM-34360
   Category/ Module  : Permanency Plan
   Root cause: user error
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   User requested to remove the Draft Permanency Plan as that created in error.
*/
UPDATE cjams.permanencyplan
SET  updatedon=now(), updatedby='CDM-34360', activeflag=0
WHERE permanencyplanid='f175c4de-8365-4161-a43e-0c052d30f8a1'::uuid and servicecaseid='532abae4-7dc3-47bc-96cf-7cd26db92cea';
