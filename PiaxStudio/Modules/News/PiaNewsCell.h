//
//  PiaNewsCell.h
//  PiaxStudio
//
//  Created by Bobie Chen on 7/26/14.
//  Copyright (c) 2014 Bobie Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PiaNewsCell : UITableViewCell

- (void)prepareNewsCellWithTitle:(NSString*)stringTitle andDate:(NSString*)stringDate first:(BOOL)bFirst last:(BOOL)bLast;

@end
