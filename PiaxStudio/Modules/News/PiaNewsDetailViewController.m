//
//  PiaNewsDetailViewController.m
//  PiaxStudio
//
//  Created by Bobie Chen on 7/28/14.
//  Copyright (c) 2014 Bobie Chen. All rights reserved.
//

#import "PiaNewsDetailViewController.h"
#import "UICommonUtility.h"

@interface PiaNewsDetailViewController () <UIGestureRecognizerDelegate>

/* UI elements */
@property (strong) UIScrollView* baseScroll;
@property (strong) UIImageView* imageNewsPhoto;
@property (strong) UILabel* labelTitle;
@property (strong) UILabel* labelDate;
@property (strong) UITextView* textContents;

@end

@implementation PiaNewsDetailViewController

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
    
    self.title = @"PiA News";
    
    /* nav-bar items */
    UIButton* btnClose = [[UIButton alloc] initWithFrame:CGRectZero];
    [btnClose addTarget:self action:@selector(backToNewsList:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel* labelClose = [[UILabel alloc] initWithFrame:CGRectZero];
    [btnClose addSubview:labelClose];
    [labelClose setBackgroundColor:[UIColor clearColor]];
    [labelClose setFont:[UIFont fontWithName:@"STHeitiTC-Light" size:17.0]];
    [labelClose setTextColor:[UIColor whiteColor]];
    [labelClose setText:@"返回"];
    [labelClose sizeToFit];
    
    CGRect frame = btnClose.frame;
    frame.size.width = labelClose.frame.size.width;
    frame.size.height = labelClose.frame.size.height;
    btnClose.frame = frame;
    
    UIBarButtonItem* barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnClose];
    self.navigationItem.leftBarButtonItem = barButtonItem;
    
    [self.view setBackgroundColor:[UICommonUtility hexToColor:0xF9F9E9 withAlpha:[NSNumber numberWithFloat:1.0f]]];
}

- (void)viewDidAppear:(BOOL)animated
{
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareNewsDetailViewWithData:(NSDictionary*)dictNews
{
    if (!self.baseScroll)
    {
        self.baseScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height - 64.0f)];
        [self.view addSubview:self.baseScroll];
    }
    
    CGFloat fCurrentY = 5.0f;
    
    NSString* stringNewsPhotoURL = [dictNews objectForKey:@"photo"];
    if (stringNewsPhotoURL && ![stringNewsPhotoURL isEqualToString:@""])
    {
        UIActivityIndicatorView* loadingIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [self.baseScroll addSubview:loadingIndicator];
        [loadingIndicator startAnimating];
        
        CGRect frame = loadingIndicator.frame;
        frame.origin.x = (self.baseScroll.frame.size.width - frame.size.width)/2;
        frame.origin.y = (196.0f - frame.size.height)/2;
        loadingIndicator.frame = frame;
        
        if (!self.imageNewsPhoto)
        {
            self.imageNewsPhoto = [[UIImageView alloc] initWithFrame:CGRectMake(13.0f, 5.0f, 294.0f, 196.0f)];
            [self.baseScroll addSubview:self.imageNewsPhoto];
        }
        
        fCurrentY += 196.0f + 5.0f;
        
        [self _fetchNewsPhoto:stringNewsPhotoURL];
    }
    
    NSString* stringTitle = [dictNews objectForKey:@"title"];
    if (stringTitle && ![stringTitle isEqualToString:@""])
    {
        if (!self.labelTitle)
        {
            self.labelTitle = [[UILabel alloc] initWithFrame:CGRectZero];
            [self.baseScroll addSubview:self.labelTitle];
            
            [self.labelTitle setBackgroundColor:[UIColor clearColor]];
            [self.labelTitle setFont:[UIFont fontWithName:@"STHeitiTC-Medium" size:15.0f]];
            [self.labelTitle setTextColor:[UICommonUtility hexToColor:0x707070 withAlpha:[NSNumber numberWithFloat:1.0f]]];
            [self.labelTitle setNumberOfLines:0.0];
        }
        
        CGRect frame = self.labelTitle.frame;
        frame.size.width = 294.0f;
        self.labelTitle.frame = frame;
        
        [self.labelTitle setText:stringTitle];
        [self.labelTitle sizeToFit];
        
        frame = self.labelTitle.frame;
        if (frame.size.width > 294.0f) frame.size.width = 294.0f;
        frame.origin.x = 13.0f;
        frame.origin.y = fCurrentY;
        self.labelTitle.frame = frame;
        
        fCurrentY += frame.size.height + 5.0f;
    }
    
    NSString* stringDate = [dictNews objectForKey:@"date"];
    if (stringDate && ![stringDate isEqualToString:@""])
    {
        if (!self.labelDate)
        {
            self.labelDate = [[UILabel alloc] initWithFrame:CGRectZero];
            [self.baseScroll addSubview:self.labelDate];
            
            [self.labelDate setBackgroundColor:[UIColor clearColor]];
            [self.labelDate setFont:[UIFont fontWithName:@"STHeitiTC-Light" size:10.0f]];
            [self.labelDate setTextColor:[UICommonUtility hexToColor:0x989898 withAlpha:[NSNumber numberWithFloat:1.0f]]];
        }
        
        [self.labelDate setText:[NSString stringWithFormat:@"Date: %@", stringDate]];
        [self.labelDate sizeToFit];
        
        CGRect frame = self.labelDate.frame;
        frame.origin.x = self.baseScroll.frame.size.width - 13.0f - frame.size.width;
        frame.origin.y = fCurrentY;
        self.labelDate.frame = frame;
        
        fCurrentY += frame.size.height + 5.0f;
    }
    
    NSString* stringNewsId = [dictNews objectForKey:@"id"];
    if (stringNewsId && ![stringNewsId isEqualToString:@""])
    {
        if (!self.textContents)
        {
            self.textContents = [[UITextView alloc] initWithFrame:CGRectMake(15.0f, fCurrentY, 290.0f, 0.0f)];
            [self.baseScroll addSubview:self.textContents];
            
            [self.textContents setBackgroundColor:[UIColor clearColor]];
            [self.textContents setFont:[UIFont fontWithName:@"STHeitiTC-Light" size:12.0f]];
            [self.textContents setTextColor:[UICommonUtility hexToColor:0x707070 withAlpha:[NSNumber numberWithFloat:1.0f]]];
            
            [self.textContents setScrollEnabled:NO];
            [self.textContents setDataDetectorTypes:UIDataDetectorTypeAll];
            [self.textContents setEditable:NO];
        }
        
        [self _fetchNewsContents:stringNewsId];
    }
    
    /* remember to update scollview content-size */
}

- (void)_fetchNewsPhoto:(NSString*)stringURL
{
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:stringURL]];
    [request setHTTPMethod:@"GET"];
    NSOperationQueue* queue = [[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:queue
                           completionHandler:^(NSURLResponse* response, NSData* responseData, NSError* error)
     {
         if (error == nil)
         {
             dispatch_async(dispatch_get_main_queue(), ^{
                 UIImage* image = [UIImage imageWithData:responseData];
                 self.imageNewsPhoto.image = image;
             });
             
         }
         else
         {
             NSLog(@"loadThumbnailData response failure");
         }
     }];

}

- (void)_fetchNewsContents:(NSString*)stringNewsId
{
    /* use cached contents if already exists */
    NSString* stringContents = @"";
    NSArray* arrayNews = [[NSUserDefaults standardUserDefaults] objectForKey:@"PiaxStudioNewsList"];
    if (arrayNews && ([arrayNews count] > 0))
    {
        for (NSDictionary* dictNews in arrayNews)
        {
            NSString* stringId = [dictNews objectForKey:@"id"];
            if (stringId && [stringId isEqualToString:stringNewsId])
            {
                stringContents = [dictNews objectForKey:@"content"];
                break;
            }
        }
    }
    
    if (stringContents && ![stringContents isEqualToString:@""])
    {
        [self _updateNewsContentsAndScroll:stringContents];
        return;
    }
    
    /* fetch contents if no cache available */
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://piaxstudio.com/mobile/news/view"]];
    [request setHTTPMethod:@"POST"];
    
    NSString* stringPayload = [NSString stringWithFormat:@"id=%@", stringNewsId];
    
    NSData *data = [stringPayload dataUsingEncoding:NSUTF8StringEncoding];
    [request addValue:@"8bit" forHTTPHeaderField:@"Content-Transfer-Encoding"];
    [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request addValue:[NSString stringWithFormat:@"%d", [data length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:data];
    
    NSOperationQueue* queue = [[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        NSDictionary* dictResponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSDictionary* dictResult = [dictResponse objectForKey:@"result"];
        if (dictResult)
        {
            NSString* stringStatus = [dictResult objectForKey:@"status"];
            NSDictionary* dictData = [dictResult objectForKey:@"data"];
            if ([stringStatus isEqualToString:@"SUCCESS"] && dictData)
            {
                NSString* stringContents = [dictData objectForKey:@"content"];
                
                if (stringContents && ![stringContents isEqualToString:@""])
                {
                    [self _updateNewsContentsAndScroll:[self _htmlFlatten:stringContents]];
                    
                    NSMutableArray* arrayNews = [[[NSUserDefaults standardUserDefaults] objectForKey:@"PiaxStudioNewsList"] mutableCopy];
                    BOOL bUpdated = NO;
                    for (NSDictionary* dictNews in arrayNews)
                    {
                        NSString* stringId = [dictNews objectForKey:@"id"];
                        if (stringId && [stringId isEqualToString:stringNewsId])
                        {
                            NSMutableDictionary* dictUpdatedNews = [dictNews mutableCopy];
                            [dictUpdatedNews setObject:[self _htmlFlatten:stringContents] forKey:@"content"];
                            NSInteger nIndex = [arrayNews indexOfObject:dictNews];
                            [arrayNews replaceObjectAtIndex:nIndex withObject:dictUpdatedNews];
                            
                            bUpdated = YES;
                            break;
                        }
                    }
                    
                    if (bUpdated)
                    {
                        [[NSUserDefaults standardUserDefaults] setObject:arrayNews forKey:@"PiaxStudioNewsList"];
                    }
                }
            }
        }
    }];
}

- (void)_updateNewsContentsAndScroll:(NSString*)stringContents
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.textContents setText:stringContents];
        [self.textContents sizeToFit];
        if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0f)
        {
            CGRect frame = self.textContents.frame;
            frame.size.height = self.textContents.contentSize.height;
            self.textContents.frame = frame;
        }

        CGFloat fContentHeight = self.textContents.frame.origin.y + self.textContents.frame.size.height + 5.0f;
        [self.baseScroll setContentSize:CGSizeMake(self.baseScroll.frame.size.width, fContentHeight)];
    });
}

- (NSString*)_htmlFlatten:(NSString*)html
{
    NSScanner* scanner;
    NSString* tag = nil;
    scanner = [NSScanner scannerWithString:html];
    
    while (![scanner isAtEnd]) {
        [scanner scanUpToString:@"<" intoString:nil];
        [scanner scanUpToString:@">" intoString:&tag];
        
        if ([tag isEqualToString:@"</p"])
            html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>", tag] withString:@"\n"];
        else if ([tag isEqualToString:@"<br /"])
            html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>", tag] withString:@"\n"];
        else
            html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>", tag] withString:@""];
    }
    
    return html;
}

#pragma mark - button function
- (IBAction)backToNewsList:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return YES;
}

@end
