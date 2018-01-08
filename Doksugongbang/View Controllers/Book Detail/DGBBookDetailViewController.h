//
//  DGBBookDetailViewController.h
//  Doksugongbang
//
//  Created by USER on 2018. 1. 4..
//  Copyright © 2018년 USER. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DGBBook;

@interface DGBBookDetailViewController : UIViewController

#pragma mark - Public Properties

@property (strong, nonatomic) NSString *isbn;

@property (strong, nonatomic) DGBBook *book;

@end
