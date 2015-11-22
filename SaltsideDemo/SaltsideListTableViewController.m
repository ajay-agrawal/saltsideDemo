//
//  SaltsideListTableViewController.m
//  SaltsideDemo
//
//  Created by Ajay Agarwal on 11/22/15.
//  Copyright © 2015 Ajay Agarwal. All rights reserved.
//

#import "SaltsideListTableViewController.h"
#import "SaltSideController.h"
#import "ListCell.h"
#import "SaltsideDetailViewController.h"

// server link from wher we get the data
#define DATA_LINK @"https://gist.githubusercontent.com/maclir/f715d78b49c3b4b3b77f/raw/8854ab2fe4cbe2a5919cea97d71b714ae5a4838d/items.json"

@interface SaltsideListTableViewController ()
@property (nonatomic,strong) UIView *noNetwrokView;
@property (nonatomic, strong) UIView *activityLoaderView;
@end

@implementation SaltsideListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"List";
    _listData = [[NSMutableArray alloc] init];
    // Do any additional setup after loading the view, typically from a nib.
    [self.tableView registerClass:[ListCell class] forCellReuseIdentifier:@"Cell"];
    
    [self getListData];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.view setAlpha:0];
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.view setAlpha:1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- custom methods
/**
 *Author: Ajay Agrawal
 *Description: Get the data from the server
 *Parameter: Nil
 *Date: 23 November 2015
 **/
-(void)getListData{
    SaltSideController *aController = [SaltSideController sharedInstance];
    // Check if host/network is available
    if ([aController isHostAvailable]) {
        // start the loader so that user understand data is coming from server
        [self createActivityLoaderView];
        [aController sendRequestWithURL:DATA_LINK completion:^(NSData *data, NSURLResponse *response, NSError *error) {
            // stop loader
            [self stopLoading];
            // if error is nil then load properview
            if (!error) {
                [self responseSucess:[aController parseJSONData:data withError:&error]];
            }else{
                // display the error to user
                [self createErrorView:error.localizedDescription];
            }
        }];
    }else{
        // if network not available then display network error message
        [self createErrorView:@"Network Unreachable, Please Try Again"];
    }
}


/**
 *Author: Ajay Agrawal
 *Description: if response is suceess then load the data in view
 *Parameter: id data
 *Date: 23 November 2015
 **/
-(void)responseSucess:(id)data{
    dispatch_async(dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        self.listData = data;
        [self.tableView reloadData];
    });
}

/**
 *Author: Ajay Agrawal
 *Description: Create error view with proper error message
 *Parameter: NSString errorText
 *Date: 23 November 2015
 **/
-(void)createErrorView:(NSString *)errorText{
    if (self.noNetwrokView == nil) {
        self.noNetwrokView = [[UIView alloc] initWithFrame:self.view.frame];
        self.noNetwrokView.backgroundColor = [UIColor whiteColor];
        
        CGFloat yPosition = 100;
        UILabel *noNetworkError = [[UILabel alloc] init];
        noNetworkError.text = errorText;
        CGFloat viewWidth = [self completeViewRect].size.width-20;
        CGSize errorTextSize = [errorText boundingRectWithSize:CGSizeMake(viewWidth, CGFLOAT_MAX) options:NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18.0f]} context:nil].size;
        noNetworkError.frame = CGRectMake(viewWidth/2-errorTextSize.width/2, yPosition, viewWidth, errorTextSize.height);
        noNetworkError.font = [UIFont systemFontOfSize:18.0f];
        [_noNetwrokView addSubview:noNetworkError];
        
        yPosition += 60.0f;
        UIButton *tryAgain = [UIButton buttonWithType:(UIButtonTypeCustom)];
        tryAgain.frame = CGRectMake([self completeViewRect].size.width/2-40.0f, yPosition, 80.0f, 40.0f);
        [tryAgain addTarget:self action:@selector(tryAgain) forControlEvents:(UIControlEventTouchUpInside)];
        tryAgain.backgroundColor = [UIColor grayColor];
        tryAgain.titleLabel.font = [UIFont systemFontOfSize:13.0f];
        [tryAgain setTitle:@"Try Again" forState:(UIControlStateNormal)];
        [tryAgain setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [_noNetwrokView addSubview:tryAgain];
    }
    [self.navigationController.view addSubview:self.noNetwrokView];
}

/**
 *Author: Ajay Agrawal
 *Description: Load the data again if network is available
 *Parameter: nil
 *Date: 23 November 2015
 **/
-(void)tryAgain{
    [self.noNetwrokView removeFromSuperview];
    [self getListData];
}

/**
 *Author: Ajay Agrawal
 *Description: Create/Display activity loader view
 *Parameter: nil
 *Date: 23 November 2015
 **/
-(void)createActivityLoaderView{
    self.activityLoaderView = [[UIView alloc] initWithFrame:[self completeViewRect]];
    self.activityLoaderView.alpha = 0.5;
    self.activityLoaderView.backgroundColor = [UIColor blackColor];
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityIndicator.center = CGPointMake(self.view.frame.size.width/2.0, self.view.frame.size.height/2.0);
    activityIndicator.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin);
    [activityIndicator startAnimating];
    [self.activityLoaderView addSubview:activityIndicator];
    [self.view addSubview:self.activityLoaderView];
}

/**
 *Author: Ajay Agrawal
 *Description: Remove activity loader view
 *Parameter: nil
 *Date: 23 November 2015
 **/
-(void)stopLoading{
    [self.activityLoaderView removeFromSuperview];
    self.activityLoaderView = nil;
}

/**
 *Author: Ajay Agrawal
 *Description: Get correct view rect
 *Parameter: nil
 *Date: 23 November 2015
 **/
-(CGRect)completeViewRect{
    CGRect viewBond = self.view.bounds;
    viewBond.origin.x = 0.0f;
    viewBond.origin.y = 0.0f;
    return viewBond;
}

#pragma mark- UITableViewDelegate Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.listData count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *cellDataSrc = [NSDictionary dictionaryWithDictionary:[self.listData objectAtIndex:indexPath.row]];
    static NSString *CellIdentifier = @"Cell";
    ListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[ListCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:CellIdentifier];
    }
    cell.cellData = cellDataSrc;
    cell.titleLblView.text = cellDataSrc[@"title"];
    cell.descriptionLblView.text = cellDataSrc[@"description"];
    return cell;
}

#pragma Mark- UITableViewDataSource Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // get the tapped cell information with indexPath
    ListCell *cell = (ListCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    SaltsideDetailViewController *detailViewController = [[SaltsideDetailViewController alloc] init];
    // set the data of detail view for displaying image
    detailViewController.detailViewData = cell.cellData;
    [self.navigationController pushViewController:detailViewController animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45.0f;
}

#pragma Mark- Memory method
-(void)dealloc{
    self.listData = nil;
    self.noNetwrokView = nil;
    self.activityLoaderView = nil;
}

@end
