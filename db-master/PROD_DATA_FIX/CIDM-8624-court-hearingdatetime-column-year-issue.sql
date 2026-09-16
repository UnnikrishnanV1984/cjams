/*
   Issue Description: CIDM-8624
   Category/ Module  : Hearing date change.
   Service Case: 3290069
   Root cause: User has entered the wrong date ie., 20023.
   Fix: data fix promoted to update the year from 20023 to 2023
   Fix Provided: 
*/

-- Backup
select hearingdatetime,* from Cjams.Intakeservicerequestcourthearing where Intakeservicerequestcourthearingid='e8da15d0-d379-462b-b979-574c3ce58dea';

-- Updation
update Intakeservicerequestcourthearing set hearingdatetime='2023-07-12 08:00:00.000', updatedby ='CIDM-8624', updatedon = now() where Intakeservicerequestcourthearingid='e8da15d0-d379-462b-b979-574c3ce58dea';