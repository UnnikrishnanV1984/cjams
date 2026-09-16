import { AppConfig } from './app.config';
import { config } from '../environments/config';

fdescribe('AppConfig against STATE environment configuration', () => {
    let appConfig: AppConfig;

    beforeEach(() => {
        appConfig = new AppConfig();
        config.workEnvironment = 'state';
    });
    afterEach(() => { 
        config.workEnvironment = 'local';
    });

    it('should create an instance', () => {
        expect(appConfig).toBeTruthy();
    });

});
