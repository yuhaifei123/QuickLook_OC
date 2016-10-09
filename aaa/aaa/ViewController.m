//
//  ViewController.m
//  aaa
//
//  Created by 虞海飞 on 16/10/9.
//  Copyright © 2016年 虞海飞. All rights reserved.
//

#import "ViewController.h"
#import <QuickLook/QuickLook.h>

@interface ViewController ()<QLPreviewControllerDelegate,QLPreviewControllerDataSource>

@property (nonatomic,strong) NSArray                *fileNames;
@property (nonatomic,strong) NSMutableArray         *fileURLs;
@property (nonatomic,strong) QLPreviewController    *quickLookController;

@end

// 屏幕高度
#define ScreenHeight            [[UIScreen mainScreen] bounds].size.height
// 屏幕宽度
#define ScreenWidth             [[UIScreen mainScreen] bounds].size.width

@implementation ViewController

-(NSArray *) fileNames{

    if (_fileNames == nil) {

        _fileNames = [NSArray arrayWithObjects:@"SycamoreTree_Keynote.key",@"SycamoreTree_Pages.pages",@"SycamoreTree_Pdf.pdf",@"SycamoreTree_Text.txt",@"SycamoreTree_Image.jpg",nil];
    }

    return _fileNames;
}

-(NSMutableArray *) fileURLs{

    if (_fileURLs == nil) {

        _fileURLs = [NSMutableArray new];
    }
    return _fileURLs;
}

- (QLPreviewController *)quickLookController{

    if (_quickLookController == nil) {

        _quickLookController = [[QLPreviewController alloc] init];
    }
    return _quickLookController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    [self createFileURLs];
    [self addQuick];
    [self.view addSubview:[self addButton]];

}


/**
 创造FileURLs
  */
- (void) createFileURLs{

    for (NSString *file  in self.fileNames) {

        NSArray *fileParts  = [file componentsSeparatedByString:@"."];
        NSURL *fileURL = [[NSBundle mainBundle]URLForResource:fileParts[0] withExtension:fileParts[1]];

        if ([[NSFileManager defaultManager] fileExistsAtPath:fileURL.path]) {

            [self.fileURLs addObject:fileURL];
        }
    }
}


-(void) addQuick{

    self.quickLookController.delegate = self;
    self.quickLookController.dataSource = self;
}

/**
 添加button
 */
-(UIButton *) addButton{

    UIButton *button = [[UIButton alloc] init];
    button.frame = CGRectMake(ScreenWidth/2-50, ScreenHeight/2-50, 100, 100);
    button.backgroundColor = [UIColor redColor];
    [button setTitle:@"hhhhhhh" forState:UIControlStateNormal];
    [button setTintColor:[UIColor redColor]];

    [button addTarget:self action:@selector(abc) forControlEvents:UIControlEventTouchUpInside];

    return button;
}

- (void) abc{

   // [self performSegueWithIdentifier:@"aa" sender:nil];

//    if QLPreviewController.canPreviewItem(fileURLs[indexPath.row]) {
//        quickLookController.currentPreviewItemIndex = indexPath.row
//        navigationController?.pushViewController(quickLookController, animated: true)
//    }

    BOOL ab  = [QLPreviewController canPreviewItem:self.fileURLs[0]];
    if (ab == true) {
       // quickLookController.currentPreviewItemIndex =
        self.quickLookController.currentPreviewItemIndex = 0;
        [self.navigationController pushViewController:self.quickLookController animated:true];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*********************** QLPreview 代理 方法  DataSource*********************/

- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller{

    return  self.fileURLs.count;
}

- (id<QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index{

    return self.fileURLs[index];
}

/*********************** QLPreview 代理 方法  Delegate*********************/

- (void)previewControllerWillDismiss:(QLPreviewController *)controller{
    NSLog(@"The Preview Controller will be dismissed");
}


- (void)previewControllerDidDismiss:(QLPreviewController *)controller{

    NSLog(@"The Preview Controller has been dismissed.");
}

- (BOOL)previewController:(QLPreviewController *)controller shouldOpenURL:(NSURL *)url forPreviewItem:(id<QLPreviewItem>)item{

    NSURL *urll =  (NSURL *)item;
    if (urll == self.fileURLs[0]) {

        return  true;
    }
    else{
        NSLog(@"Will not open URL \(url.absoluteString)");
    }
    return false;
}



@end
