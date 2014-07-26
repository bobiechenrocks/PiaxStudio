//
//  PiaNavController.m
//  PiaxStudio
//
//  Created by Bobie Chen on 7/25/14.
//  Copyright (c) 2014 Bobie Chen. All rights reserved.
//

#import "PiaNavController.h"
#import "UICommonUtility.h"

@interface PiaNavController ()

@end

@implementation PiaNavController

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
    
    if ([self.navigationBar respondsToSelector:@selector(setBarTintColor:)])
    {
        [self.navigationBar setTranslucent:NO];
        [self.navigationBar setBarTintColor:[UICommonUtility hexToColor:0x48A7AA withAlpha:[NSNumber numberWithFloat:1.0f]]];
    }
    else
    {
        [[[[UIApplication sharedApplication] delegate] window] setBackgroundColor:[UICommonUtility hexToColor:0x48A7AA withAlpha:[NSNumber numberWithFloat:1.0f]]];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackTranslucent];
        [self.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    }
    
    /* remove navigation bar shadow */
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    
    /* remove navigation bar title shadow */
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], UITextAttributeTextColor,
                                                          [UIColor clearColor], UITextAttributeTextShadowColor,
                                                          nil, UITextAttributeTextShadowOffset,
                                                          nil, UITextAttributeFont, nil]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
