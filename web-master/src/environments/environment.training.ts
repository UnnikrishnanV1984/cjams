export const environment = {
    prodMod: false,
    title4eProduction: true,//Temporary till Title IV-E goes to live
    IVEReferralCSMSCall: true,
    apiHost: 'https://trn.cw.cjams.mdthink.maryland.gov/api',
    formBuilderHost: 'https://trn.cw.cjams.mdthink.maryland.gov/formbuilder',
    reports: 'https://dev2.analytics.mdthink.maryland.gov/qliksense/hub/',
    fakeHttpResponse: false,
    envName: 'trn1',
   
    logoutDHSURL: 'https://training1.access.mdthink.maryland.gov/mdtsso/UI/Logout?realm=/dhs',
    IdleTimeOut: 900,
    PopupTimeOut: 300,
    isReadOnlyEnable: true,
    enableCaseConnectClose: true,
    state: true,
    // tslint:disable-next-line: max-line-length
    sessionCheckURL : 'https://training1.access.mdthink.maryland.gov/openam/identity/attributes?attributenames=idletime&attributenames=maxidletime&attributenames=timeleft&attributenames=maxsessiontime&refresh=false',
    FileUploadRefreshTime : 30000
};
