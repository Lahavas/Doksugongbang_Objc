//
//  DGBBookListViewController.m
//  Doksugongbang
//
//  Created by USER on 2018. 1. 3..
//  Copyright © 2018년 USER. All rights reserved.
//

#import "DGBBookListViewController.h"

#import "DGBBook.h"
#import "DGBBookMainView.h"
#import "DGBBookListTableViewCell.h"

#import "DGBBookDetailViewController.h"

#import "AladinAPI.h"

@interface DGBBookListViewController () <UITableViewDelegate, UITableViewDataSource>

@property (copy, nonatomic) NSArray<DGBBook *> *bookList;

@property (strong, nonatomic) UITableView *bookListTableView;

@end

#pragma mark -

@implementation DGBBookListViewController

#pragma mark - View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationItem setTitle:[NSString stringWithFormat:@"검색어: %@", self.bookTitle]];
    
    [self setUpBookListTableView];
    
    [self.view addSubview:self.bookListTableView];
    
    [self setUpConstraints];
    
    [self fetchBookListWithQueryString:self.bookTitle];
}

#pragma mark - Set Up Methods

- (void)setUpBookListTableView {
    self.bookListTableView = [[UITableView alloc] initWithFrame:CGRectZero
                                                          style:UITableViewStylePlain];
    
    [self.bookListTableView setDelegate:self];
    [self.bookListTableView setDataSource:self];
    
    UINib *bookListCellNib = [UINib nibWithNibName:[DGBBookListTableViewCell className]
                                            bundle:nil];
    [self.bookListTableView registerNib:bookListCellNib
                 forCellReuseIdentifier:[DGBBookListTableViewCell className]];
}

- (void)setUpConstraints {
    [self.bookListTableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    UILayoutGuide *rootViewSafeAreaLayoutGuide = self.view.safeAreaLayoutGuide;
    
    NSLayoutConstraint *bookListTableViewTopConstraint = [self.bookListTableView.topAnchor constraintEqualToAnchor:rootViewSafeAreaLayoutGuide.topAnchor];
    NSLayoutConstraint *bookListTableViewBottomConstraint = [self.bookListTableView.bottomAnchor constraintEqualToAnchor:rootViewSafeAreaLayoutGuide.bottomAnchor];
    NSLayoutConstraint *bookListTableViewLeadingConstraint = [self.bookListTableView.leadingAnchor constraintEqualToAnchor:rootViewSafeAreaLayoutGuide.leadingAnchor];
    NSLayoutConstraint *bookListTableViewTrailingConstraint = [self.bookListTableView.trailingAnchor constraintEqualToAnchor:rootViewSafeAreaLayoutGuide.trailingAnchor];
    
    [NSLayoutConstraint activateConstraints:@[bookListTableViewTopConstraint,
                                              bookListTableViewBottomConstraint,
                                              bookListTableViewLeadingConstraint,
                                              bookListTableViewTrailingConstraint]];
}

#pragma mark - Private Methods

- (void)fetchBookListWithQueryString:(NSString *)queryString {
    NSURL *url = [AladinAPI aladinAPIURLWithPathName:AladinAPIItemSearch
                                          parameters:@{@"Query": queryString,
                                                       @"QueryType": @"Keyword",
                                                       @"SearchTarget": @"Book",
                                                       @"MaxResults": @"100"}];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    
    __weak typeof(self) weakSelf = self;
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                    //                                                    NSLog(@"Got response %@ with error %@.\n", response, error);
                                                    dispatch_async(dispatch_get_main_queue(), ^{
                                                        weakSelf.bookList = [AladinAPI bookListParsingFromJSONData:data];
                                                        [weakSelf.bookListTableView reloadData];
                                                    });
                                                }];
    
    [dataTask resume];
}

#pragma mark - Table View Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 160.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DGBBook *book = self.bookList[indexPath.row];
    
    DGBBookDetailViewController *bookDetailViewController = [[DGBBookDetailViewController alloc] init];
    bookDetailViewController.book = book;
    
    [self showViewController:bookDetailViewController
                      sender:self];
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
