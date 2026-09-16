import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { FiscalAuditComponent } from './fiscal-audit.component';

describe('FiscalAuditComponent', () => {
  let component: FiscalAuditComponent;
  let fixture: ComponentFixture<FiscalAuditComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ FiscalAuditComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(FiscalAuditComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
