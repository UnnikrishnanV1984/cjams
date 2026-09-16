/*
 * CDM-36974 - Case assignement
 * Customer Email ID:joice.silva@montgomerycountymd.gov
 * Description - 211020148120:Please assign case to Appeal worker (myself) to complete the appeal process and finalize the case. 
 * The appeal was resolved recently but the case was never assigned to appeal worker, therefore, the case cannot be completed. 
 * 
*/

--select isrouted, * from intakeservicerequest where intakeserviceid = '5f87735f-8b19-47c7-be56-746ef342f61f';
UPDATE cjams.intakeservicerequest
SET isrouted=true, updatedby= 'CDM-36974', updatedon= now() 
WHERE intakeserviceid='5f87735f-8b19-47c7-be56-746ef342f61f';

