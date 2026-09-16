import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { CasePlanLegacyComponent } from './case-plan-legacy.component';

describe('CasePlanLegacyComponent', () => {
  let component: CasePlanLegacyComponent;
  let fixture: ComponentFixture<CasePlanLegacyComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ CasePlanLegacyComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(CasePlanLegacyComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
