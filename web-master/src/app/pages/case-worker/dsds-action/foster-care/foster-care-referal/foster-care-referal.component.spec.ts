import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { FosterCareReferalComponent } from './foster-care-referal.component';

describe('FosterCareReferalComponent', () => {
  let component: FosterCareReferalComponent;
  let fixture: ComponentFixture<FosterCareReferalComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ FosterCareReferalComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(FosterCareReferalComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
