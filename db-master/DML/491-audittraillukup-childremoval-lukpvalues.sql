
delete from audittraillukup where typekey = 'childremoval';

insert into audittraillukup(typekey,fieldjson,activeflag,insertedby,insertedon,updatedby,updatedon)
values ('childremoval', '[
    {
        "displayname": "Removal Type",
        "key": "removaltypekeyref"
    },
    {
        "displayname": "Removal Date",
        "key": "removaldate"
    },
    {
        "displayname": "Removal Time",
        "key": "removaltime"
    },
    {
        "displayname": "Family Structure",
        "key": "familystructuretypekeyref"
    },
    {
        "displayname": "Where is the child going to be placed?",
        "key": "agencytypekeyref"
    },
    {
        "displayname": "Primary Caregiver",
        "key": "primarycaregiveractoridref"
    },
    {
        "displayname": "Address of Primary Caregiver",
        "key": "primarycaregiveradd"
    },
    {
        "displayname": "Address of Secondary Caregiver",
        "key": "seccaregiveradd"
    },
    {
        "displayname": "Child Home Address Same as Primary Caregiver address?",
        "key": "ischildaddressasprimaryaddress"
    },
    {
        "displayname": "Secondary Caregiver",
        "key": "seccaregiveractoridref"
    },
    {
        "displayname": "Primary Caregiver Address Verified",
        "key": "isverifiedcaregiver1add"
    },
    {
        "displayname": "Secondary Caregiver Adddress Verified",
        "key": "isverifiedcaregiver2add"
    },
    {
        "displayname": "Physical address from where child removed",
        "key": "childphysicalremovaladdres"
    },
    {
        "displayname": "Physical Address Verified",
        "key": "ischildphysicalremovaladdressverified"
    },
    {
        "displayname": "Factors at Removal",
        "key": "removalreasonref"
    },
    {
        "displayname": "Narrative",
        "key": "comments"
    },
    {
        "displayname": "Reasonable Efforts made to prevent child Removal",
        "key": "reasonableeffortsref"
    },
    {
        "displayname": "Removal End Reason",
        "key": "removalexitreasonref"
    },
    {
        "displayname": "Removal End Date",
        "key": "exitdate"
    },
    {
        "displayname": "Removal End Time",
        "key": "exittime"
    },
    {
        "displayname": "Child''s Home Address at the time of removal",
        "key": "removaladd1"
    },
    {
        "displayname": "Physical address from where child was removed",
        "key": "childphysicalremovaladdress"
    },
	{
        "displayname": "Shelter Authorization completed?",
        "key": "isshelterauthcompleted"
    },
	{
        "displayname": "Completed by",
        "key": "isuploadedmanually"
    },
    {
        "displayname": "Child home Address Verified",
        "key": "isverifiedreporteradd"
    },
    {
        "displayname": "Justification",
        "key": "justification"
    }
]', 1, 'ADMIN', now(), 'ADMIN', now());