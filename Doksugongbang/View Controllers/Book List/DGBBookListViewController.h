//
//  DGBBookListViewController.h
//  Doksugongbang
//
//  Created by USER on 2018. 1. 3..
//  Copyright © 2018년 USER. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DGBBook;

@interface DGBBookListViewController : UIViewController

#pragma mark - Public Methods

- (void)showBookListControllerWithTitle:(NSString *)title completion:(void (^)(void))completion;

@end
