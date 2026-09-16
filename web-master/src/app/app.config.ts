import { environment } from '../environments/environment';

export class AppConfig {
    public static siteTitle = 'CJAMS';
    public static baseUrl = environment.apiHost;
    public static authTokenUrl = 'users/login?include=["user"]';
    public static roleProfileUrl = 'Authorizes/getroleprofile';
    public static getUserRolesUrl = 'Authorizes/getuserroles';
    public static logoutUrl = 'users/logout';
    public static logoutOpenAm = 'users/logoutEcms';
    public static pageProfile = 'Authorizes/getPageProfile';
    public static continuesession = 'admin/userprofile/continuesession';
    public static content_type = 'application/json';
    public static content_typestr = 'Content-Type';

    public static getModuleMapName(modname: string = '') {
            return '';
    }
}
