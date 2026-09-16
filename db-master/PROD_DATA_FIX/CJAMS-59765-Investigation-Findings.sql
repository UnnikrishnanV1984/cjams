/*
Issue:Dashboard:We need to fix the finding on this case as it was done in error. The finding should be Indicated.  
Root Cause:User request to change findings from unsubstantiated to Indicated, case was completed due to user do not have access to do that.
Fix Provided (Data Fix Only):Data fix was done by Updated investigationallegationmaltreators table and investigationfinding a record into routing table..
Data/Code fix ticket#: CJAMS-59765
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/


update investigationallegationmaltreators 
set    scdecisiontypekey ='ID',updatedby = 'CJAMS-59765',updatedon = now()
where investigationallegationmaltreatorsid ='4e036004-b98a-4a70-b890-071a7190d165' and activeflag=1;

update investigationfinding
set investigationfindingtypekey = 'ID',updatedby = 'CJAMS-59765',updatedon = now(),
findingcomments = 'Lyntoya (age 17) provided consistent disclosures that her father, Valentino Ferguson, has been molesting her since she was age 9, up to the most recent incident on or about 2/5/25. Lyntoya described how the sex acts progressed over the years. In a forensic interview on 2/7/25, Lyntoya reported her father "dragged" her down the stairs on 2/5/25, then pulled down her pants, and attempted to force Lyntoya to perform fellatio. Lyntoya disclosed she refused, so her father digitally penetrated her vagina and performed cunnillingus before her father ejaculated on the floor.  Lyntoya said afterwards she cleaned the floor where the semen was then went upstairs in her room and prayed under the covers and her father pulled the covers off of her head. Vaginal swab sample collected during Lyntoyas SAFE exam found that the DNA sample is consistent with Valentino Ferguson. Mr. Ferguson is criminally charged with sex abuse of minor and 2nd degree assault.'
where investigationfindingid  = '2f9e065c-7641-405a-8db2-96103f80f6bc' and activeflag =1;
