import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { ProviderInformationCwComponent } from './provider-information-cw.component';

describe('ProviderInformationCwComponent', () => {
  let component: ProviderInformationCwComponent;
  let fixture: ComponentFixture<ProviderInformationCwComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ ProviderInformationCwComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ProviderInformationCwComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
