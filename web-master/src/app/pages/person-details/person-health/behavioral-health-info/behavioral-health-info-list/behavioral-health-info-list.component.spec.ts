import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { BehavioralHealthInfoListComponent } from './behavioral-health-info-list.component';

describe('BehavioralHealthInfoListComponent', () => {
  let component: BehavioralHealthInfoListComponent;
  let fixture: ComponentFixture<BehavioralHealthInfoListComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ BehavioralHealthInfoListComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(BehavioralHealthInfoListComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
