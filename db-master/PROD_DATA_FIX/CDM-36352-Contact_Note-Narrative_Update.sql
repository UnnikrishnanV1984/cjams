/*
-- CDM-36352 - Contact Note
-- Issue Description: 3113680: Supervisor entered incorrect narrative of another family's information into case. 
		      The contact note is from 11/30/23 entered by Christine Whitworth at 10:25am.
-- Case ID: S2024008056093
-- Category / Module: Contact / Notes
-- Root cause: User Error, incorrect narrative entered. Customer shared the correct narrative to proceed with data fix.
-- Fix Provided:  updated Intakeservicerequest with narrative to customer given info. # S2024008056093
-- Pull Request# N/A
*/

update cjams.Intakeservicerequest 
set narrative = '<p>Case Head: Keyon David Robinson, Sr. (DOB 06/25/1991)</p><p>2428 Baker St.</p><p>Baltimore, Md.</p><p>443-704-7530</p><p><br></p><p>Reporter: Casey Davis, RN</p><p>St. Agnes hospital</p><p>900 Caton Ave.</p><p>Baltimore, Md. 21229</p><p>410-368-2011</p><p><br></p><p>Child: Keyon Davis, Jr. (DOB 11/13/2016)</p><p><br></p><p>Family was displaced by a fire and continue to reside in a hotel. The family has changed hotels due to the change in rate sometimes daily or weekly. They initially received assistance from the Red Cross, but have been able to maintain the hotel with their family income. Children are doing the best they can under the circumstances, but continue to struggle with locating housing to meet the family size in their price range. The department is trying to assist the family with the childrens insurance as Keyons is not active. We will continue to coordinate with the FIA department. LDSS has paid for medication due to the child insurance not being active. It is necessary to ensure that he receives all the services that he is referred to for his medical needs and mental health. All of the children are doing well, but it is a lot on Ms. Lucas as she is also assisting her adult daughter and grandchildren as well. The LDSS will continue to monitor and complete services tasks to meet family needs.</p><p><br></p><p>**See Contact Notes</p>' 
where intakeserviceid = '47d6456d-c6e2-4fce-9d5b-6ce02b9115bd';