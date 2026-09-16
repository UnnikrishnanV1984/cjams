/*
Issue Description: CJAMS-69395 - Name mix up
Category/Module: Person Profile
Referral: 251023088735
Root cause: On 07/11/2025 the user updated the person record with the wrong child's name and dob. The CJAMS
   PID 204176847 belongs to Kayin Parran, but the name on the record was changed to Immanuel Moore and the dob
   was changed to 05/01/2015. The referral 251023088735 is correctly connected to this person, only the name
   and dob on the person record are wrong.
Fix provided: Data fix to correct the name back to Kayin Parran and the dob back to 11/15/2016 for CJAMS
   PID 204176847 as requested by the user.
Regression Impacts: N/A
Is Code fix Required?: NO
Code fix ticket#: N/A
Reason why no related code fix: User error
*/

update person
set firstname = 'Kayin',
	lastname = 'Parran',
	dob = '2016-11-15 00:00:00',
	updatedby = 'CJAMS-69395',
	updatedon = now()
where personid = '9aa4a6af-616c-4fd8-aa62-6fd2c475a559'
	and cjamspid = '204176847'
	and activeflag = 1;