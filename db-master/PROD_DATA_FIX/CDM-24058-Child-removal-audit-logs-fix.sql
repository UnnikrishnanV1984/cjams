/*
   Issue Description: CDM-24058
   Category/ Module  : 
   3273193:On the audit log section of the child removal history, 
   the listed approver is not a member of Allegany County staff. 
   Name listed as the approver is Jamie Martin. That is incorrect.
   Root cause: user added wrong child to the intakecase
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

---Case # 3273193 Client ID: 4038354

update intakeservreqchildremoval_history set modifieddata ='{
  "status": "Updated",
  "data": [
    {
      "key": "approvedby",
      "new_value": "charlene platter",
      "old_value": null,
      "display_name": "Approved By"
    },
    {
      "key": "approvedon",
      "new_value": "2022-04-27T20:15:04.771Z",
      "old_value": null,
      "display_name": "Approved On"
    },
    {
      "key": "status",
      "new_value": "Approved",
      "old_value": null,
      "display_name": "Status"
    }
  ]
}'where  intakeservreqchildremovalhistoryid ='6948f55b-bbef-4ed5-bb9d-56161c9f0341';

--Case # 3283990 Client Name: Christian Harmon Client ID: 4184556

update intakeservreqchildremoval_history set modifieddata = '{
  "status": "Updated",
  "data": [
    {
      "key": "submittedby",
      "new_value": "Lori Pfeiffer",
      "old_value": null,
      "display_name": "Submitted By"
    },
    {
      "key": "submittedon",
      "new_value": "2022-03-30T12:22:01.227Z",
      "old_value": null,
      "display_name": "Submitted On"
    },
    {
      "key": "status",
      "new_value": "Review",
      "old_value": null,
      "display_name": "Status"
    }
  ]
}'where intakeservreqchildremovalhistoryid ='58ac7030-210d-4213-a716-a5f88e9d54f8';

---Client Name: Dylan Umstead Client ID: 200313269
update intakeservreqchildremoval_history set modifieddata = '{
  "status": "Updated",
  "data": [
    {
      "key": "approvedby",
      "new_value": "charlene platter",
      "old_value": null,
      "display_name": "Approved By"
    },
    {
      "key": "approvedon",
      "new_value": "2022-03-30T12:25:34.994Z",
      "old_value": null,
      "display_name": "Approved On"
    },
    {
      "key": "status",
      "new_value": "Approved",
      "old_value": null,
      "display_name": "Status"
    }
  ]
}'where intakeservreqchildremovalhistoryid ='ad1cafbb-4a9f-4390-92e2-499648492eda';

---Case # 3215145 Client Name: Joselynn K Jennings Client ID: 3649147

update intakeservreqchildremoval_history set modifieddata = '{
  "status": "Updated",
  "data": [
    {
      "key": "approvedby",
      "new_value": "Stephanie Blank",
      "old_value": null,
      "display_name": "Approved By"
    },
    {
      "key": "approvedon",
      "new_value": "2022-07-18T14:32:10.198Z",
      "old_value": null,
      "display_name": "Approved On"
    },
    {
      "key": "status",
      "new_value": "Approved",
      "old_value": null,
      "display_name": "Status"
    }
  ]
}' where intakeservreqchildremovalhistoryid ='25a5e7cc-82b0-4420-883c-34570bb874f9';


update intakeservreqchildremoval_history set modifieddata = '{
  "status": "Updated",
  "data": [
    {
      "key": "submittedby",
      "new_value": "Lori Pfeiffer",
      "old_value": null,
      "display_name": "Submitted By"
    },
    {
      "key": "submittedon",
      "new_value": "2022-07-18T14:12:04.738Z",
      "old_value": null,
      "display_name": "Submitted On"
    },
    {
      "key": "status",
      "new_value": "Review",
      "old_value": null,
      "display_name": "Status"
    }
  ]
}' where intakeservreqchildremovalhistoryid ='95d7744f-6b6b-488d-b08d-742b2cbce41b';


--Client Name: Makadam Allen James Client ID: 200007112

update intakeservreqchildremoval_history set modifieddata = '{
  "status": "Updated",
  "data": [
    {
      "key": "approvedby",
      "new_value": "Lori Pfeiffer",
      "old_value": null,
      "display_name": "Approved By"
    },
    {
      "key": "approvedon",
      "new_value": "2022-07-18T14:32:59.032Z",
      "old_value": null,
      "display_name": "Approved On"
    },
    {
      "key": "status",
      "new_value": "Approved",
      "old_value": null,
      "display_name": "Status"
    }
  ]
}' where intakeservreqchildremovalhistoryid ='1ef40e34-a64e-4b4f-aa47-c05a8dd54c85';




update intakeservreqchildremoval_history set modifieddata = '{
  "status": "Updated",
  "data": [
    {
      "key": "submittedby",
      "new_value": "Stephanie Blank",
      "old_value": null,
      "display_name": "Submitted By"
    },
    {
      "key": "submittedon",
      "new_value": "2022-07-18T14:21:58.163Z",
      "old_value": null,
      "display_name": "Submitted On"
    },
    {
      "key": "status",
      "new_value": "Review",
      "old_value": null,
      "display_name": "Status"
    }
  ]
}'where intakeservreqchildremovalhistoryid ='a81ceb4d-42d3-403e-94e4-bb69b6f5d0e2';


