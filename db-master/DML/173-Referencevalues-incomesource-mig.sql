
INSERT INTO referencevalues (ref_key, referencetypeid, value_text, description, activeflag, displayorder, mdmcode)
SELECT ref_key, referencetypeid, value_text, description, activeflag, displayorder, mdmcode  
FROM (
        SELECT 'DIN' ref_key ,191 referencetypeid,'Deemed Income' value_text,'Deemed Income' description,1 activeflag,17 displayorder,'DIN' mdmcode UNION ALL
        SELECT 'SSR',191,'Social Security Retirement','Social Security Retirement',1,18,'SSR' UNION ALL
        SELECT 'NE',191,'None - Earned','None - Earned',1,19,'NE' UNION ALL
        SELECT 'WIP',191,'WIC Payments','WIC Payments',1,20,'WIP' UNION ALL
        SELECT 'FGL',191,'Federal Grants/Loans','Federal Grants/Loans',1,21,'FGL' UNION ALL
        SELECT 'IVEP',191,'IV-E Payments','IV-E Payments',1,22,'IVE' UNION ALL
        SELECT 'SIN',191,'Student Income','Student Income',1,23,'SIN' UNION ALL
        SELECT 'OTHU',191,'Other - Unearned','Other - Unearned',1,24,'OTHU' UNION ALL
        SELECT 'OTHE',191,'Other - Earned','Other - Earned',1,25,'OTHE' UNION ALL
        SELECT 'TXM',191,'Title XIX - Medicaid','Title XIX - Medicaid',1,26,'TXM' UNION ALL
        SELECT 'SSI',191,'SSI/Supplemental Security Income','SSI/Supplemental Security Income',1,27,'SSI' UNION ALL
        SELECT 'SSD',191,'Social Security Disability Insurance','Social Security Disability Insurance',1,28,'SSD'
	) 	AS refval
WHERE (ref_key, referencetypeid,nulL ) NOT IN (SELECT ref_key, referencetypeid,teamtypekey FROM referencevalues);

