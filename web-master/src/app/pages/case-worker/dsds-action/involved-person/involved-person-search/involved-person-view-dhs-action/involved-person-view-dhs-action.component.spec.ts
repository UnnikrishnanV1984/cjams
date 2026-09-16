import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { InvolvedPersonViewDhsActionComponent } from './involved-person-view-dhs-action.component';

describe('InvolvedPersonViewDhsActionComponent', () => {
  let component: InvolvedPersonViewDhsActionComponent;
  let fixture: ComponentFixture<InvolvedPersonViewDhsActionComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ InvolvedPersonViewDhsActionComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(InvolvedPersonViewDhsActionComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
