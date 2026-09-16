import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { DashPreIntakeComponent } from './dash-pre-intake.component';

describe('DashPreIntakeComponent', () => {
  let component: DashPreIntakeComponent;
  let fixture: ComponentFixture<DashPreIntakeComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ DashPreIntakeComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(DashPreIntakeComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
