/*
   Issue Description: CDM-31399
   Category/ Module  : 
   Root cause:user need to Remove the OOH  end date and Change the caseworker name
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    . Need to do data fix
*/

update cjams.personprogramarea set enddate=null,updatedby='7dfc12b8-8342-48bc-9e20-ef2a313dd491', updatedon=now() where personprogramid='808bd03b-0ab9-44c9-bbba-73e31baff022';


update cjams.personprogramarea set enddate=null,updatedby='7dfc12b8-8342-48bc-9e20-ef2a313dd491', updatedon=now() where personprogramid='ff9ff348-1085-41bf-bf28-2160fbe792fd';


update intakeservreqchildremoval_history set  modifieddata = replace(modifieddata::text, 'Mary Jo Barnhart', 'Lori Pfreiffer')::jsonb ,updatedon=now()
  where  intakeservreqchildremovalhistoryid='7cc7c50b-b2d8-4fdd-90a8-0d61fa9a3d03';


update intakeservreqchildremoval_history set  modifieddata = replace(modifieddata::text, 'Amanda Reiblich', 'Lori Pfreiffer')::jsonb ,updatedon=now()
  where  intakeservreqchildremovalhistoryid='ee40aae3-73e9-4b6d-8476-a2d150f000dd';