import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { BehavioralHealthInfoCreateEditComponent } from './behavioral-health-info-create-edit.component';

describe('BehavioralHealthInfoCreateEditComponent', () => {
  let component: BehavioralHealthInfoCreateEditComponent;
  let fixture: ComponentFixture<BehavioralHealthInfoCreateEditComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ BehavioralHealthInfoCreateEditComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(BehavioralHealthInfoCreateEditComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
