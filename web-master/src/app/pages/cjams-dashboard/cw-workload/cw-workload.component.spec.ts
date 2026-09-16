import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { CwWorkloadComponent } from './cw-workload.component';

describe('CwWorkloadComponent', () => {
  let component: CwWorkloadComponent;
  let fixture: ComponentFixture<CwWorkloadComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ CwWorkloadComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(CwWorkloadComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
