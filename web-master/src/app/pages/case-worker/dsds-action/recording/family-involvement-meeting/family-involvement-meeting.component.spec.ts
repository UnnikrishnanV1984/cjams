import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { FamilyInvolvementMeetingComponent } from './family-involvement-meeting.component';

describe('FamilyInvolvementMeetingComponent', () => {
  let component: FamilyInvolvementMeetingComponent;
  let fixture: ComponentFixture<FamilyInvolvementMeetingComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ FamilyInvolvementMeetingComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(FamilyInvolvementMeetingComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
