//
//  PiaNewsViewController.m
//  PiaxStudio
//
//  Created by Bobie Chen on 7/25/14.
//  Copyright (c) 2014 Bobie Chen. All rights reserved.
//

#import "PiaNewsViewController.h"
#import "UICommonUtility.h"

@interface PiaNewsViewController ()

@end

@implementation PiaNewsViewController

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
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.title = @"PiA News";
    
    [self prepareNewsView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareNewsView
{
    UIButton* btnClose = [[UIButton alloc] initWithFrame:CGRectZero];
    [btnClose addTarget:self action:@selector(closeNewsView:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel* labelClose = [[UILabel alloc] initWithFrame:CGRectZero];
    [btnClose addSubview:labelClose];
    [labelClose setBackgroundColor:[UIColor clearColor]];
    [labelClose setFont:[UIFont fontWithName:@"STHeitiTC-Light" size:17.0]];
    [labelClose setTextColor:[UIColor whiteColor]];
    [labelClose setText:@"關閉"];
    [labelClose sizeToFit];
    
    CGRect frame = btnClose.frame;
    frame.size.width = labelClose.frame.size.width;
    frame.size.height = labelClose.frame.size.height;
    btnClose.frame = frame;
    
    UIBarButtonItem* barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnClose];
    self.navigationItem.leftBarButtonItem = barButtonItem;
}

#pragma mark - button functions
- (IBAction)closeNewsView:(id)sender
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

@end
