import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { ApEmotionalTilesComponent } from './ap-emotional-tiles.component';

describe('ApEmotionalTilesComponent', () => {
  let component: ApEmotionalTilesComponent;
  let fixture: ComponentFixture<ApEmotionalTilesComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ ApEmotionalTilesComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ApEmotionalTilesComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
