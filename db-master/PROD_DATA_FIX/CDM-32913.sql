/*
 * CDM-32913 - CJAMS profile
 * Customer Email ID:kelly.beswick@maryland.gov
 * Customer Name:Kelly Beswick
 * Focus Area:Case Timeline
 * Description - 231020535095:The worker has a profile that is not in Sailpoint but is shown on the intake assignement screen. 
 * She cannot see cases that are assigned to this profile nor can supervisors find this profile if a case is incorrectly assigned 
 * under this profile. It is the LGA profile. We have no access to this catagory and if accidentally assigned a case under 
 * this profile no one can see the case. 
 * Case # 231020535095, 231030068658, 231030120093 
 * */

update caseassignment 
set toteamid ='d5abb69f-8086-4645-bb56-5ef8825d412d',
updatedby ='CDM-32913',
updatedon =now() 
where caseassignmentid  ='9b3cd344-0223-4d43-b9cf-89b5bdfee8af';

update caseassignment 
set toteamid ='d5abb69f-8086-4645-bb56-5ef8825d412d',
updatedby ='CDM-32913',
updatedon =now() 
where caseassignmentid  ='eda8e7d1-3165-406e-b0ed-dce7e4a1dfec';

update caseassignment 
set toteamid ='d5abb69f-8086-4645-bb56-5ef8825d412d',
updatedby ='CDM-32913',
updatedon =now() 
where caseassignmentid  ='7deebdac-75dd-4e98-84fc-828e21c5eacd';
