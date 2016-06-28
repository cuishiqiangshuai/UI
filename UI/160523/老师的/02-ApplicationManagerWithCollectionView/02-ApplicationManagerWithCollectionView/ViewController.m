//
//  ViewController.m
//  02-ApplicationManagerWithCollectionView
//
//  Created by qingyun on 16/5/23.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "ViewController.h"
#import "QYAppCell.h"
#import "QYAppModel.h"
@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) NSArray *apps;
@end

@implementation ViewController

static NSString *itemIdentifier = @"item";
static NSString *headerIdentifier = @"header";
static NSString *footerIdentifier = @"footer";
-(NSArray *)apps{
    if (_apps == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"apps" ofType:@"plist"];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        
        NSMutableArray *models = [NSMutableArray array];
        for (NSDictionary *dict in array) {
            QYAppModel *appModel = [QYAppModel appModelWithDictionary:dict];
            [models addObject:appModel];
        }
        _apps = models;
    }
    return _apps;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建一个layout对象
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    //设置属性
    flowLayout.itemSize = CGSizeMake(80, 90);
    //行间距
    flowLayout.minimumLineSpacing = 10.0;
    //item间距
    flowLayout.minimumInteritemSpacing = 0.0;
    
    //section的头尾size,scrollDirection为垂直,Size中的高度起作用;scrollDirection为水平,Size中的宽度起作用
    flowLayout.headerReferenceSize = CGSizeMake(40, 40);
    
    flowLayout.footerReferenceSize = CGSizeMake(40, 40);
    
    //sectionInset
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 20, 0, 20);
    //设置section头视图悬浮
    flowLayout.sectionHeadersPinToVisibleBounds = YES;
    
    //创建并添加collectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:flowLayout];
    [self.view addSubview:collectionView];
    collectionView.backgroundColor = [UIColor lightGrayColor];
    //设置数据源和代理
    collectionView.dataSource = self;
    collectionView.delegate = self;
    
    //注册UICollectionViewCell
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([QYAppCell class]) bundle:nil] forCellWithReuseIdentifier:itemIdentifier];
    
    //注册SupplementaryView
    [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentifier];
    [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerIdentifier];
    
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - UICollectionViewDataSource
//section数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 4;
}
//section中的item数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.apps.count;
}

//item内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    QYAppCell *item = [collectionView dequeueReusableCellWithReuseIdentifier:itemIdentifier forIndexPath:indexPath];
    //获取cell对应的模型
    QYAppModel *model = self.apps[indexPath.item];
    item.appModel = model;
    
    return item;
    
}
//SupplementaryView
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *reusableView = nil;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentifier forIndexPath:indexPath];
        reusableView.backgroundColor = [UIColor redColor];
    }else if ([kind isEqualToString:UICollectionElementKindSectionFooter]){
        reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerIdentifier forIndexPath:indexPath];
        reusableView.backgroundColor = [UIColor blueColor];
    }
    return reusableView;
}

#pragma mark - UICollectionViewDelegateFlowLayout
#if 0
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section;
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section;
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section;
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section;
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section;
#endif

#pragma mark -UICollectionViewDelegate
//允许菜单显示
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
//允许响应哪个action
- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender{
    if (action == @selector(cut:)) {
        return NO;
    }
    return YES;
}
//执行action
- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender{
    if (action == @selector(copy:)) {
        NSLog(@"复制");
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
