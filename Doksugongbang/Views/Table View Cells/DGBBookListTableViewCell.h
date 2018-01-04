//
//  DGBBookListTableViewCell.h
//  Doksugongbang
//
//  Created by USER on 2018. 1. 4..
//  Copyright © 2018년 USER. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DGBBookMainView;

@interface DGBBookListTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet DGBBookMainView *bookMainView;

#pragma mark - Class Methods

+ (NSString *)className;

@end
