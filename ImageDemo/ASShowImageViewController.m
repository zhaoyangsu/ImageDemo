//
//  ASShowImageViewController.m
//  ImageDemo
//
//  Created by xiu on 12-6-8.
//  Copyright (c) 2012年 AlphaStudio. All rights reserved.
//

#import "ASShowImageViewController.h"
#import "ASloadImageView.h"


@interface  ASShowImageViewController(hidden)

-(void)addImage:(UIImage*)image atPage:(NSUInteger) page isTmp:(BOOL)isTmp;
-(void)updateImage:(NSDictionary*)dic;
@end





#define KTEMP_IMAGE_COUNT   3
#define KBORDER         10




@implementation ASShowImageViewController
@synthesize currentImageName;
@synthesize imagePath;
@synthesize tmpImagePath;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {
        
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSError* error;
    NSArray* array =  [[NSFileManager defaultManager]contentsOfDirectoryAtPath:imagePath error:&error];
    if (!array) {
        NSLog(@"%@",error.description);
    }
    else
        imageArray = [[NSArray alloc]initWithArray:array];
    

    tempImageViewArray = [[NSMutableArray alloc]init];
    for (NSUInteger i = 0; i < KTEMP_IMAGE_COUNT *2 + 1 ; i++)
    {
        ASloadImageView* imageView = [[ASloadImageView alloc]init];
        [tempImageViewArray addObject:imageView];
        [imageView release];
    }
    
    
    
    
    imageScrollView.contentSize = CGSizeMake(self.view.frame.size.width * [imageArray count], self.view.frame.size.height);
    
    
    //加载当前图片的前五张和后五张,将对应的 tmp和image的 opration放进队列中
    tmpCurrentIndex = [imageArray indexOfObject:currentImageName];//页数是从0开始的
    
    imageCurrentIndex = tmpCurrentIndex;
    
    NSUInteger fromIndex ;
    if (tmpCurrentIndex >= KTEMP_IMAGE_COUNT ) 
    {
        fromIndex = tmpCurrentIndex - KTEMP_IMAGE_COUNT;
    }
    else
        fromIndex = 0;
    NSUInteger toIndex ;
    if (tmpCurrentIndex + KTEMP_IMAGE_COUNT <= [imageArray count] - 1 ) 
    {
        toIndex = tmpCurrentIndex + KTEMP_IMAGE_COUNT;
    }
    else
        toIndex = [imageArray count] - 1;
    
    
    [imageScrollView scrollRectToVisible:CGRectMake(self.view.frame.size.width * tmpCurrentIndex , 0, self.view.frame.size.width, self.view.frame.size.height) animated:NO];
    for (NSUInteger i = fromIndex;  i <= toIndex; i++)
    {
        NSString* path = [imagePath stringByAppendingPathComponent:[imageArray objectAtIndex:i]];
        NSUInteger index = i % (KTEMP_IMAGE_COUNT *2+1);
        ASloadImageView* view =  (ASloadImageView* )[tempImageViewArray objectAtIndex:index];
        view.imagePath = path;
        view.isThumbnailIamge = YES;
        view.frame = CGRectMake(i * 320, 0, 320, 460);
        [imageScrollView addSubview:view];
        
    }
        
    
}





- (void)viewDidUnload
{
    [imageArray release];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark -
#pragma UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint point =   scrollView.contentOffset;
    float page =  point.x / self.view.frame.size.width  ;//page 也从0开始
    
    NSLog(@"%f",page);
    
    
    
    if (page - 0.6> tmpCurrentIndex  )
    {
        ASloadImageView* view = [tempImageViewArray objectAtIndex:tmpCurrentIndex % (KTEMP_IMAGE_COUNT *2 +1)];
        
        
        [NSObject cancelPreviousPerformRequestsWithTarget:view];
        tmpCurrentIndex ++;
        if (tmpCurrentIndex + KTEMP_IMAGE_COUNT  <= [imageArray count]-1) {
            
            //            ASloadImageView *loadView = [[ASloadImageView alloc]init];
            NSUInteger index = (tmpCurrentIndex + KTEMP_IMAGE_COUNT )% ( KTEMP_IMAGE_COUNT * 2 + 1);
            ASloadImageView* view = [ tempImageViewArray objectAtIndex:index];
            //            [view removeFromSuperview];
            
            view.imagePath = [imagePath stringByAppendingPathComponent: [imageArray objectAtIndex:tmpCurrentIndex + KTEMP_IMAGE_COUNT]];
                       view.isThumbnailIamge = YES;
            view.frame = CGRectMake((tmpCurrentIndex + KTEMP_IMAGE_COUNT) * 320 , 0, 320, 460);
            if (![view.superview isKindOfClass:[UIScrollView class]]) {
                [imageScrollView addSubview:view];
            }
            //            
            
        }
    }
    else if(page + 0.6 < tmpCurrentIndex)
    {
        ASloadImageView* view = [tempImageViewArray objectAtIndex:tmpCurrentIndex % (KTEMP_IMAGE_COUNT *2 +1)];
        
        
        [NSObject cancelPreviousPerformRequestsWithTarget:view];
        tmpCurrentIndex --;
        if (tmpCurrentIndex >=  KTEMP_IMAGE_COUNT)
        {
            NSUInteger index = (tmpCurrentIndex -KTEMP_IMAGE_COUNT) % ( KTEMP_IMAGE_COUNT *2 +1);
            ASloadImageView* view = [tempImageViewArray objectAtIndex:index];
            view.imagePath =  [imagePath  stringByAppendingPathComponent:[imageArray objectAtIndex:tmpCurrentIndex - KTEMP_IMAGE_COUNT]];
            view.isThumbnailIamge = YES;
            view.frame = CGRectMake((tmpCurrentIndex -KTEMP_IMAGE_COUNT) * 320, 0, 320, 460);
            if (![view.superview isKindOfClass:[UIScrollView class]])
            {
                [imageScrollView addSubview:view];
            }
        }
    }
    
    //    NSUInteger index = tmpCurrentIndex % (KTEMP_IMAGE_COUNT *2 +1);
    //    
    //    ASloadImageView* view = [tempImageViewArray objectAtIndex:index];
    //    [view performSelector:@selector(loadCurrentImage) withObject:nil afterDelay:0.2];
    
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    CGPoint point =   scrollView.contentOffset;
    float page =  point.x / self.view.frame.size.width  ;//page 也从0开始
    
    NSLog(@"%f",page);
    
//    if (page - 0.3> imageCurrentIndex  )
//    {
//        imageCurrentIndex ++;
////        if (tmpCurrentIndex + KTEMP_IMAGE_COUNT  <= [imageArray count]-1) {
////            
//////            ASloadImageView *loadView = [[ASloadImageView alloc]init];
////            NSUInteger index = (tmpCurrentIndex + KTEMP_IMAGE_COUNT )% ( KTEMP_IMAGE_COUNT * 2 + 1);
////            ASloadImageView* view = [ tempImageViewArray objectAtIndex:index];
//////            [view removeFromSuperview];
////            
//////            view.imagePath = [imagePath stringByAppendingPathComponent: [imageArray objectAtIndex:tmpCurrentIndex + KTEMP_IMAGE_COUNT]];
//////            view.isThumbnailIamge = YES;
////            view.frame = CGRectMake((tmpCurrentIndex + KTEMP_IMAGE_COUNT) * 320 , 0, 320, 460);
////            if (![view.superview isKindOfClass:[UIScrollView class]]) {
////                [imageScrollView addSubview:view];
////            }
//////            
////
////        }
//    }
//    else if(page + 0.3 < imageCurrentIndex)
//    {
//        imageCurrentIndex --;
////        if (tmpCurrentIndex >=  KTEMP_IMAGE_COUNT)
////        {
////            NSUInteger index = (tmpCurrentIndex -KTEMP_IMAGE_COUNT) % ( KTEMP_IMAGE_COUNT *2 +1);
////            ASloadImageView* view = [tempImageViewArray objectAtIndex:index];
//////            view.imagePath =  [imagePath  stringByAppendingPathComponent:[imageArray objectAtIndex:tmpCurrentIndex - KTEMP_IMAGE_COUNT]];
//////            view.isThumbnailIamge = YES;
////            view.frame = CGRectMake((tmpCurrentIndex -KTEMP_IMAGE_COUNT) * 320, 0, 320, 460);
////            if (![view.superview isKindOfClass:[UIScrollView class]])
////            {
////                [imageScrollView addSubview:view];
////            }
////        }
//    }
    
    NSUInteger index = tmpCurrentIndex % (KTEMP_IMAGE_COUNT *2 +1);
    
    ASloadImageView* view = [tempImageViewArray objectAtIndex:index];
    [view loadCurrentImage];
//    [view performSelector:@selector(loadCurrentImage) withObject:nil afterDelay:7];
//    NSThread* thread = [[NSThread alloc]initWithTarget:view selector:@selector(loadCurrentImage) object:nil] ;
////    [thread performSelectorInBackground:@selector(loadCurrentImage) withObject:nil];
//    [thread performSelector:<#(SEL)#>;
//    [thread release];

}


#pragma mark -
#pragma  hidden

-(void)addImage:(ASloadImageView*)image atPage:(NSUInteger) page isTmp:(BOOL)isTmp
{
   
    ASloadImageView* imageView = image;
    imageView.frame = CGRectMake(self.view.frame.size.width * page  , 0,self.view.frame.size.width  ,self.view.frame.size.height);
}







@end
