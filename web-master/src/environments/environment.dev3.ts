// The file contents for the current environment will overwrite these during build.
// The build system defaults to the dev environment which uses `environment.ts`, but if you do
// `ng build --env=prod` then `environment.prod.ts` will be used instead.
// The list of which env maps to which file can be found in `angular-cli.json`.
export const environment = {
    prodMod: false,
	title4eProduction: false,//Temporary till Title IV-E goes to live
    IVEReferralCSMSCall: true,
    apiHost:'https://dev3.cw.cjams.mdthink.maryland.gov/api',
    formBuilderHost: 'https://dev3.cw.cjams.mdthink.maryland.gov/formbuilder',
   //formBuilderHost: 'http://dev4.cjams.formbuilder.mdthink.maryland.gov',
    reports: 'https://dev2.analytics.mdthink.maryland.gov/qliksense/hub/',
    reportHost: 'https://10.88.40.141/',
    fakeHttpResponse: false,
    envName: 'Dev',
   
    logoutDHSURL: 'https://dev.access.mdthink.maryland.gov/mdtsso/UI/Logout?realm=/dhs',
    IdleTimeOut: 900,
    PopupTimeOut: 300,
    isReadOnlyEnable: true,
    cookieName: 'devmdtsso',
    enableCaseConnectClose: true,
    state: true,
    // tslint:disable-next-line: max-line-length
    sessionCheckURL : 'https://dev1.access.mdthink.maryland.gov/mdtsso/identity/attributes?attributenames=idletime&attributenames=maxidletime&attributenames=timeleft&attributenames=maxsessiontime&refresh=false',
    FileUploadRefreshTime : 30000
    

};

