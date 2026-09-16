import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { IntakeSdmComponent } from './intake-sdm.component';

describe('IntakeSdmComponent', () => {
  let component: IntakeSdmComponent;
  let fixture: ComponentFixture<IntakeSdmComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ IntakeSdmComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(IntakeSdmComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
