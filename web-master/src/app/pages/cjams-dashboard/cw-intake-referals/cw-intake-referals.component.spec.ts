import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { CwIntakeReferalsComponent } from './cw-intake-referals.component';

describe('CwIntakeReferalsComponent', () => {
  let component: CwIntakeReferalsComponent;
  let fixture: ComponentFixture<CwIntakeReferalsComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ CwIntakeReferalsComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(CwIntakeReferalsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
