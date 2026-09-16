import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { AuditAccessLogsComponent } from './audit-access-logs.component';

describe('AuditAccessLogsComponent', () => {
  let component: AuditAccessLogsComponent;
  let fixture: ComponentFixture<AuditAccessLogsComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ AuditAccessLogsComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(AuditAccessLogsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
