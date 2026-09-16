import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { PhysicalAttributesComponent } from './physical-attributes.component';

describe('PhysicalAttributesComponent', () => {
  let component: PhysicalAttributesComponent;
  let fixture: ComponentFixture<PhysicalAttributesComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ PhysicalAttributesComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(PhysicalAttributesComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
