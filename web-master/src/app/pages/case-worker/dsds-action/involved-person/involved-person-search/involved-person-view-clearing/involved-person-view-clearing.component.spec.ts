import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { InvolvedPersonViewClearingComponent } from './involved-person-view-clearing.component';

describe('InvolvedPersonViewClearingComponent', () => {
  let component: InvolvedPersonViewClearingComponent;
  let fixture: ComponentFixture<InvolvedPersonViewClearingComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ InvolvedPersonViewClearingComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(InvolvedPersonViewClearingComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
