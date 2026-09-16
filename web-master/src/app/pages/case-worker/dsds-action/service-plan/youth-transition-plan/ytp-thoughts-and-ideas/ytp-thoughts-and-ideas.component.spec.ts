/* tslint:disable:no-unused-variable */
import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';
import { YtpThoughtsAndIdeasComponent } from './ytp-thoughts-and-ideas.component';

describe('YtpThoughtsAndIdeasComponent', () => {
  let component: YtpThoughtsAndIdeasComponent;
  let fixture: ComponentFixture<YtpThoughtsAndIdeasComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ YtpThoughtsAndIdeasComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(YtpThoughtsAndIdeasComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
