import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { BehavioralHealthInfoComponent } from './behavioral-health-info.component';

describe('BehavioralHealthInfoComponent', () => {
  let component: BehavioralHealthInfoComponent;
  let fixture: ComponentFixture<BehavioralHealthInfoComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ BehavioralHealthInfoComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(BehavioralHealthInfoComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
