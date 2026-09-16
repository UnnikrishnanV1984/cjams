/*
 * CDM-35284 - Bug
 * Customer Email ID:katie.hitch@maryland.gov
 * Customer Name:Katie Hitch
 * Focus Area:Services: Youth Transition Plan
 * Description - 2020025302923:This youth's transition plan is showing that he has employment. However, he does not have employment. 
 * All of his prior employment has been end-dated in his persons tab, so there is no reason why his youth transition plan should show that he has a job. 
 * There is no way for me to manually delete this job off of his youth transition plan to reflect his current state of being unemployed. 
 * 
 */
 

-- select employment_json , new_employ_json,* from youthtransitionplan where clientid='968a6de6-47ce-4bbb-930c-9d44c844ba0b' and 
-- intakeserviceid='a4b68bbe-5f8f-48d7-ad9f-14d4ac3f8a09' and new_employ_json is not null;

UPDATE cjams.youthtransitionplan
SET new_employ_json=NULL, updatedby ='CDM-35284', updatedon =now() 
where clientid='968a6de6-47ce-4bbb-930c-9d44c844ba0b' and 
intakeserviceid='a4b68bbe-5f8f-48d7-ad9f-14d4ac3f8a09' and new_employ_json is not null;
