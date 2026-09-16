import { ComponentFixture, TestBed } from '@angular/core/testing';

import { CustomInfoTooltip } from './custom-info-tooltip.component';

describe('CustomInfoTooltip', () => {
  let component: CustomInfoTooltip;
  let fixture: ComponentFixture<CustomInfoTooltip>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ CustomInfoTooltip ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(CustomInfoTooltip);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
