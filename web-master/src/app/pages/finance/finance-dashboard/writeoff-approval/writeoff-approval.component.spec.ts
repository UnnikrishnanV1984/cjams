import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { WriteoffApprovalComponent } from './writeoff-approval.component';

describe('WriteoffApprovalComponent', () => {
  let component: WriteoffApprovalComponent;
  let fixture: ComponentFixture<WriteoffApprovalComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ WriteoffApprovalComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(WriteoffApprovalComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
