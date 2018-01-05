//
//  DGBBookDetailViewController.m
//  Doksugongbang
//
//  Created by USER on 2018. 1. 4..
//  Copyright © 2018년 USER. All rights reserved.
//

#import "DGBBookDetailViewController.h"
#import "DGBBook.h"
#import "DGBBookLoader.h"
#import "AladinAPI.h"

@interface DGBBookDetailViewController ()

@end

#pragma mark -

@implementation DGBBookDetailViewController

#pragma mark - View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.navigationItem setTitle:@"책 정보"];
    
    NSLog(@"%@", self.book);
}

@end
