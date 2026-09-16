/*
  Issue Description:  CDM-42143
   Category/ Module  :  Assignments
   Root cause: User request to Data fix to remove the employees from CJAMS
   Pull request# for code fix: NA
   Reason why no related code fix: For deactivating the users from CJAMS data fix is needed
   Status of the code fix if already submitted and expected prod fix date: NO
   Backup before update/ delete: NA
*/

update userprofile set activeflag = '0', updatedby = 'CDM-42143', updatedon = now()
where securityusersid in ('81528ded-d8de-46db-afcf-10ae4a1f66af','f16be3da-6663-4603-97be-7bb567af7e49')
and activeflag = 1;

update muser set activeflag = '0', updatedby = 'CDM-42143', updatedon = now()
where securityusersid in ('81528ded-d8de-46db-afcf-10ae4a1f66af','f16be3da-6663-4603-97be-7bb567af7e49')
and activeflag = 1;

update securityusers set activeflag = '0',updatedby = 'CDM-42143', updatedon = now()
where securityusersid in('81528ded-d8de-46db-afcf-10ae4a1f66af','f16be3da-6663-4603-97be-7bb567af7e49')
and activeflag = 1;

update teammemberassignment
set activeflag = '0', updatedby = 'CDM-42143', updatedon = now()
where securityusersid in ('81528ded-d8de-46db-afcf-10ae4a1f66af','f16be3da-6663-4603-97be-7bb567af7e49')
and activeflag = 1;

UPDATE teammember
    SET activeflag = 0,
        updatedby = 'CDM-42143',
        updatedon = now()
    WHERE teammemberid in ('043ca00d-093a-4cc1-b3fc-2f412f9555b9','9d29df2d-e2c4-466c-be12-1c537aa4c0b5') 
    and activeflag = 1;


update rolemapping set activeflag = '0', updatedby = 'CDM-42143', updatedon = now()
where principalid in ('14902','15000') and activeflag = 1;