//
//  DGBBookListViewController.m
//  Doksugongbang
//
//  Created by USER on 2018. 1. 3..
//  Copyright © 2018년 USER. All rights reserved.
//

#import "DGBBookListViewController.h"
#import "DGBBook.h"
#import "AladinAPI.h"

@interface DGBBookListViewController ()

@property (copy, nonatomic) NSArray<DGBBook *> *bookList;

@end

@implementation DGBBookListViewController

#pragma mark - View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self fetchBookListWithQueryString:self.bookTitle];
}

#pragma mark - Private Methods

- (void)fetchBookListWithQueryString:(NSString *)queryString {
    NSURL *url = [AladinAPI aladinAPIURLWithPathName:AladinAPIItemSearch
                                          parameters:@{@"Query": queryString,
                                                       @"QueryType": @"Keyword",
                                                       @"SearchTarget": @"Book"}];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    
    __weak typeof(self) weakSelf = self;
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                    //                                                    NSLog(@"Got response %@ with error %@.\n", response, error);
                                                    weakSelf.bookList = [AladinAPI bookListParsingFromJSONData:data];
                                                }];
    
    [dataTask resume];
}

@end
