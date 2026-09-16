import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { ScAgreementComponent } from './sc-agreement.component';

describe('ScAgreementComponent', () => {
  let component: ScAgreementComponent;
  let fixture: ComponentFixture<ScAgreementComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ ScAgreementComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ScAgreementComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
