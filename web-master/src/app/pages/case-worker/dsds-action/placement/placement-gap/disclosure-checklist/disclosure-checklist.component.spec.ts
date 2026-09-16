import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { DisclosureChecklistComponent } from './disclosure-checklist.component';

describe('DisclosureChecklistComponent', () => {
  let component: DisclosureChecklistComponent;
  let fixture: ComponentFixture<DisclosureChecklistComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ DisclosureChecklistComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(DisclosureChecklistComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
