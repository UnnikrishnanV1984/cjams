// The file contents for the current environment will overwrite these during build.
// The build system defaults to the dev environment which uses `environment.ts`, but if you do
// `ng build --env=prod` then `environment.prod.ts` will be used instead.
// The list of which env maps to which file can be found in `angular-cli.json`.
export const environment = {
    prodMod: true,
	title4eProduction: true,//Temporary till Title IV-E goes to live
    IVEReferralCSMSCall: true,
    apiHost:'https://uat.cjams.mdthink.maryland.gov/api/cjams/uat', 
    formBuilderHost: 'https://uat.cjams.mdthink.maryland.gov/formbuilder',
    reports: 'https://uat.analytics.mdthink.maryland.gov/qliksense/hub/',
    fakeHttpResponse: false,
    envName: 'UAT',

    logoutDHSURL: 'https://uat1.access.mdthink.maryland.gov/openam/UI/Logout?realm=/dhs',
    IdleTimeOut: 900,
    PopupTimeOut: 300,
    isReadOnlyEnable: true,
    enableCaseConnectClose: false,
    state: true,
    sessionCheckURL : 'https://dev1.access.mdthink.maryland.gov/openam/identity/attributes?attributenames=idletime&attributenames=maxidletime&attributenames=timeleft&attributenames=maxsessiontime&refresh=false',
    FileUploadRefreshTime : 30000    
};

