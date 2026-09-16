export class FindUrlConfig {
    public static EndPoint = {
        DsdsAction: {
            dsdsActionSearchURL: `servicerequestsearches/getDetails`,
            dsdsActionCountyURL: `admin/county/list`,
            dsdsActionRegionURL: `admin/region/`,
            dsdsActionDATypeURL: `admin/intakeservicerequesttype`,
            dsdsActionDASubTypeURL: `admin/intakeservicerequesttype?filter`,
            dsdsActionStatusURL: `admin/intakeservicerequesttype/listdastatus?filter`,
            dsdsActionDispositionURL: `admin/intakeservicerequesttype/listdadisposition?filter`,
        },
        RegulationLibrary: {
            regulationLibrarySearchURL: `manage/statestatutes/getRegulationLibrary`,
        },
        Entities: {
            entitiesSearchUrl: 'gloabalagencysearches/getAgencySearchData',
            countyUrl: 'admin/county/list',
            regionUrl: 'admin/region/',
            categoryUrl: 'admin/agencycategory?filter={"activeflag": "1"}',
            typeUrl: 'admin/agencytype',
            serviceUrl: 'Services?filter={"where" : {"activeflag":"1"}}',
            businessTypeUrl: 'Agencysubtypes?filter'
        },
        Documents: {
            documentsSearchUrl: 'getdocumentsearchdtls/getdocumentsearch',
            documentTypeUrl: 'Documenttypes',
            documentDetailUrl: 'Documentattachments?filter'
        },
        common: {
            counties: 'admin/county/list',
            regions: 'admin/region/',
        },
        PersonSearch: {
            people: 'People?filter',
            phonenumbers: 'Personphonenumbers?filter',
            addresses: 'Personaddresses?filter',
            actors: 'Actors?filter',
            intakeservicerequests: 'Intakeservicerequests/getdsdsactions',
            alias: 'Aliases?filter',
            personclearinginfodata: 'Personclearinginfos/getpersonclearinginfodata',
            identifier: 'Personidentifiers/list?filter',
            gendertype: 'admin/gendertype?filter={"where" :{"activeflag":1}}',
            racetype: 'admin/racetype?filter={"where" :{"activeflag":1}}',
            globalpersonsearches: 'globalpersonsearches/getEnhancedPersonSearchData',
            getpersonexists: 'People/getpersonexists?filter'
        },
        ProviderSearch: {
            gloabalagencysearchData: 'gloabalagencysearches/getAgencySearchData',
            agencycategory: 'admin/agencycategory?filter={"activeflag": "1"}',
            agencytype: 'admin/agencytype?filter',
            agencysubtypes: 'agencysubtypes?filter',
            agencystatustypes: 'agencystatustypes?filter={"activeflag": "1"}',
            providernonagreementtype: 'admin/providernonagreementtype?filter={"activeflag": "1"}',
            services: 'Services?filter={"activeflag": "1"}',
            agency: 'admin/agency?filter',
            agencyaddresses: 'agencyaddresses?filter',
            agencyservices: 'agencyservices?filter',
        },
        staffnteam: {
            teamNumber: 'manage/team',
            teamType: 'admin/teamtype/list',
            positionTitle: 'admin/teammemberroletype/list',
            userSearch: 'getusersearches/getusersearch',
            equipmentList: 'admin/equipment/list',
            equipmentTypeList: 'admin/equipmenttype',
            equipmentDetails: 'admin/equipment',
            userProfile: 'admin/userprofile/list',
            teamMemberZipCode: 'admin/teammember/countylist',
            teamZipCode: 'admin/county',
            rolemappings: 'rolemappings/list',
            teamtreelist: 'manage/team/listtree',
            teamMemberDetails: 'manage/team/details',
            userProfileupdate: 'admin/userprofile/addupdate',
            assignEquipment: 'admin/teammemberequipment/add',
            addEquipment: 'admin/equipment/add',
            updateEquipment: 'admin/equipment/update',
            userStatus: 'admin/userworkstatustype',
        }
    };
}
