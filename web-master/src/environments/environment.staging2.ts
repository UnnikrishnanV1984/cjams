export const environment = {
    prodMod: true,
    apiHost:'https://stag2.cjams.mdthink.maryland.gov/api/cjams/stag2', 
    formBuilderHost: 'https://stag2.cjams.mdthink.maryland.gov/formbuilder',
    reports: 'https://stag.analytics.mdthink.maryland.gov/qliksense/hub/',
    fakeHttpResponse: false,
    envName: 'Staging',

    logoutDHSURL: 'https://stag.access.mdthink.maryland.gov/openam/UI/Logout?realm=/dhs',
    IdleTimeOut: 900,
    PopupTimeOut: 300,
    isReadOnlyEnable: true,
    enableCaseConnectClose: false,
    state: true,
    // tslint:disable-next-line: max-line-length
    sessionCheckURL : 'https://stag.access.mdthink.maryland.gov/openam/identity/attributes?attributenames=idletime&attributenames=maxidletime&attributenames=timeleft&attributenames=maxsessiontime&refresh=false',
    FileUploadRefreshTime : 30000
};
