//
//  zhiyeViewController.m
//  arriveE
//
//  Created by mibo02 on 17/7/20.
//  Copyright © 2017年 mibo02. All rights reserved.
//

#import "zhiyeViewController.h"
#import "personsecondCell.h"
@interface zhiyeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionview;

@end

@implementation zhiyeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"职业";
    self.navigationController.navigationBar.translucent = NO;
     [self.collectionview registerNib:[UINib nibWithNibName:@"personsecondCell" bundle:nil] forCellWithReuseIdentifier:@"secondcell"];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 6;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
        personsecondCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"secondcell" forIndexPath:indexPath];
        cell.iconimg.image = [UIImage imageNamed:@"其他"];
        cell.titlelab.text = @"快递员";
        return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
   
    return CGSizeMake(SCREEN_WIDTH / 3, 100);
    
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    
    return UIEdgeInsetsMake(0, 0, 0, 0);
    
}




@end
