/*
   Issue Description: CDM-31284
   Category/ Module  : INVESTIGATION FINDINGS
   Root cause:user wants to update the Investigation Finding from Indicated to Unsubstantiated
 Need to do data fix :yes
*/ 
update tb_conv_inv_finding set investigation_finding_cd='Unsubstantiated' where referral_id='CW2291540' and inv_finding_id='267481';
				 	