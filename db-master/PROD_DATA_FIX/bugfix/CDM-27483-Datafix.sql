-- CDM-27483 - Wrong Investigation Findings Victims
/*
-- Issue Description: 
221020270565:Balendin and Litzy are not alleged victims and have been changed in the persons tab and maltreatment allegations tab, 
but they are still shown in the investigation findings tab.

-- Resolution: Need to delete Balendin and Litzy from the investigation findings tab

-- Category/ Module: Case Management
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A

*/

select 	activeflag, * 
from 	Investigationmaltreatment where maltreatmentid in ( 'de98955a-1964-45e7-9ec2-deb9f40df5c3',  '40633fcd-d25a-4f39-97a9-0fd392a04ef9', '5bcb047d-cbae-4a65-b5b7-1aa85fc8a16b');

update 	Investigationmaltreatment
set 	activeflag = 0,
		updatedby = 'CDM-27483',
		updatedon = now()
where 	maltreatmentid in ( 'de98955a-1964-45e7-9ec2-deb9f40df5c3',  '40633fcd-d25a-4f39-97a9-0fd392a04ef9', '5bcb047d-cbae-4a65-b5b7-1aa85fc8a16b');