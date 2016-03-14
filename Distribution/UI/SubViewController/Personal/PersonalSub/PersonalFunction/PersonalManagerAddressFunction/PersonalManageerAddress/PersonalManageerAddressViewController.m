//
//  PersonalManageerAddressViewController.m
//  Distribution
//
//  Created by Hydra on 16/3/14.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import "PersonalManageerAddressViewController.h"
#import "NSArray+Addition.h"
#import "AppDelegate.h"
#import "UIColor+Addition.h"
#import "PlaceHolderTextView.h"
#import "CustomInputTextFieldTableViewCell.h"
#import "CustomInputTextViewTableViewCell.h"
#import "PersonalManagerAddressNormalTableViewCell.h"
#import "AreaObject.h"
#import "PersonalViewControllerDelegate.h"
#import "NSString+Addition.h"

static NSString *customInputTextFieldTableViewCellIndentifier = @"customInputTextFieldTableViewCellIndentifier";
static NSString *customInputTextViewTableViewCellIndentifier = @"customInputTextViewTableViewCellIndentifier";
static NSString *personalManagerAddressNormalTableViewCellIndentifier = @"personalManagerAddressNormalTableViewCellIndentifier";

@interface PersonalManageerAddressViewController ()<UITableViewDataSource,UITableViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate,UITextViewDelegate>
@property (nonatomic,weak)IBOutlet UITableView *tableView;
@property (nonatomic,weak)IBOutlet UIPickerView *pickerView;
@property (nonatomic,weak)IBOutlet UIButton *saveButton;
@property (nonatomic,weak)UITextField *consigneeTextField;
@property (nonatomic,weak)UITextField *telephoneTextField;
@property (nonatomic,weak)PlaceHolderTextView *detailAddressTextView;
@property (nonatomic,assign)PersonalManagerAddressType type;
@property (nonatomic,assign)CGPoint tableViewOriginContentOffset;
/**
 *  数据源列表
 */
@property (nonatomic,strong)NSMutableArray *dataTypeArr;
@property (nonatomic,strong)NSMutableDictionary *addressDic;
/**
 *  存放收货地址省市区相对于plist的行数
 */
@property (nonatomic,strong)NSMutableDictionary *addressLocationDic;

//省 数组
@property (strong, nonatomic) NSMutableArray *provinceArr;
//城市 数组
@property (strong, nonatomic) NSMutableArray *cityArr;
//区县 数组
@property (strong, nonatomic) NSMutableArray *areaArr;
@property (strong, nonatomic) AreaObject *locate;
/**
 *  修改时传入的地址所对应列表的索引值
 */
@property (assign, nonatomic) NSInteger addressDicIndex;
@end

@implementation PersonalManageerAddressViewController

-(instancetype)initWithType:(PersonalManagerAddressType)type addressDic:(NSDictionary*)addressDic addressDicIndex:(NSInteger)index{
    self = [super init];
    if(self){
        self.type = type;
        self.addressDic = addressDic.mutableCopy;
        self.addressDicIndex = index;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self navigitionConfig];
    [self UIConfig];
    [self registerCellNib];
    [self configDataTypeArr];
    [self configCacheAddressDic];
    [self pickerDataConfig];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//tableViewCell分割线左边距为0
-(void)viewDidLayoutSubviews
{
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}

- (AreaObject *)locate{
    if (!_locate) {
        _locate = [[AreaObject alloc]init];
    }
    return _locate;
}

#pragma mark - 键盘高度
//键盘出现时受到notification，在参数userinfo中有键盘高度，坐标转为当前view
-(void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    keyboardRect = [self.view convertRect:keyboardRect fromView:nil];
    
    if([self.detailAddressTextView isFirstResponder]){
        //frame相对于键盘以外的高度
        CGFloat withoutKeyboardHeight = self.view.frame.size.height-keyboardRect.size.height-64;
        //tableview内容高度
        CGFloat tableViewRealHeight = self.tableView.contentSize.height;
        if(withoutKeyboardHeight<tableViewRealHeight){
            CGFloat offset = tableViewRealHeight - withoutKeyboardHeight;
            CGPoint newContentOffset = CGPointMake(self.tableViewOriginContentOffset.x, self.tableViewOriginContentOffset.y+offset);
            [self.tableView setContentOffset:newContentOffset animated:YES];
        }
    }
    
    self.pickerView.hidden = YES;
}

-(void)keyboardWillHide:(NSNotification*)notification{
    
}

#pragma mark - 配置数据源列表
-(void)configDataTypeArr{
    self.dataTypeArr = @[@[@(PersonalAddressDetailCellType_consignee),
                           @(PersonalAddressDetailCellType_telephone),
                           @(PersonalAddressDetailCellType_area),
                           @(PersonalAddressDetailCellType_detailAddress),]
                         ].mutableCopy;
    
}

-(void)configCacheAddressDic{
    if(self.type == PersonalManagerAddressType_new){
        self.addressDic         = @{AVUserKey_addressConsignee:@"",
                                    AVUserKey_addressTelephone:@"",
                                    AVUserKey_addressLocation:@"",
                                    AVUserKey_addressDetail:@"",
                                    }.mutableCopy;
        self.addressLocationDic = @{AreaState:@(0),
                                    AreaCity:@(0),
                                    AreaDistricts:@(0),}.mutableCopy;
        [self.addressDic setObject:self.addressLocationDic forKey:AVUserKey_addressLocationDic];
    }
    else{
        NSMutableDictionary *temp = self.addressDic[AVUserKey_addressLocationDic];
        self.addressLocationDic = temp.mutableCopy;
        [self.addressDic setObject:self.addressLocationDic forKey:AVUserKey_addressLocationDic];
    }
}

#pragma mark - configUI
-(void)UIConfig{
    self.title                         = @"收货地址";
    self.tableView.backgroundColor     = Global_TableViewBackgroundColor;
    self.view.backgroundColor          = Global_TableViewBackgroundColor;
    self.tableView.delegate            = self;
    self.tableView.dataSource          = self;
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    self.tableViewOriginContentOffset = CGPointMake(0, -64);
    
    self.pickerView.delegate           = self;
    self.pickerView.dataSource         = self;
    self.pickerView.hidden             = YES;
    
    [self.saveButton setTitle:PersonalManagerAddrestSaveButtonTitle forState:UIControlStateNormal];
    [self.saveButton setBackgroundColor:PersonalManagerAddrestSaveButtonBackgroundColor];
    [self.saveButton setTitleColor:PersonalManagerAddrestSaveButtonTitleColor forState:UIControlStateNormal];
    [self.saveButton.titleLabel setFont:PersonalManagerAddrestSaveButtonFont];
    [self.saveButton addTarget:self action:@selector(saveButtonClick) forControlEvents:UIControlEventTouchUpInside];
}

-(void)navigitionConfig{
    NSArray *leftBarButton = [NSArray navigationItemsReturnWithTarget:self selecter:@selector(returnButtonClick)];
    self.navigationItem.leftBarButtonItems = leftBarButton;
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleBordered target:self action:@selector(saveButtonClick)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
}

#pragma mark - 点击事件
//返回
-(void)returnButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
    [[AppDelegate getRootController] hideTabbar];
}

//保存
-(void)saveButtonClick{
    [self.addressDic setObject:self.consigneeTextField.text forKey:AVUserKey_addressConsignee];
    [self.addressDic setObject:self.telephoneTextField.text forKey:AVUserKey_addressTelephone];
    [self.addressDic setObject:self.detailAddressTextView.text forKey:AVUserKey_addressDetail];
    
    if([self addressVerify]){
        AVUser *user = [AVUser currentUser];
        if(user){
            if(self.type == PersonalManagerAddressType_new){
                [user addAddressWithDic:self.addressDic];
            }
            else{
                [user modifyAddressWithDic:self.addressDic index:self.addressDicIndex];
            }
            [self returnButtonClick];
        }
    }
    
}

//验证
-(BOOL)addressVerify{
    BOOL result = YES;
    NSString *consignee = self.addressDic[AVUserKey_addressConsignee];
    NSString *telephone = self.addressDic[AVUserKey_addressTelephone];
    NSString *detail = self.addressDic[AVUserKey_addressDetail];
    NSString *location = self.addressDic[AVUserKey_addressLocation];
    
    if(consignee.length == 0){
        [MBProgressHUD showError:@"收货人不能为空！"];
        return NO;
    }
    
    if(consignee.length > PersonalManagerAddrestConsigneeMaxLength){
        [MBProgressHUD showError:[NSString stringWithFormat:@"收货人长度不能超过%d位!",PersonalManagerAddrestConsigneeMaxLength]];
        return NO;
    }
    
    if(![telephone validateMobile]){
        [MBProgressHUD showError:@"请输入正确的手机号码！"];
        return NO;
    }
    
    if(location.length == 0){
        [MBProgressHUD showError:@"请选择省，市，区！"];
        return NO;
    }
    
    if(detail.length == 0){
        [MBProgressHUD showError:@"详细地址不能为空！"];
        return NO;
    }
    
    if(detail.length > PersonalManagerAddrestDetailMaxLength){
        [MBProgressHUD showError:[NSString stringWithFormat:@"详细地址长度不能超过%d位!",PersonalManagerAddrestDetailMaxLength]];
        return NO;
    }
    
    return result;
}

#pragma mark - 注册tableView要用到的所有CellNib
-(void)registerCellNib{
    UINib *tableViewTextFieldCellNib = [UINib nibWithNibName:NSStringFromClass([CustomInputTextFieldTableViewCell class]) bundle:nil];
    [self.tableView registerNib:tableViewTextFieldCellNib forCellReuseIdentifier:customInputTextFieldTableViewCellIndentifier];
    
    UINib *tableViewTextViewCellNib = [UINib nibWithNibName:NSStringFromClass([CustomInputTextViewTableViewCell class]) bundle:nil];
    [self.tableView registerNib:tableViewTextViewCellNib forCellReuseIdentifier:customInputTextViewTableViewCellIndentifier];
    
    UINib *tableViewNormalCellNib = [UINib nibWithNibName:NSStringFromClass([PersonalManagerAddressNormalTableViewCell class]) bundle:nil];
    [self.tableView registerNib:tableViewNormalCellNib forCellReuseIdentifier:personalManagerAddressNormalTableViewCellIndentifier];
}


#pragma mark -
-(PersonalAddressDetailCellType)getSpercificTypeWithIndexPath:(NSIndexPath*)indexPath{
    PersonalAddressDetailCellType type;
    if(self.dataTypeArr.count>indexPath.section){
        NSArray *tempArr = self.dataTypeArr[indexPath.section];
        if(tempArr.count>indexPath.row){
            type = (PersonalAddressDetailCellType)[tempArr[indexPath.row] integerValue];
        }
    }
    return type;
}

#pragma mark - UITableViewDelegateAndDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(self.dataTypeArr.count>section){
        NSArray *tempArr = self.dataTypeArr[section];
        return tempArr.count;
    }
    return 0;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataTypeArr.count;
}

//实际高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = PersonalAddrestDetailCellHeight;
    PersonalAddressDetailCellType type = [self getSpercificTypeWithIndexPath:indexPath];
    switch (type) {
        case PersonalAddressDetailCellType_consignee:
        case PersonalAddressDetailCellType_telephone:
        case PersonalAddressDetailCellType_area:
            height = PersonalAddrestDetailCellHeight;
            break;
        case PersonalAddressDetailCellType_detailAddress:
            height = PersonalManagerAddrestTextViewCellHeight;
            break;
        default:
            break;
    }
    
    return height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(tableView.frame), 10)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    CGFloat height = 10;
    return height;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    CGFloat height = 0.1;
    
    return height;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    PersonalAddressDetailCellType type = [self getSpercificTypeWithIndexPath:indexPath];
    switch (type) {
        case PersonalAddressDetailCellType_consignee:
        {
            CustomInputTextFieldTableViewCell *textFieldCell = [self.tableView dequeueReusableCellWithIdentifier:customInputTextFieldTableViewCellIndentifier forIndexPath:indexPath];
            self.consigneeTextField = textFieldCell.textField;
            textFieldCell.textField.delegate = self;
            [textFieldCell setSelectionStyle:UITableViewCellSelectionStyleNone];
            [textFieldCell setType:CustomInputTextFieldCell_consignee];
            textFieldCell.textField.text = [self.addressDic objectForKey:AVUserKey_addressConsignee];
            cell = (UITableViewCell*)textFieldCell;
        }
            break;
        case PersonalAddressDetailCellType_telephone:
        {
            CustomInputTextFieldTableViewCell *textFieldCell = [self.tableView dequeueReusableCellWithIdentifier:customInputTextFieldTableViewCellIndentifier forIndexPath:indexPath];
            self.telephoneTextField = textFieldCell.textField;
            textFieldCell.textField.delegate = self;
            [textFieldCell setSelectionStyle:UITableViewCellSelectionStyleNone];
            [textFieldCell setType:CustomInputTextFieldCell_telephone];
            textFieldCell.textField.text = [self.addressDic objectForKey:AVUserKey_addressTelephone];
            cell = (UITableViewCell*)textFieldCell;
        }
            break;
        case PersonalAddressDetailCellType_area:
        {
            PersonalManagerAddressNormalTableViewCell *normalCell = [self.tableView dequeueReusableCellWithIdentifier:personalManagerAddressNormalTableViewCellIndentifier forIndexPath:indexPath];
            [normalCell setSelectionStyle:UITableViewCellSelectionStyleNone];
            [normalCell resetValueWith:[self.addressDic objectForKey:AVUserKey_addressLocation]];
            cell = (UITableViewCell*)normalCell;
        }
            break;
        case PersonalAddressDetailCellType_detailAddress:
        {
            CustomInputTextViewTableViewCell *textViewCell = [self.tableView dequeueReusableCellWithIdentifier:customInputTextViewTableViewCellIndentifier forIndexPath:indexPath];
            self.detailAddressTextView = textViewCell.textView;
            textViewCell.textView.delegate = self;
            [textViewCell setSelectionStyle:UITableViewCellSelectionStyleNone];
            textViewCell.textView.text = [self.addressDic objectForKey:AVUserKey_addressDetail];
            cell = (UITableViewCell*)textViewCell;
        }
            break;
            
        default:
            break;
    }
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PersonalAddressDetailCellType type = [self getSpercificTypeWithIndexPath:indexPath];
    if(type == PersonalAddressDetailCellType_area){
        self.pickerView.hidden = NO;
        [self.view endEditing:YES];
        [self pickerViewScrollToSpecificRow];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//tableViewCell分割线左边距为12
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if(!self.pickerView.hidden){
        self.pickerView.hidden = YES;
    }
}

#pragma mark - UITextFieldDelegate
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if(textField == self.consigneeTextField){
        [self.addressDic setObject:textField.text forKey:AVUserKey_addressConsignee];
    }
    else if (textField == self.telephoneTextField){
        [self.addressDic setObject:textField.text forKey:AVUserKey_addressTelephone];
    }
    
}

#pragma mark - UITextViewDelegate
-(void)textViewDidEndEditing:(UITextView *)textView{
    if(textView == self.detailAddressTextView){
        [self.addressDic setObject:textView.text forKey:AVUserKey_addressDetail];
    }
}

#pragma mark - pickerView
-(void)pickerViewScrollToSpecificRow{
    if(self.addressLocationDic){
        
        NSInteger stateRow = [self.addressLocationDic[AreaState] integerValue];
        NSInteger cityRow = [self.addressLocationDic[AreaCity] integerValue];
        NSInteger disRow = [self.addressLocationDic[AreaDistricts] integerValue];
        
        self.cityArr = self.provinceArr[stateRow][@"cities"];
        self.areaArr = self.cityArr[cityRow][@"areas"];
        [self.pickerView reloadAllComponents];
        
        [self.pickerView selectRow:stateRow inComponent:0 animated:NO];
        [self.pickerView selectRow:cityRow inComponent:1 animated:NO];
        if(disRow>0){
            [self.pickerView selectRow:disRow inComponent:2 animated:NO];
        }
        
        self.locate.state = self.provinceArr[stateRow][@"state"];
        self.locate.city = self.cityArr[cityRow][@"city"];
        if (self.areaArr.count>disRow) {
            self.locate.district = self.areaArr[disRow];
        }else{
            self.locate.district = @"";
        }
        
        
        [self.addressDic setObject:[NSString stringWithFormat:@"%@",self.locate] forKey:AVUserKey_addressLocation];
        [self.tableView reloadData];
        
    }
}

-(void)pickerDataConfig{
    self.provinceArr = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"area.plist" ofType:nil]].mutableCopy;
    self.cityArr = self.provinceArr[0][@"cities"];
    self.areaArr = self.cityArr[0][@"areas"];
    
    self.locate.state = self.provinceArr[0][@"state"];
    self.locate.city = self.cityArr[0][@"city"];
    if (self.areaArr.count) {
        self.locate.district = self.areaArr[0];
    }else{
        self.locate.district = @"";
    }
}

#pragma mark - pickerView dataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    switch (component) {
        case 0:
            return self.provinceArr.count;
            break;
        case 1:
            return self.cityArr.count;
            break;
        case 2:
            return self.areaArr.count;
            break;
        default:
            return 0;
            break;
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.minimumScaleFactor = 8.0;
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:14]];
    }
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component __TVOS_PROHIBITED{
    switch (component) {
        case 0:
            return [[self.provinceArr objectAtIndex:row] objectForKey:@"state"];
            break;
        case 1:
            return [[self.cityArr objectAtIndex:row] objectForKey:@"city"];
            break;
        case 2:
            if (self.areaArr.count>row) {
                return [self.areaArr objectAtIndex:row];
                break;
            }
        default:
            return  @"";
            break;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component __TVOS_PROHIBITED{
    switch (component) {
        case 0:{
            self.cityArr = self.provinceArr[row][@"cities"];
            [self.pickerView reloadComponent:1];
            [self.pickerView selectRow:0 inComponent:1 animated:YES];
            
            self.areaArr = [[self.cityArr objectAtIndex:0] objectForKey:@"areas"];
            [self.pickerView reloadComponent:2];
            [self.pickerView selectRow:0 inComponent:2 animated:YES];
            
            self.locate.state = self.provinceArr[row][@"state"];
            self.locate.city = self.cityArr[0][@"city"];
            if (self.areaArr.count>0) {
                self.locate.district = self.areaArr[0];
            }else{
                self.locate.district = @"";
            }
            
            [self.addressLocationDic setObject:@(row) forKey:AreaState];
            [self.addressLocationDic setObject:@(0) forKey:AreaCity];
            [self.addressLocationDic setObject:@(0) forKey:AreaDistricts];
            
            break;
        }
        case 1:
        {
            self.areaArr = [[self.cityArr objectAtIndex:row] objectForKey:@"areas"];
            [self.pickerView reloadComponent:2];
            [self.pickerView selectRow:0 inComponent:2 animated:YES];
            
            self.locate.city = self.cityArr[row][@"city"];
            if (self.areaArr.count>0) {
                self.locate.district = self.areaArr[0];
            }else{
                self.locate.district = @"";
            }
            
            [self.addressLocationDic setObject:@(row) forKey:AreaCity];
            [self.addressLocationDic setObject:@(0) forKey:AreaDistricts];
        }
            break;
        case 2:
        {
            if (self.areaArr.count>0) {
                self.locate.district = self.areaArr[row];
            }else{
                self.locate.district = @"";
            }
            
            [self.addressLocationDic setObject:@(row) forKey:AreaDistricts];
        }
            break;
        default:
            break;
    }

    [self.addressDic setObject:[NSString stringWithFormat:@"%@",self.locate] forKey:AVUserKey_addressLocation];
    [self.tableView reloadData];
}

@end
