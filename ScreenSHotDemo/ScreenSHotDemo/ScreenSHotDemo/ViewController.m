//
//  ViewController.m
//  ScreenSHotDemo
//
//  Created by izaodao on 17/3/16.
//  Copyright © 2017年 izaodao. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *shotButton = [UIButton buttonWithType:UIButtonTypeCustom];
    shotButton.backgroundColor = [UIColor redColor];
    [shotButton setTitle:@"截屏" forState:UIControlStateNormal];
    shotButton.frame = CGRectMake(100, 100, 100, 50);
    [shotButton addTarget:self action:@selector(pressToShotScreen:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shotButton];
    
    
    
    
    
    
}

-(void)pressToShotScreen:(UIButton *)button{
#define k_screenSize [UIScreen mainScreen].bounds.size
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(k_screenSize.width*2, k_screenSize.height*2), YES, 0);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGImageRef imageRef = viewImage.CGImage;
    CGRect rect = CGRectMake(0, 0, k_screenSize.width*2, k_screenSize.height*2);
    
    CGImageRef imageRefRect = CGImageCreateWithImageInRect(imageRef, rect);
    UIImage *sendImage = [[UIImage alloc]initWithCGImage:imageRefRect];
    
    UIImageWriteToSavedPhotosAlbum(sendImage, nil, nil, nil);
    NSData *imageViewData = UIImagePNGRepresentation(sendImage);
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectoty = [paths objectAtIndex:0];
    
    NSString *pictureName = @"screenShow.png";
    NSString *saveImagePath = [documentDirectoty stringByAppendingPathComponent:pictureName];
    [imageViewData writeToFile:saveImagePath atomically:YES];
    CGImageRelease(imageRefRect);
    
   // UIImage *bgImage2 = [[UIImage alloc]initWithContentsOfFile:saveImagePath];
    

}


@end
