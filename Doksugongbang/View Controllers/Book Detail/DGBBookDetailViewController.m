//
//  DGBBookDetailViewController.m
//  Doksugongbang
//
//  Created by USER on 2018. 1. 4..
//  Copyright © 2018년 USER. All rights reserved.
//

#import "DGBBookDetailViewController.h"
#import "DGBBook.h"
#import "DGBBookMainView.h"
#import "AladinAPI.h"
#import "DGBDataLoader.h"

@interface DGBBookDetailViewController ()

@property (weak, nonatomic) IBOutlet DGBBookMainView *bookMainView;

@end

#pragma mark -

@implementation DGBBookDetailViewController

#pragma mark - View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.navigationItem setTitle:@"책 정보"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self updateBook];
}

#pragma mark - Set Up Methods

- (void)updateBook {
    __weak typeof(self) weakSelf = self;
    
    NSURL *url = [AladinAPI aladinAPIURLWithPathName:AladinAPIItemLookUp
                                          parameters:@{@"ItemId": self.isbn,
                                                       @"ItemIdType": @"ISBN13"}];
    [[DGBDataLoader sharedInstance] fetchDataWithURL:url
                                          completion:^(NSData *data, NSURLResponse *response, NSError *error) {
                                              DGBBook *book = [AladinAPI bookParsingFromJSONData:data];
                                              
                                              dispatch_async(dispatch_get_main_queue(), ^{
                                                  [weakSelf.bookMainView setContentsWithBook:book];
                                              });
                                          }];
}

@end
