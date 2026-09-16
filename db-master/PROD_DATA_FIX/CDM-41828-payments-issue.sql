/*
  Issue Description: CDM-41828 - Underpayment/overpayment.
  Root cause: Data fix needed to adjust the payment from 11/30/2023 as the payment needs to be adjusted accordingly.
            Client ID: 2574032 (Simon Boggs)
            Provider ID: 6005837 (WIlliam Boggs)
            Payment ID: 3855500
            Service Start & End Date: 11/01/2023 & 11/30/2023
            Category Code : Adoption Subsidy (7181 )
  Fix provided : Data fix done to update the payment date for the case 3172187
  Pull request# for code fix: N/A
  Reason why no related code fix: N/A 
  Status of the code fix if already submitted and expected prod fix date: N/A
  Backup before update/ delete: N/A
*/

update adoptioncaseagreementrate
set updatedby = 'CDM-41828',
	  updatedon = now()
where adoptionagreementrateid in ('6d4d67b0-6ac1-4eca-80ee-dbad260a4c07','31b6f551-a8b1-49d8-a6b9-50cc2ad4c0c0','0a40b310-be38-44e6-a82b-04584ffe2577','db6c28b3-ab41-4cf9-b8b7-94a8e601c74b','53ac4c49-8d5e-4564-8fee-a9a7e724d23f');
