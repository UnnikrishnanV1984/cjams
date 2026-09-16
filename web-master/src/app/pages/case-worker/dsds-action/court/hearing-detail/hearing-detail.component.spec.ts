import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { HearingDetailComponent } from './hearing-detail.component';

describe('HearingDetailComponent', () => {
  let component: HearingDetailComponent;
  let fixture: ComponentFixture<HearingDetailComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ HearingDetailComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(HearingDetailComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
