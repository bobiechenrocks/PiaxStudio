//
//  PiaMainViewController.m
//  PiaxStudio
//
//  Created by Bobie Chen on 2014/4/24.
//  Copyright (c) 2014年 Bobie Chen. All rights reserved.
//

#import "PiaMainViewController.h"
#import "UICommonUtility.h"
#import "PiaNavController.h"
#import "PiaNewsViewController.h"
#import "PiaNewsDetailViewController.h"

@interface PiaMainViewController ()

/* UI elements */
@property (strong) UIScrollView* newsTitleScroll;
@property (strong) UIButton* btnPia;
@property (strong) UIButton* btnYoutube;

/* controls */
@property (strong) NSTimer* newsTitleTimer;

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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateNewsTitles) name:@"PiaxStudioUpdateNewsTitles" object:nil];
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
    
    
    CGFloat fBtnPiaSize = 60.0f;
    if (!self.btnPia)
    {
        self.btnPia = [[UIButton alloc] initWithFrame:CGRectMake(-30.0f, 180.0f, fBtnPiaSize, fBtnPiaSize)];
        [self.view addSubview:self.btnPia];
        
        [self.btnPia setBackgroundColor:[UICommonUtility hexToColor:0x48A7AA withAlpha:[NSNumber numberWithFloat:1.0f]]];
        [self.btnPia.layer setCornerRadius:fBtnPiaSize/2];
        
        [self.btnPia addTarget:self action:@selector(btnPiaClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel* labelBigP = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.btnPia addSubview:labelBigP];
        [labelBigP setBackgroundColor:[UIColor clearColor]];
        [labelBigP setFont:[UIFont fontWithName:@"Optima-ExtraBlack" size:50.0f]];
        [labelBigP setTextColor:[UIColor whiteColor]];
        [labelBigP setText:@"P"];
        [labelBigP sizeToFit];
        
        CGRect frame = labelBigP.frame;
        frame.origin.x = (fBtnPiaSize - frame.size.width)/2.0f;
        frame.origin.y = (fBtnPiaSize - frame.size.height)/2.0f;
        labelBigP.frame = frame;
    }
    
    
    CGFloat fModuleButtonSize = 50.0f;
    if (!self.btnYoutube)
    {
        self.btnYoutube = [[UIButton alloc] initWithFrame:CGRectMake(60.0f, 140.0f, fModuleButtonSize, fModuleButtonSize)];
        [self.view addSubview:self.btnYoutube];
        
        [self.btnYoutube setImage:[UIImage imageNamed:@"main_yt.png"] forState:UIControlStateNormal];
        [self.btnYoutube setImage:[UIImage imageNamed:@"main_yt.png"] forState:UIControlStateHighlighted];
    }
    
    /* main function buttons */
    /*
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
     */
    
    
    /* news section */
    CGFloat fNewsBaseBtnMarginLeft = 15.0f, fNewsBaseBtnMarginFromBottom = 20.0f;
    CGFloat fNewsBaseBtnSize = 50.0f;
    UIButton* buttonNews = [[UIButton alloc] initWithFrame:CGRectMake(fNewsBaseBtnMarginLeft,
                                                                      self.view.frame.size.height - fNewsBaseBtnMarginFromBottom - fNewsBaseBtnSize,
                                                                      fNewsBaseBtnSize, fNewsBaseBtnSize)];
    [self.view addSubview:buttonNews];
    [buttonNews setBackgroundColor:[UICommonUtility hexToColor:0x48A7AA withAlpha:[NSNumber numberWithFloat:1.0f]]];
    [buttonNews addTarget:self action:@selector(btnNewsClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel* labelBigN = [[UILabel alloc] initWithFrame:CGRectZero];
    [buttonNews addSubview:labelBigN];
    [labelBigN setBackgroundColor:[UIColor clearColor]];
    [labelBigN setFont:[UIFont fontWithName:@"Optima-ExtraBlack" size:50.0f]];
    [labelBigN setTextColor:[UIColor whiteColor]];
    [labelBigN setText:@"N"];
    [labelBigN sizeToFit];
    
    CGRect frame = labelBigN.frame;
    frame.origin.x = (fNewsBaseBtnSize - frame.size.width)/2.0f;
    frame.origin.y = (fNewsBaseBtnSize - frame.size.height)/2.0f;
    labelBigN.frame = frame;
    
    [self updateNewsTitles];
}

- (void)updateNewsTitles
{
    /* get the latest 3 news titles */
    NSMutableArray* arrayNewsTitles = [NSMutableArray arrayWithCapacity:0];
    
    NSArray* arrayNews = [[NSUserDefaults standardUserDefaults] objectForKey:@"PiaxStudioNewsList"];
    if (arrayNews && [arrayNews count] > 0)
    {
        NSInteger nIndex = 0;
        NSDictionary* dictNews = [arrayNews objectAtIndex:nIndex];
        NSInteger nMaxShownTitles = 5;
        while (nIndex < nMaxShownTitles)
        {
            if (dictNews)
            {
                NSString* stringTitle = [dictNews objectForKey:@"title"];
                NSString* stringId = [dictNews objectForKey:@"id"];
                if (stringTitle && ![stringTitle isEqualToString:@""] && stringId && ![stringId isEqualToString:@""])
                {
                    NSDictionary* dictNewsTitleId = [NSDictionary dictionaryWithObjectsAndKeys:stringTitle, @"title", stringId, @"id", nil];
                    [arrayNewsTitles addObject:dictNewsTitleId];
                }
            }
            
            ++nIndex;
            if (nIndex >= [arrayNews count])
            {
                break;
            }
            
            dictNews = [arrayNews objectAtIndex:nIndex];
        }
        
        /* "more?" */
        if ([arrayNews count] > nMaxShownTitles)
        {
            NSDictionary* dictMoreNewsTitleId = [NSDictionary dictionaryWithObjectsAndKeys:@"更多?", @"title", @"9999", @"id", nil];
            [arrayNewsTitles addObject:dictMoreNewsTitleId];
        }
        
        /* hack: add the first title at the bottom to smooth the auto-scroll */
        dictNews = [arrayNews objectAtIndex:0];
        NSString* stringTitle = [dictNews objectForKey:@"title"];
        NSString* stringId = [dictNews objectForKey:@"id"];
        if (stringTitle && ![stringTitle isEqualToString:@""] && stringId && ![stringId isEqualToString:@""])
        {
            NSDictionary* dictNewsTitleId = [NSDictionary dictionaryWithObjectsAndKeys:stringTitle, @"title", stringId, @"id", nil];
            [arrayNewsTitles addObject:dictNewsTitleId];
        }
    }
    else
    {
        NSDictionary* dictMoreNewsTitleId = [NSDictionary dictionaryWithObjectsAndKeys:@"\u2190 點擊N查看PiA最新消息", @"title", @"9999", @"id", nil];
        [arrayNewsTitles addObject:dictMoreNewsTitleId];
    }
    
    
    CGFloat fNewsBaseBtnMarginLeft = 15.0f, fNewsBaseBtnSize = 50.0f, fNewsBaseBtnMarginFromBottom = 20.0f;;
    CGFloat fNewsTitleMarginLeft = 10.0f, fNewsTitleMaxWidth = 230.0f;
    if (!self.newsTitleScroll)
    {
        self.newsTitleScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(fNewsBaseBtnMarginLeft+fNewsBaseBtnSize+fNewsTitleMarginLeft,
                                                                              self.view.frame.size.height - fNewsBaseBtnMarginFromBottom - fNewsBaseBtnSize,
                                                                              fNewsTitleMaxWidth, fNewsBaseBtnSize)];
        [self.view addSubview:self.newsTitleScroll];
        
        [self.newsTitleScroll setPagingEnabled:YES];
        [self.newsTitleScroll setShowsVerticalScrollIndicator:NO];
    }
    else
    {
        for (UIView* subview in self.newsTitleScroll.subviews)
        {
            [subview removeFromSuperview];
        }
    }
    
    NSInteger nIndex = 0;
    for (NSDictionary* dictNewsTitleId in arrayNewsTitles)
    {
        UIButton* btnTitle = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, nIndex*self.newsTitleScroll.frame.size.height,
                                                                        self.newsTitleScroll.frame.size.width, self.newsTitleScroll.frame.size.height)];
        [self.newsTitleScroll addSubview:btnTitle];
        btnTitle.tag = [[dictNewsTitleId objectForKey:@"id"] intValue];
        [btnTitle addTarget:self action:@selector(newsTitleClicked:) forControlEvents:UIControlEventTouchUpInside];
        ++nIndex;
        
        UILabel* labelTitle = [[UILabel alloc] initWithFrame:CGRectZero];
        [btnTitle addSubview:labelTitle];
        [labelTitle setBackgroundColor:[UIColor clearColor]];
        [labelTitle setFont:[UIFont fontWithName:@"STHeitiTC-Light" size:17.0f]];
        [labelTitle setTextColor:[UICommonUtility hexToColor:0x9C9C9C withAlpha:[NSNumber numberWithFloat:1.0f]]];
        [labelTitle setNumberOfLines:2];
        
        [labelTitle setText:[dictNewsTitleId objectForKey:@"title"]];
        CGRect frame = labelTitle.frame;
        frame.size.width = fNewsTitleMaxWidth;
        labelTitle.frame = frame;
        [labelTitle sizeToFit];
        
        frame = labelTitle.frame;
        frame.origin.x = (fNewsTitleMaxWidth - labelTitle.frame.size.width)/2;
        frame.origin.y = (fNewsBaseBtnSize - labelTitle.frame.size.height)/2;
        labelTitle.frame = frame;
    }
    
    [self.newsTitleScroll setContentSize:CGSizeMake(self.newsTitleScroll.frame.size.width, (nIndex > 0)? nIndex*fNewsBaseBtnSize:fNewsBaseBtnSize)];
    [self _startNewsTitleTimer];
}

- (void)_startNewsTitleTimer
{
    if (self.newsTitleTimer)
    {
        [self.newsTitleTimer invalidate];
    }
    
    self.newsTitleTimer = [NSTimer scheduledTimerWithTimeInterval:2.5f target:self
                                                         selector:@selector(_autoScrollNewsTitle) userInfo:nil repeats:YES];
}

- (void)_autoScrollNewsTitle
{
    CGFloat fScrollContentHeight = self.newsTitleScroll.contentSize.height;
    if (fScrollContentHeight == self.newsTitleScroll.frame.size.height)
    {
        return;
    }
    
    CGFloat fCurrentScrollOffsetY = self.newsTitleScroll.contentOffset.y;
    if (fCurrentScrollOffsetY >= (fScrollContentHeight - self.newsTitleScroll.frame.size.height))
    {
        /* last one, scroll to top */
        CGPoint fOffset = CGPointMake(0.0f, 0.0f);
        [self.newsTitleScroll setContentOffset:fOffset animated:NO];
        [self _autoScrollNewsTitle];
    }
    else
    {
        /* scroll to next */
        CGFloat fNewOffset = fCurrentScrollOffsetY + self.newsTitleScroll.frame.size.height;
        CGPoint fOffset = CGPointMake(0.0f, fNewOffset);
        [self.newsTitleScroll setContentOffset:fOffset animated:YES];
    }

}

#pragma mark - button functions
- (IBAction)btnNewsClicked:(id)sender
{
    PiaNewsViewController* newsVC = [[PiaNewsViewController alloc] init];
    PiaNavController* navController = [[PiaNavController alloc] initWithRootViewController:newsVC];
    [self.navigationController presentViewController:navController animated:YES completion:nil];
}

- (IBAction)newsTitleClicked:(id)sender
{
    /* 
        check button tag: 9999 or normal id
     */
    
    UIButton* button = (UIButton*)sender;
    NSInteger nTag = button.tag;
    
    if (nTag == 9999)
    {
        /* enter news list view */
        PiaNewsViewController* newsVC = [[PiaNewsViewController alloc] init];
        PiaNavController* navController = [[PiaNavController alloc] initWithRootViewController:newsVC];
        [self.navigationController presentViewController:navController animated:YES completion:nil];
    }
    else
    {
        NSArray* arrayNews = [[NSUserDefaults standardUserDefaults] objectForKey:@"PiaxStudioNewsList"];
        if (arrayNews && [arrayNews count] > 0)
        {
            for (NSDictionary* dictNews in arrayNews)
            {
                NSInteger nId = [[dictNews objectForKey:@"id"] intValue];
                if (nId == nTag)
                {
                    PiaNewsViewController* newsVC = [[PiaNewsViewController alloc] init];
                    PiaNavController* navController = [[PiaNavController alloc] initWithRootViewController:newsVC];
                    PiaNewsDetailViewController* detailVC = [[PiaNewsDetailViewController alloc] init];
                    [detailVC prepareNewsDetailViewWithData:dictNews];
                    [navController pushViewController:detailVC animated:NO];
                    [self.navigationController presentViewController:navController animated:YES completion:nil];
                    
                    break;
                }
            }
        }
    }
}

- (IBAction)btnPiaClicked:(id)sender
{
    [UIView animateWithDuration:0.2f animations:^{
        
        CGRect frame = self.btnPia.frame;
        frame.origin.x = (frame.origin.x <= -30)? -10 : -30;
        self.btnPia.frame = frame;
        
    } completion:^(BOOL finished) {
        
    }];
}

@end
