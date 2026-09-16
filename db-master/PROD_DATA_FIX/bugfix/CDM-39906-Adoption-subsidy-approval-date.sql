/*
  Issue Description: CDM-39906 Adoption Subsidy Dates Inaccurate. The Annual review record dated: 07/26/2024 is actually last year record 
                     (07/26/2023) and somehow the date is changed to 07/26/2024
  Category/ Module : Adoption subsidy
  Root cause: Data fix requested to change the review record date from 07/26/2024 to 07/26/2023 as it was created incorrectly by the user.
  Fix Provided: Data fix has been promoted to change the review date from 07/26/2024 to 07/26/2023.
  Pull request# for code fix: N/A
  Reason why no related code fix: N/A
  Status of the code fix if already submitted and expected prod fix date: N/A
  Backup before update/ delete: N/A
*/

update adoptioniverenewal 
set assessmentdate = '2023-07-26 04:00:00',
	updatedby = 'CDM-39906',
	updatedon = now()
where adoptioniverenewalid = 'f2a35c67-57f6-4267-a174-ad89fc6e137e'
and assessmentdate = '2024-07-26 04:00:00';