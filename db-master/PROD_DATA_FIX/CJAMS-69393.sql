/*
Issue Description: CJAMS-69393 - Person mixed up
Category/Module: Person Profile
Referral: 251023088732
Root cause: On 07/11/2025 the user updated the person record with the wrong child's name and dob. The CJAMS
   PID 3800148 belongs to Immanuel Moore, but the name on the record was changed to Kayin Parran and the dob
   was changed to 11/15/2016. The referral 251023088732 is correctly connected to this person, only the name
   and dob on the person record are wrong.
Fix provided: Data fix to correct the name back to Immanuel Moore and the dob back to 05/01/2015 for CJAMS
   PID 3800148 as requested by the user.
Regression Impacts: N/A
Is Code fix Required?: NO
Code fix ticket#: N/A
Reason why no related code fix: User error
*/

update person
set firstname = 'Immanuel',
	lastname = 'Moore',
	dob = '2015-05-01 00:00:00',
	updatedby = 'CJAMS-69393',
	updatedon = now()
where personid = '698f3688-22ea-410e-b2a3-c4d328e12ba7'
	and cjamspid = '3800148'
	and activeflag = 1;