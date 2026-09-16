-- CDM-20459 - Initial Adoption Cases
/*
-- Issue Description: 
    User not able to complete the 11 Adoption Cases listed below due to the children being adopted before the Applicable Child Assessment was completed in CJAMS

-- Resolution: the data fix for ACA decision for all these cases as 'Neither an applicable nor an applicable' 

-- Category/ Module: IVE
-- Root cause: N/A
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A

-- Child				cjamspid	bioclientId	
-- Ashton Curley		200780234	3246892	
-- Dannell Eggleston	200666323	3490662	
-- Rio Hayes			200669241	3978690	
-- Robert Everett-Creighton	200150343	3966552	Audit data not available
-- Jayden Jackson		200296499	4028570	
-- Aniyah Strozier		200168390	3871153	
-- Sabrina Torsell		4493902		3455460	Audit data not available
-- Jazmine Harvey		4493893		4133966	Audit data not available
-- Journee Bryant		4493890		4245522	Audit data not available
-- Kamden Wooding		4471828		4229762	Audit data not available
-- Harleigh Reavis		200143548	4183843	Audit data not available

*/

--Ashton Curley cjamspid: 200780234  bio clientid: 3246892
select 	cjamspid, adoptionauditid, adoptionacasubmitted, adoptionapplicable, adoptionnonapplicable, applicableandnonapplicable, neitheranappnornonappchildfortitleivepurposes , updatedby, updatedon
from 	tb_ive_adoption_audit tiaa 
where 	tiaa.category = 'A' and tiaa.cjamspid in (3246892) order by  tiaa.insertedon desc limit 1;

update 	tb_ive_adoption_audit
set 	adoptionacasubmitted = true, 
		adoptionapplicable = 'NO', 
		adoptionnonapplicable = 'NO',
		applicableandnonapplicable = 'NO', 
		neitheranappnornonappchildfortitleivepurposes = 'YES',
		updatedby = 'CDM-20459',
		updatedon = now()
where 	adoptionauditid = 1989;

--Dannell Eggleston cjamspid: 200666323  bio clientid: 3490662
select 	cjamspid, adoptionauditid, adoptionacasubmitted, adoptionapplicable, adoptionnonapplicable, applicableandnonapplicable, neitheranappnornonappchildfortitleivepurposes , updatedby, updatedon
from 	tb_ive_adoption_audit tiaa 
where 	tiaa.category = 'A' and tiaa.cjamspid in (3490662) order by  tiaa.insertedon desc limit 1;

update 	tb_ive_adoption_audit
set 	adoptionacasubmitted = true, 
		adoptionapplicable = 'NO', 
		adoptionnonapplicable = 'NO',
		applicableandnonapplicable = 'NO', 
		neitheranappnornonappchildfortitleivepurposes = 'YES',
		updatedby = 'CDM-20459',
		updatedon = now()
where 	adoptionauditid = 1992;

--Rio Hayes cjamspid: 200669241  bio clientid: 3978690
select 	cjamspid, adoptionauditid, adoptionacasubmitted, adoptionapplicable, adoptionnonapplicable, applicableandnonapplicable, neitheranappnornonappchildfortitleivepurposes , updatedby, updatedon
from 	tb_ive_adoption_audit tiaa 
where 	tiaa.category = 'A' and tiaa.cjamspid in (3978690) order by  tiaa.insertedon desc limit 1;

update 	tb_ive_adoption_audit
set 	adoptionacasubmitted = true, 
		adoptionapplicable = 'NO', 
		adoptionnonapplicable = 'NO',
		applicableandnonapplicable = 'NO', 
		neitheranappnornonappchildfortitleivepurposes = 'YES',
		updatedby = 'CDM-20459',
		updatedon = now()
where 	adoptionauditid = 2028;

--Robert Everett-Creighton cjamspid: 200150343  bio clientid: 3966552
select 	cjamspid, adoptionauditid, adoptionacasubmitted, adoptionapplicable, adoptionnonapplicable, applicableandnonapplicable, neitheranappnornonappchildfortitleivepurposes , updatedby, updatedon
from 	tb_ive_adoption_audit tiaa 
where 	tiaa.category = 'A' and tiaa.cjamspid in (3966552) order by  tiaa.insertedon desc limit 1;
-- APPLICABILITY DECISION tab is not available - Audit data not available


--Jayden Jackson cjamspid: 200296499  bio clientid: 4028570
select 	cjamspid, adoptionauditid, adoptionacasubmitted, adoptionapplicable, adoptionnonapplicable, applicableandnonapplicable, neitheranappnornonappchildfortitleivepurposes , updatedby, updatedon
from 	tb_ive_adoption_audit tiaa 
where 	tiaa.category = 'A' and tiaa.cjamspid in (4028570) order by  tiaa.insertedon desc limit 1;

update 	tb_ive_adoption_audit
set 	adoptionacasubmitted = true, 
		adoptionapplicable = 'NO', 
		adoptionnonapplicable = 'NO',
		applicableandnonapplicable = 'NO', 
		neitheranappnornonappchildfortitleivepurposes = 'YES',
		updatedby = 'CDM-20459',
		updatedon = now()
where 	adoptionauditid = 346;

--Aniyah Strozier cjamspid: 200168390  bio clientid: 3871153
select 	cjamspid, adoptionauditid, adoptionacasubmitted, adoptionapplicable, adoptionnonapplicable, applicableandnonapplicable, neitheranappnornonappchildfortitleivepurposes , updatedby, updatedon
from 	tb_ive_adoption_audit tiaa 
where 	tiaa.category = 'A' and tiaa.cjamspid in (3871153) order by  tiaa.insertedon desc limit 1;

update 	tb_ive_adoption_audit
set 	adoptionacasubmitted = true, 
		adoptionapplicable = 'NO', 
		adoptionnonapplicable = 'NO',
		applicableandnonapplicable = 'NO', 
		neitheranappnornonappchildfortitleivepurposes = 'YES',
		updatedby = 'CDM-20459',
		updatedon = now()
where 	adoptionauditid = 263;

--Sabrina Torsell cjamspid: 4493902  bio clientid: 3455460
select 	cjamspid, adoptionauditid, adoptionacasubmitted, adoptionapplicable, adoptionnonapplicable, applicableandnonapplicable, neitheranappnornonappchildfortitleivepurposes , updatedby, updatedon
from 	tb_ive_adoption_audit tiaa 
where 	tiaa.category = 'A' and tiaa.cjamspid in (3455460) order by  tiaa.insertedon desc limit 1;
-- Audit data not available


--Jazmine Harvey cjamspid: 4493893  bio clientid: 4133966
select 	cjamspid, adoptionauditid, adoptionacasubmitted, adoptionapplicable, adoptionnonapplicable, applicableandnonapplicable, neitheranappnornonappchildfortitleivepurposes , updatedby, updatedon
from 	tb_ive_adoption_audit tiaa 
where 	tiaa.category = 'A' and tiaa.cjamspid in (4133966) order by  tiaa.insertedon desc limit 1;

-- Audit data not available

--Journee Bryant cjamspid: 4493890  bio clientid: 4245522
select 	cjamspid, adoptionauditid, adoptionacasubmitted, adoptionapplicable, adoptionnonapplicable, applicableandnonapplicable, neitheranappnornonappchildfortitleivepurposes , updatedby, updatedon
from 	tb_ive_adoption_audit tiaa 
where 	tiaa.category = 'A' and tiaa.cjamspid in (4245522) order by  tiaa.insertedon desc limit 1;
-- Audit data not available

--Kamden Wooding cjamspid: 4471828  bio clientid: 4229762
select 	cjamspid, adoptionauditid, adoptionacasubmitted, adoptionapplicable, adoptionnonapplicable, applicableandnonapplicable, neitheranappnornonappchildfortitleivepurposes , updatedby, updatedon
from 	tb_ive_adoption_audit tiaa 
where 	tiaa.category = 'A' and tiaa.cjamspid in (4229762) order by  tiaa.insertedon desc limit 1;

-- Audit data not available


--Harleigh Reavis cjamspid: 200143548  bio clientid: 4183843
select 	cjamspid, adoptionauditid, adoptionacasubmitted, adoptionapplicable, adoptionnonapplicable, applicableandnonapplicable, neitheranappnornonappchildfortitleivepurposes , updatedby, updatedon
from 	tb_ive_adoption_audit tiaa 
where 	tiaa.category = 'A' and tiaa.cjamspid in (4183843) order by  tiaa.insertedon desc limit 1;

-- Audit data not available
