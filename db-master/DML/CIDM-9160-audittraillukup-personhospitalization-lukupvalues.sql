delete from audittraillukup where typekey = 'personhospitalization';
insert into audittraillukup(typekey,historytablename,primarykeyname,fieldjson,activeflag,insertedby,insertedon,updatedby,updatedon)
values ('personhospitalization','personhospitalization_history','hospitalizationid', '[
    {
        "displayname": "Inserted By",
        "key": "insertedby",
        "alias": "insertedby",
        "query": "SELECT coalesce(u.fullname,pi.insertedby) FROM personhospitalization pi LEFT JOIN userprofile u on u.securityusersid = pi.insertedby where pi.hospitalizationid = ",
        "query2": " order by pi.insertedon desc limit 1"
    },
    {
        "displayname": "Updated By",
        "key": "updatedby",
        "alias": "updatedby",
        "query": "SELECT coalesce(u.fullname,pi.updatedby) FROM personhospitalization pi LEFT JOIN userprofile u on u.securityusersid = pi.updatedby where pi.hospitalizationid = ",
        "query2": " order by pi.updatedon desc limit 1"
    },
    {
        "displayname": "Updated Date and Time",
        "key": "updatedon",
        "alias": "updatedon"
    }
]', 1, 'CIDM-9160', now(), 'CIDM-9160', now());
