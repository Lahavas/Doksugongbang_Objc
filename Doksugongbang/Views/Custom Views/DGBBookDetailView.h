//
//  DGBBookDetailView.h
//  Doksugongbang
//
//  Created by USER on 2018. 1. 9..
//  Copyright © 2018년 USER. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SafariServices/SafariServices.h>

@class DGBBook;

@protocol DGBBookDetailViewDelegate
@required
- (void)bookDetailViewPresentSafariViewController:(SFSafariViewController *)safariViewController;
@end

@interface DGBBookDetailView : UIView

#pragma mark - Public Properties

@property (weak, nonatomic) id<DGBBookDetailViewDelegate> delegate;

#pragma mark - Public Methods

- (void)setContentsWithBook:(DGBBook *)book;

@end
