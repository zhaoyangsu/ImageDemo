//
//  ASShowImageViewController.h
//  ImageDemo
//
//  Created by xiu on 12-6-8.
//  Copyright (c) 2012年 AlphaStudio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASloadImageOperation.h"

@interface ASShowImageViewController : UIViewController<UIScrollViewDelegate>
{
    
    NSString* currentImageName;
    IBOutlet UIScrollView* imageScrollView;
    NSArray* imageArray;
    NSString* imagePath;
    NSString* tmpImagePath;
    
    
    NSUInteger tmpCurrentIndex;
    NSMutableArray* tempImageViewArray;
    
    NSUInteger imageCurrentIndex;
    
}


@property (nonatomic, retain) NSString* currentImageName;
@property (nonatomic, retain) NSString* imagePath;
@property (nonatomic, retain) NSString* tmpImagePath;
@end
