//
//  PersonViewController.m
//  arriveE
//
//  Created by mibo02 on 17/7/6.
//  Copyright © 2017年 mibo02. All rights reserved.
//

#import "PersonViewController.h"
#import "personfirstCell.h"
#import "personsecondCell.h"
#import "personheadView.h"
#import "LoginViewController.h"
#import "lefttuijianViewController.h"
#import "moneyfirstViewController.h"
#import "arrivesetViewController.h"
#import "myorderViewController.h"
#import "xinyongfenViewController.h"
#import "jifenshopViewController.h"
#import "wanshanziliaoViewController.h"
@interface PersonViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong)NSArray *imageArr;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@end

@implementation PersonViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
-(void)viewWillDisappear:(BOOL)animated{
     [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageArr = @[@"推荐有奖",@"我的任务",@"我的战绩",@"培训提升",@"直到商城",@"在线客服",@"设置"];
    self.navigationController.navigationBar.translucent = NO;
    [self.collectionView registerNib:[UINib nibWithNibName:@"personfirstCell" bundle:nil] forCellWithReuseIdentifier:@"firstcell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"personsecondCell" bundle:nil] forCellWithReuseIdentifier:@"secondcell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"personheadView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"head"];
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return 3;
    } else {
        return 7;
    }
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        personfirstCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"firstcell" forIndexPath:indexPath];
        if (indexPath.row == 0) {
           cell.lab.attributedText = [ZLabel attributedTextArray:@[@"¥100.00\n",@"账户余额"] textColors:@[[UIColor redColor],[UIColor grayColor]] textfonts:@[H17,H13]];
        } else if (indexPath.row == 1){
            cell.lab.attributedText = [ZLabel attributedTextArray:@[@"60\n",@"信用分"] textColors:@[[UIColor redColor],[UIColor grayColor]] textfonts:@[H17,H13]];
        } else {
            cell.lab.attributedText = [ZLabel attributedTextArray:@[@"通过\n",@"签约状态"] textColors:@[[UIColor redColor],[UIColor grayColor]] textfonts:@[H17,H13]];
        }
        
        return cell;
    } else {
        personsecondCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"secondcell" forIndexPath:indexPath];
        cell.iconimg.image = [UIImage imageNamed:self.imageArr[indexPath.item]];
        cell.titlelab.text = self.imageArr[indexPath.item];
        return cell;
    }
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return CGSizeMake(SCREEN_WIDTH / 3, 70);
    } else {
        return CGSizeMake(SCREEN_WIDTH / 4, 100);
    }
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section == 0) {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    } else {
        return UIEdgeInsetsMake(5, 0, 0, 0);
    }
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        personheadView *head = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"head" forIndexPath:indexPath];
        head.subname.layer.borderWidth = 0.5;
        head.subname.layer.borderColor = [UIColor whiteColor].CGColor;
        [head.headbtn addTarget:self action:@selector(headbtnaction:) forControlEvents:(UIControlEventTouchUpInside)];
        return head;
    } else {
        return nil;
    }
    
}
- (void)headbtnaction:(UIButton *)sender
{
    LoginViewController *login = [LoginViewController new];
    [self.navigationController pushViewController:login animated:YES];
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return CGSizeMake(SCREEN_WIDTH, 200);
    } else {
        return CGSizeZero;
    }
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.item == 0) {
            moneyfirstViewController *first = [moneyfirstViewController new];
            [self.navigationController pushViewController:first animated:YES];
        } else if (indexPath.item == 1){
            xinyongfenViewController *xinyong = [xinyongfenViewController new];
            [self.navigationController pushViewController:xinyong animated:YES];
        }
    } else if (indexPath.section == 1){
        if (indexPath.item == 0) {
            lefttuijianViewController *tuijian  = [lefttuijianViewController new];
            [self.navigationController pushViewController:tuijian animated:YES];
        } else if (indexPath.item == 6){
            arrivesetViewController *set = [arrivesetViewController new];
            [self.navigationController pushViewController:set animated:YES];
        } else if (indexPath.row == 1){
            myorderViewController *order = [myorderViewController new];
            [self.navigationController pushViewController:order animated:YES];
        } else if (indexPath.row == 4){
            jifenshopViewController *jifen = [jifenshopViewController new];
            [self.navigationController pushViewController:jifen animated:YES];
        } else if (indexPath.item == 3){
            wanshanziliaoViewController *wanshan = [wanshanziliaoViewController new];
            [self.navigationController pushViewController:wanshan animated:YES];
        }
    }
}
@end
