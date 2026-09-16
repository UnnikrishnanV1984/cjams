// The file contents for the current environment will overwrite these during build.
// The build system defaults to the dev environment which uses `environment.ts`, but if you do
// `ng build --env=prod` then `environment.prod.ts` will be used instead.
// The list of which env maps to which file can be found in `angular-cli.json`.
export const environment = {
    prodMod: true,
    title4eProduction: false,
    IVEReferralCSMSCall: true,
    apiHost:'https://dev4.cw.cjams.mdthink.maryland.gov/api',
    formBuilderHost: 'https://dev4.cw.cjams.mdthink.maryland.gov/formbuilder',
    docGenHost:'https://dev3.cwnc.cjams.mdthink.maryland.gov/NEICE',
	reportHost: 'https://10.88.40.141/',
    reports: 'https://dev2.analytics.mdthink.maryland.gov/qliksense/hub/',
    fakeHttpResponse: false,
    envName: 'Dev',
   
    logoutDHSURL: 'https://dev.access.mdthink.maryland.gov/mdtsso/UI/Logout?realm=/dhs',
    IdleTimeOut: 900,
    PopupTimeOut: 300,
    isReadOnlyEnable: true,
    cookieName: 'devmdtsso',
    state: true,
    enableCaseConnectClose: true,
    // tslint:disable-next-line: max-line-length
    sessionCheckURL : 'https://dev.access.mdthink.maryland.gov/mdtsso/identity/attributes?attributenames=idletime&attributenames=maxidletime&attributenames=timeleft&attributenames=maxsessiontime&refresh=false',
    gtag: 'G-5MK56D3YL2',
    FileUploadRefreshTime : 30000 
   
};
