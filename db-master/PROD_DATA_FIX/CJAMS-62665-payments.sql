/*
Issue: CJAMS-62665 Back Payments
Category/Module: GAP
Root cause: Payments not generated as provider name and number was missing in the adoption subsidy page.
            Fix was done to add the provider information and we need to trigger the payments batch for this case.
Fix provided: Data fix has been done to trigger the missing payments for
              Provider ID: 6058218 (Renita Nicole Shaw)
              Client ID: 202067986 (William Cole FREEMAN)
              Case ID: 231040207303
Data/Code fix ticket#: CJAMS-62665
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: This is a due to missing information and data fix is done to trigger the payments batch.
*/
 
--Trigger missing Payments for the adoption case 231040207303

update adoptioncaseagreementrate
set updatedby = 'CJAMS-62665',
    updatedon = now()
where  adoptionagreementrateid in ('edabec5d-1283-4443-8b3b-c15c227a69e6','13f5c350-cc7c-45e7-92d9-f578a1b03316','7344b713-4cb7-4c3f-b8ce-df6f74548625')
and activeflag = 1;