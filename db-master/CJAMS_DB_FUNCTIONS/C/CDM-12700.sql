update intakeservicerequest set exitdate = null, intakeserreqstatustypeid = '52ad4cc7-e8f8-4cbb-9e27-d86f2b817690', updatedon= NOW(), updatedby='CDM-12700'
where intakeserviceid = '17cd0765-b514-4028-a1c9-ed390e807ed2';

update Intakeservicerequestdispositioncode set activeflag =0, updatedon =now(), updatedby ='CDM-12700', intakeserreqstatustypeid = null where intakeserviceid ='df513111-c7a2-47cc-ae58-b3d88f3be87a' and intakeservicerequestdispositioncodeid = '806ab2f5-3db5-448c-a19b-c5ef057374ab';