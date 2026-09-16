/*
 * CDM-39495 - Supervisor not employed is still showing in supervisor dropdown list
 * Customer Email ID:theresa.kleppinger@maryland.gov
 * Description - Dashboard:Supervisor, Lisa Naumann, continues to show in the CPS and supervisor dropdown list of CJAMS. 
 * The employee was offboarded and removed from sailpoint and prior to that she was not assigned any approvals or cases in CJAMS. 
 *  there is no pending approval under the Case Pending Approval dashboard.
 * remove the supervisor from the supervisor dropdown as the supervisor has been leaving the agency.
 * supervisor email: lisa.naumann3@maryland.gov
 */

--select securityusersid, teammemberid, userid, * from v_userprofile where email  = 'lisa.naumann3@maryland.gov';
--780b2012-4a49-4e6d-9471-d1b2e4026c75
--72c4b22c-9060-47f5-9cbc-15e817b91c16
--38147

update
    teammember
set
    activeflag = '0',
    updatedby = 'CDM-39495',
    updatedon = now()
where
    teammemberid = '72c4b22c-9060-47f5-9cbc-15e817b91c16';

update
    teammemberassignment
set
    activeflag = '0',
    updatedby = 'CDM-39495',
    updatedon = now()
where
    securityusersid = '780b2012-4a49-4e6d-9471-d1b2e4026c75';

update
    muser
set
    activeflag = '0',
    updatedby = 'CDM-39495',
    updatedon = now()
where
    securityusersid = '780b2012-4a49-4e6d-9471-d1b2e4026c75';

update
    userprofile
set
    activeflag = '0',
    updatedby = 'CDM-39495',
    updatedon = now()
where
    securityusersid = '780b2012-4a49-4e6d-9471-d1b2e4026c75';

update
    rolemapping
set
    activeflag = '0',
    updatedby = 'CDM-39495',
    updatedon = now()
where
    principalid = '38147';

update
    securityusers
set
    activeflag = '0',
    updatedby = 'CDM-39495',
    updatedon = now()
where
    securityusersid = '780b2012-4a49-4e6d-9471-d1b2e4026c75';
    