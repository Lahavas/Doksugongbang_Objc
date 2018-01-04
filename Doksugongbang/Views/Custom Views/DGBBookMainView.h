//
//  DGBBookMainView.h
//  Doksugongbang
//
//  Created by USER on 2018. 1. 3..
//  Copyright © 2018년 USER. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DGBBook;
@class DGBBookCoverView;

@interface DGBBookMainView : UIView

#pragma mark - Public Properties

@property (strong, nonatomic) DGBBook *book;

@property (strong, nonatomic) DGBBookCoverView *bookCoverView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *authorLabel;
@property (strong, nonatomic) UILabel *publisherLabel;
@property (strong, nonatomic) UILabel *pubDateLabel;

#pragma mark - Public Methods

- (void)setContentsWithBook:(DGBBook *)book;
- (void)updateBookCoverWithImage:(UIImage *)image;

@end
