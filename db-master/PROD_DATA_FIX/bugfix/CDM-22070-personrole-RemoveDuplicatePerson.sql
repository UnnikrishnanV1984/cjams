-- CDM-22070-Duplicate maltreator in persons tab
/*
   File Name: CDM-22070-personrole-RemoveDuplicatePerson
-- Issue Description: 
    For the intakenumber 221020203057 and case 221020203057 -  In the Person's other Tab User is seeing Duplicate Persons Added
    Customer Email ID:lindseya.peek@maryland.gov
  
-- Resolution: Updated the personrole's, activeflag Column to zero

-- Category/ Module: Case Management
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A

*/

update
	personrole
set
	activeflag = 0,
	updatedon = now(),
	updatedby = 'CDM-22070'
where
	personroleid in ('95c64968-87ce-468c-a179-cb851633064c', 'feced9d8-6817-4669-97b4-fcd7660361f7')
	and personid = '6141f5d1-dc40-4dd9-b353-ba3dda82f103'
	and  intakeserviceid = 'ceed6044-1392-4831-ac8e-55244be0b558'
	and activeflag = 1;