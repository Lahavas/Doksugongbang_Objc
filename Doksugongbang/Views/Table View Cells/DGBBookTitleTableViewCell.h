//
//  DGBBookTitleTableViewCell.h
//  Doksugongbang
//
//  Created by USER on 2018. 1. 3..
//  Copyright © 2018년 USER. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DGBBookTitleTableViewCell : UITableViewCell

#pragma mark - Public IBOutlet Properties

@property (weak, nonatomic) IBOutlet UILabel *bookTitleLabel;

#pragma mark - Class Methods

+ (NSString *)className;

@end
