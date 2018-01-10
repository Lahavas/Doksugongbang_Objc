//
//  DGBBookListViewController.m
//  Doksugongbang
//
//  Created by USER on 2018. 1. 3..
//  Copyright © 2018년 USER. All rights reserved.
//

#import "DGBBookListViewController.h"
#import "UITableViewCell+DGBCellNameGenerator.h"
#import "DGBBook.h"
#import "DGBBookMainView.h"
#import "DGBBookListTableViewCell.h"
#import "DGBBookDetailViewController.h"
#import "DGBDataLoader.h"
#import "AladinAPI.h"

@interface DGBBookListViewController () <UITableViewDelegate, UITableViewDataSource>

#pragma mark - Private Properties

@property (strong, nonatomic) UITableView *bookListTableView;
@property (strong, nonatomic) UIRefreshControl *refreshControl;

@end

#pragma mark -

@implementation DGBBookListViewController

#pragma mark - View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationItem setTitle:self.keyword];
    
    [self setUpBookListTableView];
    [self setUpRefreshControl];
    [self setUpConstraints];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self updateBookList];
}

#pragma mark - Set Up Methods

- (void)setUpBookListTableView {
    self.bookListTableView = [[UITableView alloc] initWithFrame:CGRectZero
                                                          style:UITableViewStylePlain];
    
    [self.bookListTableView setDelegate:self];
    [self.bookListTableView setDataSource:self];
    
    [self.bookListTableView setEstimatedRowHeight:160.0];
    [self.bookListTableView setRowHeight:UITableViewAutomaticDimension];
    
    [self.bookListTableView registerClass:[DGBBookListTableViewCell class]
                   forCellReuseIdentifier:[DGBBookListTableViewCell className]];
    
    [self.view addSubview:self.bookListTableView];
}

- (void)setUpRefreshControl {
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl setAttributedTitle:[[NSAttributedString alloc] initWithString:@"Pull To Refresh"]];
    [self.refreshControl setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    [self.refreshControl addTarget:self
                            action:@selector(updateBookList)
                  forControlEvents:UIControlEventValueChanged];
    
    [self.bookListTableView addSubview:self.refreshControl];
}

- (void)setUpConstraints {
    [self.bookListTableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    UILayoutGuide *rootViewSafeAreaLayoutGuide = self.view.safeAreaLayoutGuide;
    
    [NSLayoutConstraint activateConstraints:@[[self.bookListTableView.topAnchor constraintEqualToAnchor:rootViewSafeAreaLayoutGuide.topAnchor],
                                              [self.bookListTableView.bottomAnchor constraintEqualToAnchor:rootViewSafeAreaLayoutGuide.bottomAnchor],
                                              [self.bookListTableView.leadingAnchor constraintEqualToAnchor:rootViewSafeAreaLayoutGuide.leadingAnchor],
                                              [self.bookListTableView.trailingAnchor constraintEqualToAnchor:rootViewSafeAreaLayoutGuide.trailingAnchor]]];
}

- (void)updateBookList {
    __weak typeof(self) weakSelf = self;
    
    NSURL *url = [AladinAPI aladinAPIURLWithPathName:AladinAPIItemSearch
                                          parameters:@{@"Query": self.keyword,
                                                       @"QueryType": @"Keyword",
                                                       @"SearchTarget": @"Book",
                                                       @"MaxResults": @"100"}];
    [[DGBDataLoader sharedInstance] fetchDataWithURL:url
                                          completion:^(NSData *data, NSURLResponse *response, NSError *error) {
                                              weakSelf.bookList = [AladinAPI bookListParsingFromJSONData:data];
                                              
                                              dispatch_async(dispatch_get_main_queue(), ^{
                                                  if ([weakSelf.refreshControl isRefreshing]) {
                                                      [weakSelf.refreshControl endRefreshing];
                                                  }
                                                  
                                                  [weakSelf.bookListTableView reloadData];
                                              });
                                          }];
}

#pragma mark - Private Methods

- (void)presentBookDetailViewControllerWithISBN:(NSString *)isbnString {
    DGBBookDetailViewController *bookDetailViewController = [[DGBBookDetailViewController alloc] init];
    [bookDetailViewController setIsbn:isbnString];
    
    [self showViewController:bookDetailViewController
                      sender:self];
}

#pragma mark - Table View Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DGBBook *book = self.bookList[indexPath.row];
    [self presentBookDetailViewControllerWithISBN:book.isbn];
}

#pragma mark - Table View Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.bookList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DGBBookListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[DGBBookListTableViewCell className]
                                                                     forIndexPath:indexPath];
    
    DGBBook *book = self.bookList[indexPath.row];
    
    [cell.bookMainView setContentsWithBook:book];
    
    return cell;
}

@end
