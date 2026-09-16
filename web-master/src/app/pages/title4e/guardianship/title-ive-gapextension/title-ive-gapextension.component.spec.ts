import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { TitleIveGapextensionComponent } from './title-ive-gapextension.component';

describe('TitleIveGapextensionComponent', () => {
  let component: TitleIveGapextensionComponent;
  let fixture: ComponentFixture<TitleIveGapextensionComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ TitleIveGapextensionComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(TitleIveGapextensionComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
