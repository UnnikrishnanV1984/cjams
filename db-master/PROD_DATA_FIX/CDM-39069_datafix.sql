/*
   Issue Description: CDM-39069
   Category/ Module  : Assignments 
   Root cause:  unable to find 9 closed IR cases in the "Assign Case" tab to assign to  Appeals Coordinator
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update intakeservicerequest set isrouted=true,routedusersid='d6c2ad8f-ab3f-4420-9287-2aab0c338f48',responsibilitytypekey='family' where servicerequestnumber in ('211020153858','231020650631','211020160569','211020165799','221020264544','211020151673','211020165717','221020186028','211020160707')