//
//  DGBSearchViewController.m
//  Doksugongbang
//
//  Created by USER on 2018. 1. 2..
//  Copyright © 2018년 USER. All rights reserved.
//

#import "DGBSearchViewController.h"
#import "DGBBook.h"
#import "DGBBookTitleTableViewCell.h"
#import "AladinAPI.h"

@interface DGBSearchViewController () <UISearchResultsUpdating, UITableViewDelegate, UITableViewDataSource>

#pragma mark - Private Properties

@property (copy, nonatomic) NSArray<DGBBook *> *bookList;

@property (strong, nonatomic) UISearchController *searchController;
@property (strong, nonatomic) UITableView *searchResultTableView;

@end

#pragma mark -

@implementation DGBSearchViewController

#pragma mark - View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationItem setTitle:@"책 검색"];
    
    self.bookList = [[NSArray alloc] init];
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    [self.searchController setSearchResultsUpdater:self];
    [self.searchController setObscuresBackgroundDuringPresentation:false];
    [self.searchController.searchBar setPlaceholder:@"책, 저자, 출판사 검색"];
    [self.navigationItem setSearchController:self.searchController];
    [self.navigationItem setHidesSearchBarWhenScrolling:NO];
    
    self.searchResultTableView = [[UITableView alloc] initWithFrame:CGRectZero
                                                              style:UITableViewStylePlain];
    [self.searchResultTableView setDelegate:self];
    [self.searchResultTableView setDataSource:self];
    
    UINib *bookTitleCellNib = [UINib nibWithNibName:[DGBBookTitleTableViewCell className]
                                                      bundle:nil];
    [self.searchResultTableView registerNib:bookTitleCellNib
                     forCellReuseIdentifier:[DGBBookTitleTableViewCell className]];
    
    [self.view addSubview:self.searchResultTableView];
    
    [self setUpConstraints];
}

#pragma mark - Private Methods

- (void)setUpConstraints {
    [self.searchResultTableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    UILayoutGuide *rootViewSafeAreaLayoutGuide = self.view.safeAreaLayoutGuide;
    
    NSLayoutConstraint *searchResultTableViewTopConstraint = [self.searchResultTableView.topAnchor constraintEqualToAnchor:rootViewSafeAreaLayoutGuide.topAnchor];
    NSLayoutConstraint *searchResultTableViewBottomConstraint = [self.searchResultTableView.bottomAnchor constraintEqualToAnchor:rootViewSafeAreaLayoutGuide.bottomAnchor];
    NSLayoutConstraint *searchResultTableViewLeadingConstraint = [self.searchResultTableView.leadingAnchor constraintEqualToAnchor:rootViewSafeAreaLayoutGuide.leadingAnchor];
    NSLayoutConstraint *searchResultTableViewTrailingConstraint = [self.searchResultTableView.trailingAnchor constraintEqualToAnchor:rootViewSafeAreaLayoutGuide.trailingAnchor];
    
    [NSLayoutConstraint activateConstraints:@[searchResultTableViewTopConstraint,
                                              searchResultTableViewBottomConstraint,
                                              searchResultTableViewLeadingConstraint,
                                              searchResultTableViewTrailingConstraint]];
}

- (void)fetchSearchedBookTitleWithQueryString:(NSString *)queryString {
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
                                                    dispatch_async(dispatch_get_main_queue(), ^{
                                                        weakSelf.bookList = [AladinAPI bookListParsingFromJSONData:data];
                                                        [weakSelf.searchResultTableView reloadData];
                                                    });
                                                }];
    
    [dataTask resume];
}

#pragma mark - Search Results Updating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *searchString = searchController.searchBar.text;
    
    if (searchString.length > 0) {
        [self fetchSearchedBookTitleWithQueryString:searchString];
    } else {
        self.bookList = nil;
        [self.searchResultTableView reloadData];
    }
}

#pragma mark - Table View Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0;
}

#pragma mark - Table View Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.bookList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DGBBookTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[DGBBookTitleTableViewCell className]
                                                                              forIndexPath:indexPath];
    
    DGBBook *book = self.bookList[indexPath.row];
    [cell.bookTitleLabel setText:book.title];
    
    return cell;
}

@end
