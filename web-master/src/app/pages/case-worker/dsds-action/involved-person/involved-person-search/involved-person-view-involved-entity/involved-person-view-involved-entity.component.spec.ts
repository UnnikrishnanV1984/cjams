import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { InvolvedPersonViewInvolvedEntityComponent } from './involved-person-view-involved-entity.component';

describe('InvolvedPersonViewInvolvedEntityComponent', () => {
  let component: InvolvedPersonViewInvolvedEntityComponent;
  let fixture: ComponentFixture<InvolvedPersonViewInvolvedEntityComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ InvolvedPersonViewInvolvedEntityComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(InvolvedPersonViewInvolvedEntityComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
