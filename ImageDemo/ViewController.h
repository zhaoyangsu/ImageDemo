//
//  ViewController.h
//  ImageDemo
//
//  Created by xiu on 12-6-7.
//  Copyright (c) 2012年 AlphaStudio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSOperationQueue* thumbnailImageQueue;
    NSArray* filesArray;
}

-(void)prepareTheThumImage:(NSArray*)ImageArray;



@end

