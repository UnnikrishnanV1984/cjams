export class CaseAuditTrailConstant {
    public static HEADERS: any = {
        Contacts: [
            {label: "Contact ID", value: 'contactnoteid'},
            {label: "Contact Date", value: 'contactdate'},
            {label: "Type Of Contact", value: 'contacttype'},
            {label: "Description", sortableColumn : "eventdescription", value: 'eventdescription'},
            {label: "User Name", sortableColumn : "username", value: 'username'},
            {label: "Date & Time Of Action", sortableColumn : "actiontime", value: 'actiontime'},
            {label: "Status"}
        ],
        Health_Conditions: [
            {label: "CJAMSPID", value: 'referenceid'},
            {label: "Description", sortableColumn : "eventdescription",  value: 'eventdescription'},
            {label: "User Name", sortableColumn : "username",  value: 'username'},
            {label: "Date & Time Of Action", sortableColumn : "actiontime", value: 'actiontime'},
            {label: "Status"}
        ],
        Medication_Psychotropic : [
            {label: "CJAMSPID", value: 'referenceid'},
            {label: "Description", sortableColumn : "eventdescription",  value: 'eventdescription'},
            {label: "User Name", sortableColumn : "username",  value: 'username'},
            {label: "Date & Time Of Action", sortableColumn : "actiontime", value: 'actiontime'},
            {label: "Status"}
        ],
        "Person Health Summary": [
            {label: "CJAMSPID", value: 'referenceid'},
            {label: "Description", sortableColumn : "eventdescription",  value: 'eventdescription'},
            {label: "User Name", sortableColumn : "username", value: 'username'},
            {label: "Date & Time Of Action", sortableColumn : "actiontime",  value: 'actiontime'},
            {label: "Status"}
        ]
    }
    public static FILTERS: any = {
        Contacts: {
            fromDate: true,
            toDate: true,
            assigneduser: false,
            clientid: false
        },
        Health_Conditions: {
            fromDate: true,
            toDate: true,
            assigneduser: true,
            clientid: true
        },
        Medication_Psychotropic: {
            fromDate: true,
            toDate: true,
            assigneduser: true,
            clientid: true
        },
        "Person Health Summary": {
            fromDate: true,
            toDate: true,
            assigneduser: true,
            clientid: true
        }
    }
}