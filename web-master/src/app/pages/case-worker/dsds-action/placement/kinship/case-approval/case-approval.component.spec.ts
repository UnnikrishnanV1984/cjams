import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { CaseApprovalComponent } from './case-approval.component';

describe('CaseApprovalComponent', () => {
  let component: CaseApprovalComponent;
  let fixture: ComponentFixture<CaseApprovalComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ CaseApprovalComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(CaseApprovalComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
