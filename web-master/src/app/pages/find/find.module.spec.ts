import { FindModule } from './find.module';

describe('FindModule', () => {
    let findModule: FindModule;

    beforeEach(() => {
        findModule = new FindModule(); // NOSONAR
    });

    it('should create an instance', () => {
        expect(FindModule).toBeTruthy();
    });
});
