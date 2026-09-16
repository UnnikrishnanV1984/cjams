/*
 * CDM-35411 - SEN error
 * Customer Email ID:sherylann.brayboy@maryland.gov
 * Customer Name:Sherylann Brayboy
 * Intake I231011452875
 * The SEN checkbox is not selected under the client profile's (VALESKA Gibson / CJAMS PID # 202132679) 
 * but the SEN checkbox is selected under the SDM tab.
 * 
 */

-- select substanceexposednewbornflag, * from  person where personid = '85e936dd-8b15-4e68-a0a6-cb6fb1c07b77';
-- UPDATE cjams.person
-- SET substanceexposednewbornflag=1, updatedby='CDM-35411', updatedon=now() 
-- WHERE personid='85e936dd-8b15-4e68-a0a6-cb6fb1c07b77';

--select * from cjams.getservicecasesdm('07c79251-e8c8-4ac8-af86-e7241cf67093');
--select * from intakeservicerequest where servicecaseid = '07c79251-e8c8-4ac8-af86-e7241cf67093';
--select drugexposednewbornflag, isnegrh_basicneedsunmet, * from intakeservicerequestsdm where intakeserviceid = '19ab662a-60a4-4932-8244-03813a33f9c5';

UPDATE cjams.intakeservicerequestsdm
SET drugexposednewbornflag=0, isnegrh_basicneedsunmet=true, updatedby='CDM-35411', updatedon=now() 
WHERE intakeservicerequestsdmid='e66d3df5-05c0-46ca-97a7-81f4b088d7c6'::uuid;



