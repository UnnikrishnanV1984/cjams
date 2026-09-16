 
 /*
   Issue Description: CDM-18870
   Category/ Module  : User asked to remove assessment
   Root cause: user can able to delete now, perhaps a training issue
   Pull request# for code fix: 
   Explanantion: user wants to delete the assessment record which is not needed
*/
--select * from cjams.updateassessment(v_assessmentid, v_updatedby);
 
 
 select * from cjams.updateassessment('0d73123e-d557-4b9a-80a2-07611494c523', 'CDM-18870');
