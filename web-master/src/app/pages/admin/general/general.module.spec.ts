import { GeneralModule } from './general.module';

describe('GeneralModule', () => {
  let tablesModule: GeneralModule;

  beforeEach(() => {
    tablesModule = new GeneralModule();
  });

  it('should create an instance', () => {
    expect(tablesModule).toBeTruthy();
  });
});
