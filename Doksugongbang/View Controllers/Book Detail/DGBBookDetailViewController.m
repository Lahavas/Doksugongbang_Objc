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
#import "DGBBookDetailView.h"
#import "AladinAPI.h"
#import "DGBDataLoader.h"

@interface DGBBookDetailViewController () <DGBBookDetailViewDelegate>

#pragma mark - Private Properties

@property (strong, nonatomic) NSString *isbn;

@property (weak, nonatomic) IBOutlet DGBBookMainView *bookMainView;
@property (weak, nonatomic) IBOutlet DGBBookDetailView *bookDetailView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) UIRefreshControl *refreshControl;

@end

#pragma mark -

@implementation DGBBookDetailViewController

#pragma mark - Initialization

- (instancetype)initWithBookISBN:(NSString *)isbn {
    self = [super init];
    
    if (self) {
        _isbn = isbn;
    }
    
    return self;
}

#pragma mark - View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.navigationItem setTitle:@"책 정보"];
    
    [self.bookDetailView setDelegate:self];
    
    [self setUpRefreshControl];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self updateBook];
}

#pragma mark - Set Up Methods

- (void)setUpRefreshControl {
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl setAttributedTitle:[[NSAttributedString alloc] initWithString:@"Pull To Refresh"]];
    [self.refreshControl setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    [self.refreshControl addTarget:self
                            action:@selector(updateBook)
                  forControlEvents:UIControlEventValueChanged];
    
    [self.scrollView addSubview:self.refreshControl];
}

- (void)updateBook {
    __weak typeof(self) weakSelf = self;
    
    NSURL *url = [AladinAPI aladinAPIURLWithPathName:AladinAPIItemLookUp
                                          parameters:@{@"ItemId": self.isbn,
                                                       @"ItemIdType": @"ISBN13"}];
    [[DGBDataLoader sharedInstance] fetchDataWithURL:url
                                          completion:^(NSData *data, NSURLResponse *response, NSError *error) {
                                              DGBBook *book = [AladinAPI bookParsingFromJSONData:data];
                                              
                                              dispatch_async(dispatch_get_main_queue(), ^{
                                                  if ([weakSelf.refreshControl isRefreshing]) {
                                                      [weakSelf.refreshControl endRefreshing];
                                                  }
                                                  
                                                  [weakSelf.bookMainView setContentsWithBook:book];
                                                  [weakSelf.bookDetailView setContentsWithBook:book];
                                              });
                                          }];
}

#pragma mark - Book Detail View Delegate

- (void)bookDetailViewPresentSafariViewController:(SFSafariViewController *)safariViewController {
    [self presentViewController:safariViewController
                       animated:YES
                     completion:nil];
}

@end
