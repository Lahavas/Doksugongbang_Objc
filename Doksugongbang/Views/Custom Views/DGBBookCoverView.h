//
//  DGBBookCoverView.h
//  Doksugongbang
//
//  Created by USER on 2018. 1. 4..
//  Copyright © 2018년 USER. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DGBBookCoverView : UIView

#pragma mark - Public Properties

@property (strong, nonatomic) NSURL *recentURL;

#pragma mark - Public Methods

- (void)updateImageWithURL:(NSURL *)coverURL isbn:(NSString *)isbn;
- (void)resetBookCoverImage;

@end
