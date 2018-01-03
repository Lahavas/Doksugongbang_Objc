//
//  DGBSearchViewController.m
//  Doksugongbang
//
//  Created by USER on 2018. 1. 2..
//  Copyright © 2018년 USER. All rights reserved.
//

#import "DGBSearchViewController.h"
#import "DGBBook.h"
#import "AladinAPI.h"

@interface DGBSearchViewController () <UISearchResultsUpdating, UITableViewDelegate, UITableViewDataSource>

#pragma mark - Private Properties

@property (strong, nonatomic) UISearchController *searchController;
@property (strong, nonatomic) UITableView *tableView;

@end

#pragma mark -

@implementation DGBSearchViewController

#pragma mark - View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    [self.searchController setSearchResultsUpdater:self];
    [self.searchController.searchBar setPlaceholder:@"책, 저자, 출판사 검색"];
    [self.navigationItem setSearchController:self.searchController];
    
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
}

#pragma mark - Private Methods

- (void)tempWithString:(NSString *)queryString {
    NSURL *url = [AladinAPI aladinAPIURLWithPathName:AladinAPIItemSearch
                                          parameters:@{@"Query": queryString,
                                                       @"QueryType": @"Keyword",
                                                       @"SearchTarget": @"Book"}];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                    NSLog(@"Got response %@ with error %@.\n", response, error);
                                                    NSArray<DGBBook *> *bookList = [AladinAPI bookListParsingFromJSONData:data];
                                                    [bookList enumerateObjectsUsingBlock:^(DGBBook * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                                                        NSLog(@"%@", obj.title);
                                                    }];
                                                }];
    
    [dataTask resume];
}

#pragma mark - Search Results Updating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *searchString = searchController.searchBar.text;
    
    if (searchString.length > 0) {
        [self tempWithString:searchString];
    }
}

#pragma mark - Table View Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [[UITableViewCell alloc] init];
}

@end
