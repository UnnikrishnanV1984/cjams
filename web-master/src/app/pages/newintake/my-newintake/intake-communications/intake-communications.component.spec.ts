import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { IntakeCommunicationsComponent } from './intake-communications.component';

describe('IntakeCommunicationsComponent', () => {
  let component: IntakeCommunicationsComponent;
  let fixture: ComponentFixture<IntakeCommunicationsComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ IntakeCommunicationsComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(IntakeCommunicationsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
