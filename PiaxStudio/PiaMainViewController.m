//
//  PiaMainViewController.m
//  PiaxStudio
//
//  Created by Bobie Chen on 2014/4/24.
//  Copyright (c) 2014年 Bobie Chen. All rights reserved.
//

#import "PiaMainViewController.h"
#import "UICommonUtility.h"

@interface PiaMainViewController ()

@property (strong) UILabel* labelNews1;
@property (strong) UILabel* labelNews2;
@property (strong) UILabel* labelNews3;

@end

@implementation PiaMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self prepareMainView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareMainView
{
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    
    NSString* stringBgFilename = @"";
    if (screenSize.height > 480.0f)
    {
        stringBgFilename = @"piabg_1136.png";
    }
    
    UIImageView* imageBg = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:imageBg];
    imageBg.image = [UIImage imageNamed:stringBgFilename];
    
    
    /* main function buttons */
    CGFloat fMainBtnMarginLeft = 20.0f, fMainBtnMarginTop = 130.0f, fMainBtnMarginGap = 10.0f;
    CGFloat fMainBtnWidth = 88.0f, fMainBtnHeight = 44.0f;
    CGFloat fMainBtnCornerRadius = 5.0f;
    UIButton* buttonLiveTours = [[UIButton alloc] initWithFrame:CGRectMake(fMainBtnMarginLeft, fMainBtnMarginTop, fMainBtnWidth, fMainBtnHeight)];
    [self.view addSubview:buttonLiveTours];
    [buttonLiveTours setBackgroundColor:[UICommonUtility hexToColor:0x48A7AA withAlpha:[NSNumber numberWithFloat:1.0f]]];
    [buttonLiveTours.layer setCornerRadius:fMainBtnCornerRadius];
    [buttonLiveTours setAlpha:0.8f];
    
    UILabel* labelLiveTour = [[UILabel alloc] initWithFrame:CGRectZero];
    [buttonLiveTours addSubview:labelLiveTour];
    [labelLiveTour setBackgroundColor:[UIColor clearColor]];
    [labelLiveTour setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:17.0f]];
    [labelLiveTour setTextColor:[UIColor whiteColor]];
    [labelLiveTour setText:@"Live"];
    [labelLiveTour sizeToFit];
    CGRect frame = labelLiveTour.frame;
    frame.origin.x = (fMainBtnWidth - frame.size.width)/2.0f;
    frame.origin.y = (fMainBtnHeight - frame.size.height)/2.0f;
    labelLiveTour.frame = frame;
    
    
    UIButton* buttonPlayer = [[UIButton alloc] initWithFrame:CGRectMake(fMainBtnMarginLeft + fMainBtnWidth + fMainBtnMarginGap, fMainBtnMarginTop,
                                                                        fMainBtnWidth, fMainBtnHeight)];
    [self.view addSubview:buttonPlayer];
    [buttonPlayer setBackgroundColor:[UICommonUtility hexToColor:0x48A7AA withAlpha:[NSNumber numberWithFloat:1.0f]]];
    [buttonPlayer.layer setCornerRadius:fMainBtnCornerRadius];
    [buttonPlayer setAlpha:0.8f];
    
    UILabel* labelPlayer = [[UILabel alloc] initWithFrame:CGRectZero];
    [buttonPlayer addSubview:labelPlayer];
    [labelPlayer setBackgroundColor:[UIColor clearColor]];
    [labelPlayer setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:17.0f]];
    [labelPlayer setTextColor:[UIColor whiteColor]];
    [labelPlayer setText:@"Player"];
    [labelPlayer sizeToFit];
    frame = labelPlayer.frame;
    frame.origin.x = (fMainBtnWidth - frame.size.width)/2.0f;
    frame.origin.y = (fMainBtnHeight - frame.size.height)/2.0f;
    labelPlayer.frame = frame;
    
    UIButton* buttonGallery = [[UIButton alloc] initWithFrame:CGRectMake(fMainBtnMarginLeft, fMainBtnMarginTop + fMainBtnHeight + fMainBtnMarginGap,
                                                                         fMainBtnWidth, fMainBtnHeight)];
    [self.view addSubview:buttonGallery];
    [buttonGallery setBackgroundColor:[UICommonUtility hexToColor:0x48A7AA withAlpha:[NSNumber numberWithFloat:1.0f]]];
    [buttonGallery.layer setCornerRadius:fMainBtnCornerRadius];
    [buttonGallery setAlpha:0.8f];
    
    UILabel* labelGallery = [[UILabel alloc] initWithFrame:CGRectZero];
    [buttonGallery addSubview:labelGallery];
    [labelGallery setBackgroundColor:[UIColor clearColor]];
    [labelGallery setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:17.0f]];
    [labelGallery setTextColor:[UIColor whiteColor]];
    [labelGallery setText:@"Gallery"];
    [labelGallery sizeToFit];
    frame = labelGallery.frame;
    frame.origin.x = (fMainBtnWidth - frame.size.width)/2.0f;
    frame.origin.y = (fMainBtnHeight - frame.size.height)/2.0f;
    labelGallery.frame = frame;
    
    UIButton* buttonYoutube = [[UIButton alloc] initWithFrame:CGRectMake(fMainBtnMarginLeft + fMainBtnWidth + fMainBtnMarginGap,
                                                                         fMainBtnMarginTop + fMainBtnHeight + fMainBtnMarginGap,
                                                                         fMainBtnWidth, fMainBtnHeight)];
    [self.view addSubview:buttonYoutube];
    [buttonYoutube setBackgroundColor:[UICommonUtility hexToColor:0x48A7AA withAlpha:[NSNumber numberWithFloat:1.0f]]];
    [buttonYoutube.layer setCornerRadius:fMainBtnCornerRadius];
    [buttonYoutube setAlpha:0.8f];
    
    UILabel* labelYoutube = [[UILabel alloc] initWithFrame:CGRectZero];
    [buttonYoutube addSubview:labelYoutube];
    [labelYoutube setBackgroundColor:[UIColor clearColor]];
    [labelYoutube setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:17.0f]];
    [labelYoutube setTextColor:[UIColor whiteColor]];
    [labelYoutube setText:@"YouTube"];
    [labelYoutube sizeToFit];
    frame = labelYoutube.frame;
    frame.origin.x = (fMainBtnWidth - frame.size.width)/2.0f;
    frame.origin.y = (fMainBtnHeight - frame.size.height)/2.0f;
    labelYoutube.frame = frame;
    
    
    /* news section */
    CGFloat fNewsBaseBtnMarginLeft = 15.0f, fNewsBaseBtnMarginFromBottom = 20.0f;
    CGFloat fNewsBaseBtnSize = 50.0f;
    UIButton* buttonNews = [[UIButton alloc] initWithFrame:CGRectMake(fNewsBaseBtnMarginLeft,
                                                                      self.view.frame.size.height - fNewsBaseBtnMarginFromBottom - fNewsBaseBtnSize,
                                                                      fNewsBaseBtnSize, fNewsBaseBtnSize)];
    [self.view addSubview:buttonNews];
    [buttonNews setBackgroundColor:[UICommonUtility hexToColor:0x48A7AA withAlpha:[NSNumber numberWithFloat:1.0f]]];
    
    UILabel* labelBigN = [[UILabel alloc] initWithFrame:CGRectZero];
    [buttonNews addSubview:labelBigN];
    [labelBigN setBackgroundColor:[UIColor clearColor]];
    [labelBigN setFont:[UIFont fontWithName:@"Optima-ExtraBlack" size:50.0f]];
    [labelBigN setTextColor:[UIColor whiteColor]];
    [labelBigN setText:@"N"];
    [labelBigN sizeToFit];
    
    frame = labelBigN.frame;
    frame.origin.x = (fNewsBaseBtnSize - frame.size.width)/2.0f;
    frame.origin.y = (fNewsBaseBtnSize - frame.size.height)/2.0f;
    labelBigN.frame = frame;
    
    CGFloat fNewsTitleMaxWidth = 230.0f;
    CGFloat fNewsTitleMarginLeft = 10.0f, fNewsTitleMarginFromBottom1 = 70.0f, fNewsTitleMarginFromBottom2 = 55.0f, fNewsTitleMarginFromBottom3 = 40.0f;
    if (!self.labelNews1) {
        self.labelNews1 = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.view addSubview:self.labelNews1];
        [self.labelNews1 setBackgroundColor:[UIColor clearColor]];
        [self.labelNews1 setFont:[UIFont systemFontOfSize:12.0f]];
        [self.labelNews1 setTextColor:[UICommonUtility hexToColor:0x9C9C9C withAlpha:[NSNumber numberWithFloat:1.0f]]];
        
        [self.labelNews1 setText:@"沿途｜小巡演｜桃園篇"];
        [self.labelNews1 sizeToFit];
        
        CGRect frame = self.labelNews1.frame;
        if (self.labelNews1.frame.size.width > fNewsTitleMaxWidth) {
            frame.size.width = fNewsTitleMaxWidth;
        }
        frame.origin.x = fNewsBaseBtnMarginLeft + fNewsBaseBtnSize + fNewsTitleMarginLeft;
        frame.origin.y = self.view.frame.size.height - fNewsTitleMarginFromBottom1;
        self.labelNews1.frame = frame;
    }
    
    if (!self.labelNews2) {
        self.labelNews2 = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.view addSubview:self.labelNews2];
        [self.labelNews2 setBackgroundColor:[UIColor clearColor]];
        [self.labelNews2 setFont:[UIFont systemFontOfSize:12.0f]];
        [self.labelNews2 setTextColor:[UICommonUtility hexToColor:0x9C9C9C withAlpha:[NSNumber numberWithFloat:1.0f]]];
        
        [self.labelNews2 setText:@"沿途｜小巡演｜台北篇"];
        [self.labelNews2 sizeToFit];
        
        CGRect frame = self.labelNews2.frame;
        if (self.labelNews2.frame.size.width > fNewsTitleMaxWidth) {
            frame.size.width = fNewsTitleMaxWidth;
        }
        frame.origin.x = fNewsBaseBtnMarginLeft + fNewsBaseBtnSize + fNewsTitleMarginLeft;
        frame.origin.y = self.view.frame.size.height - fNewsTitleMarginFromBottom2;
        self.labelNews2.frame = frame;
    }
    
    if (!self.labelNews3) {
        self.labelNews3 = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.view addSubview:self.labelNews3];
        [self.labelNews3 setBackgroundColor:[UIColor clearColor]];
        [self.labelNews3 setFont:[UIFont systemFontOfSize:12.0f]];
        [self.labelNews3 setTextColor:[UICommonUtility hexToColor:0x9C9C9C withAlpha:[NSNumber numberWithFloat:1.0f]]];
        
        [self.labelNews3 setText:@"沿途｜小巡演｜台中篇"];
        [self.labelNews3 sizeToFit];
        
        CGRect frame = self.labelNews3.frame;
        if (self.labelNews3.frame.size.width > fNewsTitleMaxWidth) {
            frame.size.width = fNewsTitleMaxWidth;
        }
        frame.origin.x = fNewsBaseBtnMarginLeft + fNewsBaseBtnSize + fNewsTitleMarginLeft;
        frame.origin.y = self.view.frame.size.height - fNewsTitleMarginFromBottom3;
        self.labelNews3.frame = frame;
    }
}

@end
