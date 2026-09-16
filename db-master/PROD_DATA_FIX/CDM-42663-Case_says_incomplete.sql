/*
  Issue Description:  CDM-42663
   Category/ Module  :  IVe-guardianship
   Root cause: The providerapporvalid was mapped with the wrong or the old providerapprovalid leading not to populate the co-applicant.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/
--SELECT * FROM tb_provider_approval WHERE provider_id = 5086689
update cjams.gapeligibilityinfo
set providerapprovalid = '80926',
	updatedby = 'CDM-42663',
	updatedon = now()
where providerapprovalid = '71979' and activeflag = 1;
