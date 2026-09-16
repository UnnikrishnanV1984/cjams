/*
   Issue Description: CDM-28474
   Category/ Module  : Over due Response Popup
   Root cause: .
   Pull request# for code fix: NA
*/

UPDATE cjams.cpsresponsetimeractions
SET  updatedby='CDM-28474', updatedon=now(), activeflag=0
WHERE cpsresponsetimeractionsid='981e3e8f-adf2-4c21-82a7-5c83e9d333bc' and intakeserviceid='62f0029a-ddd3-42f2-83fd-5876dd1be526';
