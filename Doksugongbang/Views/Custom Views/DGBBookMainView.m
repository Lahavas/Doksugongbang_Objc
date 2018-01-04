//
//  DGBBookMainView.m
//  Doksugongbang
//
//  Created by USER on 2018. 1. 3..
//  Copyright © 2018년 USER. All rights reserved.
//

#import "DGBBookMainView.h"
#import "DGBBook.h"
#import "DGBBookCoverView.h"

@interface DGBBookMainView ()

@property (strong, nonatomic) UIStackView *labelStackView;

@end

#pragma mark -

@implementation DGBBookMainView

#pragma mark - Initialization

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setUpSubviews];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self setUpSubviews];
    }
    
    return self;
}

#pragma mark - Public Methods

- (void)setContentsWithBook:(DGBBook *)book {
    static NSDateFormatter *dateFormatter = nil;
    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy년 MM월 dd일"];
    }
    
    if (book) {
        NSString *title = [NSString stringWithFormat:@"%@", book.title];
        NSString *author = [NSString stringWithFormat:@"%@ 지음", book.author];
        NSString *publisher = [NSString stringWithFormat:@"%@ 펴냄", book.publisher];
        NSString *pubDate = [NSString stringWithFormat:@"%@ 출판", [dateFormatter stringFromDate:book.pubDate]];
        
        [self.titleLabel setText:title];
        [self.authorLabel setText:author];
        [self.publisherLabel setText:publisher];
        [self.pubDateLabel setText:pubDate];
        
        [self fetchImageWithURLString:book.coverURL];
    }
}

- (void)updateBookCoverWithImage:(UIImage *)image {
    [self.bookCoverView setBookCoverImage:image];
}

#pragma mark - Private Methods

- (void)setUpSubviews {
    CGFloat standardSpace = 4.0;
    
    _bookCoverView = [[DGBBookCoverView alloc] initWithFrame:CGRectZero];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _authorLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _publisherLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _pubDateLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    
    [self setUpLabelConfigurations];
    
    _labelStackView = [[UIStackView alloc] initWithArrangedSubviews:@[_titleLabel,
                                                                      _authorLabel,
                                                                      _publisherLabel,
                                                                      _pubDateLabel]];
    [self.labelStackView setAxis:UILayoutConstraintAxisVertical];
    [self.labelStackView setSpacing:standardSpace];
    [self.labelStackView setAlignment:UIStackViewAlignmentFill];
    [self.labelStackView setDistribution:UIStackViewDistributionFill];
    
    [self.labelStackView setCustomSpacing:standardSpace * 2.0
                                afterView:self.titleLabel];
    
    [self addSubview:self.bookCoverView];
    [self addSubview:self.labelStackView];
    
    [self setUpConstraints];
}

- (void)setUpLabelConfigurations {
    UIColor *titleTextColor = UIColor.blackColor;
    UIFont *titleFont = [UIFont preferredFontForTextStyle:UIFontTextStyleTitle3];
    
    UIColor *subtitleTextColor = UIColor.darkGrayColor;
    UIFont *subtitleFont = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption1];
    
    [self.titleLabel setTextColor:titleTextColor];
    [self.titleLabel setFont:titleFont];
    [self.titleLabel setAdjustsFontForContentSizeCategory:YES];
    [self.titleLabel setNumberOfLines:2];
    
    [self.authorLabel setTextColor:subtitleTextColor];
    [self.authorLabel setFont:subtitleFont];
    [self.authorLabel setAdjustsFontForContentSizeCategory:YES];
    [self.authorLabel setNumberOfLines:1];
    
    [self.publisherLabel setTextColor:subtitleTextColor];
    [self.publisherLabel setFont:subtitleFont];
    [self.publisherLabel setAdjustsFontForContentSizeCategory:YES];
    [self.publisherLabel setNumberOfLines:1];
    
    [self.pubDateLabel setTextColor:subtitleTextColor];
    [self.pubDateLabel setFont:subtitleFont];
    [self.pubDateLabel setAdjustsFontForContentSizeCategory:YES];
    [self.pubDateLabel setNumberOfLines:1];
}

- (void)setUpConstraints {
    CGFloat standardMargin = 8.0;
    
    UILayoutGuide *marginsGuide = self.layoutMarginsGuide;
    
    [self.bookCoverView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.labelStackView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self.bookCoverView setContentCompressionResistancePriority:999.0
                                                         forAxis:UILayoutConstraintAxisHorizontal];
    [self.bookCoverView setContentCompressionResistancePriority:999.0
                                                         forAxis:UILayoutConstraintAxisVertical];
    [self.bookCoverView setContentHuggingPriority:999.0
                                           forAxis:UILayoutConstraintAxisHorizontal];
    [self.bookCoverView setContentHuggingPriority:999.0
                                           forAxis:UILayoutConstraintAxisVertical];
    
    [self.titleLabel setContentCompressionResistancePriority:749.0
                                                     forAxis:UILayoutConstraintAxisVertical];
    [self.titleLabel setContentHuggingPriority:250.0
                                       forAxis:UILayoutConstraintAxisVertical];
    
    NSLayoutConstraint *bookCoverViewTopConstraint = [self.bookCoverView.topAnchor constraintEqualToAnchor:marginsGuide.topAnchor];
    NSLayoutConstraint *bookCoverViewBottomConstraint = [self.bookCoverView.bottomAnchor constraintEqualToAnchor:marginsGuide.bottomAnchor];
    NSLayoutConstraint *bookCoverViewLeadingConstraint = [self.bookCoverView.leadingAnchor constraintEqualToAnchor:marginsGuide.leadingAnchor];
    
    NSLayoutConstraint *labelStackViewTopConstraint = [self.labelStackView.topAnchor constraintEqualToAnchor:marginsGuide.topAnchor];
    NSLayoutConstraint *labelStackViewBottomConstraint = [self.labelStackView.bottomAnchor constraintLessThanOrEqualToAnchor:marginsGuide.bottomAnchor];
    NSLayoutConstraint *labelStackViewLeadingConstraint = [self.labelStackView.leadingAnchor constraintEqualToAnchor:self.bookCoverView.trailingAnchor
                                                                                                            constant:standardMargin];
    NSLayoutConstraint *labelStackViewTrailingConstraint = [self.labelStackView.trailingAnchor constraintEqualToAnchor:marginsGuide.trailingAnchor];
    
    [NSLayoutConstraint activateConstraints:@[bookCoverViewTopConstraint,
                                              bookCoverViewBottomConstraint,
                                              bookCoverViewLeadingConstraint]];
    [NSLayoutConstraint activateConstraints:@[labelStackViewTopConstraint,
                                              labelStackViewBottomConstraint,
                                              labelStackViewLeadingConstraint,
                                              labelStackViewTrailingConstraint]];
}

- (void)fetchImageWithURLString:(NSString *)urlString {
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                    __weak typeof(self) weakSelf = self;
                                                    
                                                    dispatch_async(dispatch_get_main_queue(), ^{
                                                        UIImage *image = [UIImage imageWithData:data];
                                                        [weakSelf updateBookCoverWithImage:image];
                                                    });
                                                }];
    [dataTask resume];
}

@end
