import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { BehavioralHealthInfoCwComponent } from './behavioral-health-info-cw.component';

describe('BehavioralHealthInfoComponent', () => {
  let component: BehavioralHealthInfoCwComponent;
  let fixture: ComponentFixture<BehavioralHealthInfoCwComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ BehavioralHealthInfoCwComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(BehavioralHealthInfoCwComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
