delete from audittraillukup where typekey = 'personimmunization';
insert into audittraillukup(typekey,historytablename,primarykeyname,fieldjson,activeflag,insertedby,insertedon,updatedby,updatedon)
values ('personimmunization','personimmunization_history','personimmunizationid', '[
    {
        "displayname": "Vaccine Name",
        "key": "personimmunizationconfigid",
        "alias": "vaccinename",
        "skipcomparison":"true",
        "query": "SELECT pic.value_text FROM personimmunizationconfig pic INNER JOIN personimmunization pi ON pic.personimmunizationconfigid = pi.personimmunizationconfigid WHERE pi.personimmunizationid = "
    },
    {
        "displayname": "Immunization Date",
        "key": "immunizationdate",
        "alias": "immunizationdate"
    },
    {
        "displayname": "Record Status",
        "key": "recordstatus",
        "alias": "recordstatus"
    },
    {
        "displayname": "Inserted By",
        "key": "insertedby",
        "alias": "insertedby",
        "query": "SELECT coalesce(u.fullname,pi.insertedby) FROM personimmunization pi LEFT JOIN userprofile u on u.securityusersid = pi.insertedby where pi.personimmunizationid = ",
        "query2": " order by pi.insertedon desc limit 1"
    },
    {
        "displayname": "Updated By",
        "key": "updatedby",
        "alias": "updatedby",
        "query": "SELECT coalesce(u.fullname,pi.updatedby) FROM personimmunization pi LEFT JOIN userprofile u on u.securityusersid = pi.updatedby where pi.personimmunizationid = ",
        "query2": " order by pi.updatedon desc limit 1"
    },
    {
        "displayname": "Updated Date and Time",
        "key": "updatedon",
        "alias": "updatedon"
    },    
    {
        "displayname": "More Information",
        "key": "comments",
        "alias": "comments"
    },    
    {
        "displayname": "Source system for the immunization record",
        "key": "sourcesystem",
        "alias": "sourcesystem"
    }    
]', 1, 'CIDM-8809', now(), 'CIDM-8809', now());

