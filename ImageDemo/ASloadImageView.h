//
//  ASloadImageView.h
//  ImageDemo
//
//  Created by xiu on 12-6-10.
//  Copyright (c) 2012年 AlphaStudio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ASloadImageView : UIView
{
    NSString* imagePath;
    UIImage* thumbnailImage;
    BOOL isThumbnailIamge;
}

@property (nonatomic, retain)NSString* imagePath;
@property (nonatomic, assign)BOOL isThumbnailIamge;
-(void)loadCurrentImage;

@end
