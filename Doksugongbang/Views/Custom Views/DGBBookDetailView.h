//
//  DGBBookDetailView.h
//  Doksugongbang
//
//  Created by USER on 2018. 1. 9..
//  Copyright © 2018년 USER. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DGBBook;

@interface DGBBookDetailView : UIView

#pragma mark - Public Methods

- (void)setContentsWithBook:(DGBBook *)book;

@end
