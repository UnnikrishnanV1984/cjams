import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { ScDisclosureChecklistComponent } from './sc-disclosure-checklist.component';

describe('ScDisclosureChecklistComponent', () => {
  let component: ScDisclosureChecklistComponent;
  let fixture: ComponentFixture<ScDisclosureChecklistComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ ScDisclosureChecklistComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ScDisclosureChecklistComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
