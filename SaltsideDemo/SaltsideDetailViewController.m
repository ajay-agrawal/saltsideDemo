//
//  SaltsideDetailViewController.m
//  SaltsideDemo
//
//  Created by Ajay Agarwal on 11/22/15.
//  Copyright © 2015 Ajay Agarwal. All rights reserved.
//

#import "SaltsideDetailViewController.h"
#import "UIImageView+WebCache.h"

@implementation SaltsideDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createImageView];
}

/**
 *Author: Ajay Agrawal
 *Description: Create/Display the image view
 *Parameter: nil
 *Date: 23 November 2015
 **/
-(void)createImageView{
    UIImageView *detailImageView = [[UIImageView alloc] initWithFrame:CGRectMake(51.0f, self.navigationController.navigationBar.frame.size.height+20, 311, 207)];
    [self.view addSubview:detailImageView];
    // load the image view with SDWebImage
    [detailImageView sd_setImageWithURL:[NSURL URLWithString:self.detailViewData[@"image"]]
                      placeholderImage:[UIImage imageNamed:@"placeholder.png"]
                             completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                 // reset the imageview frame accroding to size of image
                                 CGRect oldImageFrame = detailImageView.frame;
                                 CGSize imageSize = image.size;
                                 oldImageFrame.size.width = imageSize.width;
                                 oldImageFrame.size.height = imageSize.height;
                                 oldImageFrame.origin.x = self.view.frame.size.width/2-imageSize.width/2;
                                 detailImageView.frame = oldImageFrame;
                             }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    self.detailViewData = nil;
}

@end
