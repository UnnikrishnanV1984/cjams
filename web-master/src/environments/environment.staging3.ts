export const environment = {
    prodMod: true,
    title4eProduction: true,//Temporary till Title IV-E goes to live
    IVEReferralCSMSCall: true,
    apiHost:'https://stag3.cjams.mdthink.maryland.gov/api', 
    formBuilderHost: 'https://stag3.cjams.mdthink.maryland.gov/formbuilder',
    reports: 'https://stag.analytics.mdthink.maryland.gov/qliksense/hub/',
    fakeHttpResponse: false,
    envName: 'stg3',

    logoutDHSURL: 'https://stag.access.mdthink.maryland.gov/mdtsso/UI/Logout?realm=/dhs',
    IdleTimeOut: 900,
    PopupTimeOut: 300,
    isReadOnlyEnable: true,
    enableCaseConnectClose: true,
    state: true,
    // tslint:disable-next-line: max-line-length
    sessionCheckURL : 'https://dev1.access.mdthink.maryland.gov/mdtsso/identity/attributes?attributenames=idletime&attributenames=maxidletime&attributenames=timeleft&attributenames=maxsessiontime&refresh=false',
    FileUploadRefreshTime : 30000

};
