//
//  PiaNewsViewController.m
//  PiaxStudio
//
//  Created by Bobie Chen on 7/25/14.
//  Copyright (c) 2014 Bobie Chen. All rights reserved.
//

#import "PiaNewsViewController.h"
#import "UICommonUtility.h"
#import "PiaNewsCell.h"

@interface PiaNewsViewController () <UITableViewDataSource, UITableViewDelegate>

/* UI elements */
@property (strong) UITableView* tableNews;

/* controls */
@property (strong) NSMutableArray* arrayNews;

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
    /* nav-bar items */
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
    
    
    /* news table */
    if (!self.tableNews)
    {
        self.tableNews = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height - 64.0f)];
        [self.view addSubview:self.tableNews];
        
        self.tableNews.dataSource = self;
        self.tableNews.delegate = self;
    }
    
    [self loadNewsFromPiaxStudio];
}

- (void)loadNewsFromPiaxStudio
{
    /*
        check if cached news exists. if available, load it into table; otherwise start fetching
     */
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"PiaxStudioNewsList"])
    {
        self.arrayNews = [[[NSUserDefaults standardUserDefaults] objectForKey:@"PiaxStudioNewsList"] mutableCopy];
        
        [self.tableNews reloadData];
    }
    else
    {
        [self _fetchingNewsWithCompletionHandler:^(NSMutableArray* arrayNews, NSError* error) {
            
            if (error)
            {
                /* show message on tableview to indicate something wrong */
            }
            else if (arrayNews)
            {
                self.arrayNews = [arrayNews copy];
                [[NSUserDefaults standardUserDefaults] setObject:self.arrayNews forKey:@"PiaxStudioNewsList"];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableNews reloadData];
                });
            }
            
        }];
    }
}

- (void)_fetchingNewsWithCompletionHandler:(void (^)(NSMutableArray*, NSError*))completion
{
    NSString* stringNewsAPI = @"http://piaxstudio.com/mobile/news/list";
    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:stringNewsAPI]];
    NSOperationQueue* q = [[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:request queue:q completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (connectionError)
        {
            NSLog(@"_fetchingNewsWithCompletionHandler connectionError: %@", [connectionError localizedDescription]);
            
            if (completion)
            {
                completion(nil, connectionError);
            }
        }
        else if (data)
        {
            NSDictionary* dictResponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            
            NSMutableArray* arrayNewsResults = [NSMutableArray arrayWithCapacity:0];
            
            NSError* error = nil;
            NSDictionary* dictResult = [dictResponse objectForKey:@"result"];
            if (dictResult)
            {
                NSArray* arrayData = [dictResult objectForKey:@"data"];
                if (arrayData)
                {
                    for (NSDictionary* dictNews in arrayData)
                    {
                        [arrayNewsResults addObject:dictNews];
                    }
                }
                else
                {
                    error = [NSError errorWithDomain:@"nil response data key: result" code:100 userInfo:nil];
                }
            }
            else
            {
                error = [NSError errorWithDomain:@"nil response data key: data" code:100 userInfo:nil];
            }
            
            if (completion)
            {
                completion(arrayNewsResults, error);
            }
        }
        else
        {
            NSLog(@"_fetchingNewsWithCompletionHandler nil response data");
            NSError* error = [NSError errorWithDomain:@"nil response data" code:100 userInfo:nil];
            completion(nil, error);
        }
    }];
}

#pragma mark - button functions
- (IBAction)closeNewsView:(id)sender
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - table view data-source & delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.arrayNews count] > 0)
    {
        return [self.arrayNews count];
    }
    else
    {
        return 0;
    }
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* stringCellIdentifier = @"PiaNewsCell";
    PiaNewsCell* newsCell = (PiaNewsCell*)[tableView dequeueReusableCellWithIdentifier:stringCellIdentifier];
    if (!newsCell)
    {
        newsCell = [[PiaNewsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stringCellIdentifier];
    }
    
    return newsCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f;
}

@end
