
/*
Issue Description: CDM-18419 -Error
   Category/ Module  :  Provider note 
   Root cause:  User wants to update the contact type and location
   Pull request# for code fix:  4169
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
                            progressnotesubtypeid - 87e6906c-93b7-43d3-a906-3411ecb3cf06
                            progressnotetypeid - b83d8c25-f7db-4816-87f4-35a657790ad4
*/
update ProgressNote set progressnotesubtypeid = '85068ce8-556d-4e6b-8592-9d4d0582f512' , progressnotetypeid = '8d25a26b-91a1-4423-947e-e451e8eff6b7',
updatedby = 'CDM-18419', updatedon = now()
where progressnoteid = '697dae24-c0bd-46cb-af3f-616af9c71eaf' and activeflag = 1; 