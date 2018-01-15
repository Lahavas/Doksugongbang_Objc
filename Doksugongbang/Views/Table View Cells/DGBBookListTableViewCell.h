//
//  DGBBookListTableViewCell.h
//  Doksugongbang
//
//  Created by USER on 2018. 1. 4..
//  Copyright © 2018년 USER. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DGBBook;

@interface DGBBookListTableViewCell : UITableViewCell

#pragma mark - Public Methods

- (void)updateBook:(DGBBook *)book;

@end
