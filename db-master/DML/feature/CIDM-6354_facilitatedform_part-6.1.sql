DELETE FROM cjams.audittraillukup WHERE typekey ='fmrfassessment';
INSERT INTO cjams.audittraillukup
( typekey, activeflag, insertedby, insertedon, updatedby, updatedon, fieldjson)
VALUES('fmrfassessment', 1, 'CIDM-6354', now(), 'CIDM-6354', now(),'[
       {
        "key": "curentPlacementTyp",
        "displayname": "Currente Placement type"
    },
    {
        "key": "providername",
        "displayname": "Provider Name "
    },
    {
        "key": "provider_id",
        "displayname": "Provider ID"
    },
    {
        "key": "placementAddress",
        "displayname": "Placement Address"
    },{
        "key": "plTypeFosterHome",
        "displayname": "Foster Home"
    },
    {
        "key": "dateofreferral",
        "displayname": "Date of Referral"
    },
    {
        "key": "requestor",
        "displayname": "Requestor"
    },
    {
        "key": "phone",
        "displayname": "Phone"
    },
    {
        "key": "email",
        "displayname": "Email"
    },
    {
        "key": "cjamsid",
        "displayname": "Child cjamspid"
    },
    {
        "key": "name",
        "displayname": "Child Name"
    },
    {
        "key": "dob",
        "displayname": "Date of birth"
    },
    {
        "key": "address",
        "displayname":"address"
    },
    {
        "key": "plTypeIndLiving",
        "displayname": "Independent Living"
    },
    {
        "key": "plTypeGroupHome",
        "displayname": "Group Name"
    },
    {
        "key": "plTypeKinship",
        "displayname": "Kinship"
    },
    {
        "key": "plTypeHomeNotRemoved",
        "displayname": "Home - Not Removed"
    },
    {
        "key": "plTypeNA",
        "displayname": "NA"
    },
    {
        "key": "livingarrangementtypeConsidered",
        "displayname": "Living Arrangement Type"
    },
    {
        "key": "parentsName",
        "displayname": "Parent Name"
    },
    {
        "key": "contactHome",
        "displayname": "Contact Home"
    },
    {
        "key": "contactWork",
        "displayname": "Contact Work"
    },
    {
        "key": "contactCell",
        "displayname": "Contact Cell"
    },
    {
        "key": "contactText",
        "displayname": "Contact Text"
    },
    {
        "key": "contactEmail",
        "displayname": "Contact Email"
    },
    {
        "key": "applicableTo",
        "displayname": "Applicable to"
    },
    {
        "key": "orderOfProtectingConduct",
        "displayname": "Order of Protective Supervision"
    },
    {
        "key": "protectingConductComments",
        "displayname": "Order of Protective Conduct Comments"
    },
    {
        "key": "protectingConductApplicableTo",
        "displayname": "Order of Protective Conduct Applicable to "
    },
    {
        "key": "collateralRelationshipTo",
        "displayname": "Relationship"
    },
    {
        "key": "orderControllingConduct",
        "displayname": "Order Controlling Conduct"
    },
    {
        "key": "comments",
        "displayname": "Order Controlling Conduct Comments"
    },
    {
        "key": "orderOfProtectingConduct",
        "displayname": "Order of Protective Supervision"
    },
    {
        "key": "protectingConductComments",
        "displayname": "Order of Protective Supervision Comments"
    },
    {
        "key": "familyHasIndicate",
        "displayname": "Select"
    },
    {
        "key": "hasWorker",
        "displayname": "Has worker made contact"
    },
    {
        "key": "familyUnderstanding",
        "displayname": "Family Understanding of the purpose"
    },
    {
        "key": "indicateParent",
        "displayname": "Indicate parent(s) are residing/committed to a facility of State hospital etc"
    },
    {
        "key": "facilityName",
        "displayname": "Facility Name"
    },
    {
        "key": "address",
        "displayname": "Address"
    },
    {
        "key": "fax",
        "displayname": "Fax"
    },
    {
        "key": "email",
        "displayname": "Email"
    },
    {
        "key": "isWriteNeeded",
        "displayname": " Is a writ needed "
    },
    {
        "key": "isWriteNeededComments",
        "displayname": " Is a writ needed  Comments"
    },
    {
        "key": "familyPreferred",
        "displayname": "Family’s preferred location of meeting"
    },
    {
        "key": "specialNeedsRiskFactorSelect",
        "displayname": "Special Needs / Risk Factors"
    },
    {
        "key": "snrfChildcare",
        "displayname": "Family Access form  - Child Care (if provision)"
    },
    {
        "key": "snrfCourtOrder",
        "displayname": "Family Access form  - Court order(s)"
    },
    {
        "key": "snrfLiteracy",
        "displayname": "Family Access form  - Literacy"
    },
    {
        "key": "snrfTransportation",
        "displayname": "Family Access form  - Transportation"
    },
    {
        "key": "snrfSafetyConcerns",
        "displayname": "Family Access form  - Safety Concerns / family violence / No Contact orders"
    },
    {
        "key": "snrfADAConcerns",
        "displayname": "Family Access form  - ADA Concerns / access"
    },
    {
        "key": "snrfInterpreter",
        "displayname": "Family Access form  - Interpreter"
    },
    {
        "key": "snrfTraumaResponsiveNeeds",
        "displayname": "Family Access form  - Trauma Responsive Needs"
    },
    {
        "key": "snrfVirtualMeetingNeeds",
        "displayname": "Family Access form  - Virtual Meeting Needs"
    },
    {
        "key": "snrfOtherMeetingNeeds",
        "displayname": "Family Access form  - Other Meeting Needs"
    },
    {
        "key": "otherMeetingNeedsComments",
        "displayname": "Family Access form  - Other Meeting Needs Comments"
    },
    {
        "key": "specialNeedsRiskFactorsComments",
        "displayname": "Family Access form  - Specific Explanation of Special Needs"
    },
    {
        "key": "familyTeamDecisionMeeting",
        "displayname": "Family Access form  - Family Team Decision Meeting"
    },
    {
        "key": "emergentChildSeperation",
        "displayname": "Family Access form  - Emergent separation of child from family"
    },
    {
        "key": "consideredChildSeperation",
        "displayname": "Family Access form  - Considered Separation of Child from Family"
    },
    {
        "key": "placementChangeStability",
        "displayname": "Family Access form  - Placement Change/Stability"
    },
    {
        "key": "recommendationsPermanencyChange",
        "displayname": "Family Access form  - Recommendations for Permanency Change"
    },
    {
        "key": "qrtp",
        "displayname": "Family Access form  - QRTP"
    },
    {
        "key": "voluntaryPlacement",
        "displayname": "Family Access form  - Voluntary Placement Assessments"
    },
    {
        "key": "placementPlanning",
        "displayname": "Family Access form  - Permanency Planning"
    },
    {
        "key": "ytp",
        "displayname": "Family Access form  - YTP"
    },
    {
        "key": "facilitatedFamilyMeeting",
        "displayname": "Family Access form  - Facilitated Family Meeting"
    },
    {
        "key": "facilitatedFamilyMeetingComments",
        "displayname": "Family Access form  - Reason for Meeting"
    },
    {
        "key": "assessmentreviewed",
        "displayname": "Submit For Approval"
    },
    {
        "key": "facilitatormeetingassessmentcompletiondate",
        "displayname": "Facilitator Meeting Assessment Completion Date Time"
    },
    {
        "key": "facilitatormeetingassessmentapprovaldate",
        "displayname": "Facilitator Meeting Assessment Approval Date Time"
    },
    {
        "key": "assessmentStaus",
        "displayname": "Assessment Status"
    },
    {
        "key": "supervisorcomments",
        "displayname": "Supervisor Comments"
    }, 
    {
        "key":"childarray",
    	"displayname":"child Array Details" , 
        "datatype": "json_array" 
    },  
    {
        "key":"SubChildarray",
    	"displayname":"SubChildarray Details" , 
        "datatype": "json_array"  
    }

]'::json);