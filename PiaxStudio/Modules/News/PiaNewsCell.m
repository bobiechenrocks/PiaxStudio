//
//  PiaNewsCell.m
//  PiaxStudio
//
//  Created by Bobie Chen on 7/26/14.
//  Copyright (c) 2014 Bobie Chen. All rights reserved.
//

#import "PiaNewsCell.h"
#import "UICommonUtility.h"

@interface PiaNewsCell ()

/* UI elements */
@property (strong) UILabel* labelTitle;
@property (strong) UILabel* labelDate;
@property (strong) UIView* viewTopSeparator;
@property (strong) UIView* viewBottomSeparator;

@end

@implementation PiaNewsCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.accessoryType = UITableViewCellAccessoryNone;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        CGRect frame = self.contentView.frame;
        frame.size.height = 44.0f;
        self.contentView.frame = frame;
        
        [self.contentView setBackgroundColor:[UICommonUtility hexToColor:0xF3F0E0 withAlpha:[NSNumber numberWithFloat:1.0f]]];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)prepareNewsCellWithTitle:(NSString*)stringTitle andDate:(NSString*)stringDate first:(BOOL)bFirst last:(BOOL)bLast
{
    /* title label */
    if (!self.labelTitle)
    {
        self.labelTitle = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:self.labelTitle];
        
        [self.labelTitle setBackgroundColor:[UIColor clearColor]];
        [self.labelTitle setFont:[UIFont fontWithName:@"STHeitiTC-Light" size:14.0f]];
        [self.labelTitle setTextColor:[UICommonUtility hexToColor:0x909090 withAlpha:[NSNumber numberWithFloat:1.0f]]];
    }
    
    [self.labelTitle setText:stringTitle];
    [self.labelTitle sizeToFit];
    
    CGRect frame = self.labelTitle.frame;
    if (frame.size.width > 290.0f)
    {
        frame.size.width = 290.0f;
    }
    frame.origin.x = 15.0f;
    frame.origin.y = 8.0f;
    self.labelTitle.frame = frame;
    

    /* date label */
    if (!self.labelDate)
    {
        self.labelDate = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:self.labelDate];
        
        [self.labelDate setBackgroundColor:[UIColor clearColor]];
        [self.labelDate setFont:[UIFont fontWithName:@"STHeitiTC-Light" size:10.0f]];
        [self.labelDate setTextColor:[UICommonUtility hexToColor:0x989898 withAlpha:[NSNumber numberWithFloat:1.0f]]];
    }
    
    [self.labelDate setText:[NSString stringWithFormat:@"Date: %@", stringDate]];
    [self.labelDate sizeToFit];
    
    frame = self.labelDate.frame;
    frame.origin.x = self.contentView.frame.size.width - 15.0f - frame.size.width;//15.0f;
    frame.origin.y = 28.0f;
    self.labelDate.frame = frame;
    
    
    /* custom separators */
    if (!self.viewTopSeparator)
    {
        self.viewTopSeparator = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.contentView.frame.size.width, 0.5f)];
        [self.contentView addSubview:self.viewTopSeparator];
        
        [self.viewTopSeparator setBackgroundColor:[UIColor lightGrayColor]];
    }
    
    [self.viewTopSeparator setHidden:bFirst];
    
    if (!self.viewBottomSeparator)
    {
        self.viewBottomSeparator = [[UIView alloc] initWithFrame:CGRectMake(0.0f, self.contentView.frame.size.height,
                                                                            self.contentView.frame.size.width, 0.5f)];
        [self.contentView addSubview:self.viewBottomSeparator];
        
        [self.viewBottomSeparator setBackgroundColor:[UIColor lightGrayColor]];
    }
}

@end
