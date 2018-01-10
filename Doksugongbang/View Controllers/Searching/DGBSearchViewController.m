//
//  DGBSearchViewController.m
//  Doksugongbang
//
//  Created by USER on 2018. 1. 2..
//  Copyright © 2018년 USER. All rights reserved.
//

#import "DGBSearchViewController.h"
#import "UITableViewCell+DGBCellNameGenerator.h"
#import "DGBBook.h"
#import "DGBBookListViewController.h"
#import "DGBBookTitleTableViewCell.h"
#import "DGBDataLoader.h"
#import "AladinAPI.h"

@interface DGBSearchViewController () <UISearchResultsUpdating, UISearchBarDelegate, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>

#pragma mark - Private Properties

@property (strong, nonatomic) NSArray<DGBBook *> *bookList;

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
    
    [self setDefinesPresentationContext:YES];
    
    [self setUpSearchController];
    [self setUpSearchResultTableView];
    
    [self setUpConstraints];
}

#pragma mark - Set Up Methods

- (void)setUpSearchController {
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    
    [self.searchController setSearchResultsUpdater:self];
    [self.searchController setObscuresBackgroundDuringPresentation:NO];
    
    [self.searchController.searchBar setPlaceholder:@"책, 저자, 출판사 검색"];
    [self.searchController.searchBar setDelegate:self];
    
    [self.navigationItem setSearchController:self.searchController];
    [self.navigationItem setHidesSearchBarWhenScrolling:NO];
}

- (void)setUpSearchResultTableView {
    self.searchResultTableView = [[UITableView alloc] initWithFrame:CGRectZero
                                                              style:UITableViewStylePlain];
    
    [self.searchResultTableView setDelegate:self];
    [self.searchResultTableView setDataSource:self];
    
    [self.searchResultTableView setEstimatedRowHeight:44.0];
    [self.searchResultTableView setRowHeight:UITableViewAutomaticDimension];
    
    [self.searchResultTableView registerClass:[DGBBookTitleTableViewCell class]
                       forCellReuseIdentifier:[DGBBookTitleTableViewCell className]];
    
    [self.view addSubview:self.searchResultTableView];
}

- (void)setUpConstraints {
    [self.searchResultTableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    UILayoutGuide *rootViewSafeAreaLayoutGuide = self.view.safeAreaLayoutGuide;
    
    [NSLayoutConstraint activateConstraints:@[[self.searchResultTableView.topAnchor constraintEqualToAnchor:rootViewSafeAreaLayoutGuide.topAnchor],
                                              [self.searchResultTableView.bottomAnchor constraintEqualToAnchor:rootViewSafeAreaLayoutGuide.bottomAnchor],
                                              [self.searchResultTableView.leadingAnchor constraintEqualToAnchor:rootViewSafeAreaLayoutGuide.leadingAnchor],
                                              [self.searchResultTableView.trailingAnchor constraintEqualToAnchor:rootViewSafeAreaLayoutGuide.trailingAnchor]]];
}

#pragma mark - Private Methods

- (void)presentBookListViewControllerWithTitle:(NSString *)title {
    
    DGBBookListViewController *bookListViewController = [[DGBBookListViewController alloc] init];
    [bookListViewController setBookListTitle:title];
    
    [self showViewController:bookListViewController
                      sender:self];
}

#pragma mark - Search Results Updating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *searchString = searchController.searchBar.text;
    
    if (searchString.length > 0) {
        __weak typeof(self) weakSelf = self;
        
        NSURL *url = [AladinAPI aladinAPIURLWithPathName:AladinAPIItemSearch
                                              parameters:@{@"Query": searchString,
                                                           @"QueryType": @"Keyword",
                                                           @"SearchTarget": @"Book",
                                                           @"MaxResults": @"100"}];
        [[DGBDataLoader sharedInstance] fetchDataWithURL:url
                                              completion:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                  NSArray<DGBBook *> *bookList = [AladinAPI bookListParsingFromJSONData:data];
                                                  
                                                  dispatch_async(dispatch_get_main_queue(), ^{
                                                      [weakSelf setBookList:bookList];
                                                      [weakSelf.searchResultTableView reloadData];
                                                  });
                                              }];
    } else {
        self.bookList = nil;
        [self.searchResultTableView reloadData];
    }
}

#pragma mark - Search Bar Delegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSString *bookTitle = searchBar.text;
    
    [self presentBookListViewControllerWithTitle:bookTitle];
}

#pragma mark - Scroll View Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.searchController.searchBar resignFirstResponder];
}

#pragma mark - Table View Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DGBBook *book = self.bookList[indexPath.row];
    
    [self presentBookListViewControllerWithTitle:book.title];
}

#pragma mark - Table View Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.bookList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DGBBookTitleTableViewCell *bookTitleTableViewCell = [tableView dequeueReusableCellWithIdentifier:[DGBBookTitleTableViewCell className]
                                                                                        forIndexPath:indexPath];
    
    DGBBook *book = self.bookList[indexPath.row];
    [bookTitleTableViewCell.bookTitleLabel setText:book.title];
    
    return bookTitleTableViewCell;
}

@end
