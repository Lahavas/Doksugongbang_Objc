//
//  DGBBookMainView.h
//  Doksugongbang
//
//  Created by USER on 2018. 1. 3..
//  Copyright © 2018년 USER. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DGBBook;

@interface DGBBookMainView : UIView

#pragma mark - Public Methods

- (void)setContentsWithBook:(DGBBook *)book;
- (void)resetBookCoverView;

@end
