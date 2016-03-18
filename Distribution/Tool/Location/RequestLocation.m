//
//  RequestLocation.m
//  Distribution
//
//  Created by Hydra on 16/3/18.
//  Copyright © 2016年 distribution. All rights reserved.
//

#import "RequestLocation.h"
#import "CSqlite.h"
#import <CoreLocation/CoreLocation.h>
#import "UIAlertView+Addition.h"
#import "AppDelegate.h"
#import "PersonalMacro.h"
@interface RequestLocation()<CLLocationManagerDelegate>
@property (nonatomic,assign) CLLocationCoordinate2D coordinate;
@property (nonatomic,strong) CLLocationManager *locationManager;
@property (nonatomic,strong) CSqlite *m_sqlite;
@property (nonatomic,assign) BOOL isShowHUD;
/**
 *  表示正在加载中
 */
@property (strong,nonatomic) MBProgressHUD *progressHUD;

@end

@implementation RequestLocation
+(instancetype)shareInstance{
    static RequestLocation *location = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        location = [[RequestLocation alloc] init];
    });
    return location;
}

-(instancetype)init{
    self = [super init];
    if(self){
        [self config];
    }
    return self;
}

-(MBProgressHUD*)progressHUD{
    if(!_progressHUD){
        RootViewController *vc = [AppDelegate getRootController];
        _progressHUD = [[MBProgressHUD alloc] initWithView:vc.view];
        _progressHUD.mode     = MBProgressHUDModeIndeterminate;
        
    }
    return _progressHUD;
}

-(void)config{
    self.m_sqlite = [[CSqlite alloc]init];
    [self.m_sqlite openSqlite];
}

-(void)setIsShowHUD:(BOOL)isShowHUD{
    _isShowHUD = isShowHUD;
    if(_isShowHUD){
        self.progressHUD.labelText = @"正在获取位置...";
        RootViewController *vc = [AppDelegate getRootController];
        [vc.view addSubview:self.progressHUD];
        [self.progressHUD show:YES];
    }
    else{
        [self.progressHUD hide:YES];
    }
}

- (void)openGPSWithHUD:(BOOL)HUD{
    
    if ([CLLocationManager locationServicesEnabled]) { // 检查定位服务是否可用
        if(!self.locationManager){
            self.locationManager = [[CLLocationManager alloc] init];
        }
        
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0){
            if([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined){
                [self.locationManager requestWhenInUseAuthorization];  //调用了这句,就会弹出允许框了.
                return;
            }
        }
        
        CLAuthorizationStatus status =[CLLocationManager authorizationStatus];
        if(status == kCLAuthorizationStatusRestricted || status == kCLAuthorizationStatusDenied){
            [UIAlertView alertWithTitle:[NSString stringWithFormat:@"如需要使用定位服务，请打开设置-%@-定位服务-使用应用期间",Global_NavigationTitleName]];
            return;
        }
        
        self.locationManager.delegate = self;
        self.locationManager.distanceFilter=0.5;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        [self.locationManager startUpdatingLocation]; // 开始定位
        if(HUD){
            self.isShowHUD = YES;
        }
        
    }
    else{
        [UIAlertView alertWithTitle:@"如需要使用定位服务，请打开设置-隐私-定位服务"];
    }
    
}

// 定位成功时调用
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
//    CLLocationCoordinate2D mylocation = newLocation.coordinate;//手机GPS
//    lat.text = [[NSString alloc]initWithFormat:@"%lf",mylocation.latitude];
//    llong.text = [[NSString alloc]initWithFormat:@"%lf",mylocation.longitude];
//    
//    mylocation = [self zzTransGPS:mylocation];///火星GPS
//    self.offLat.text = [[NSString alloc]initWithFormat:@"%lf",mylocation.latitude];
//    self.offLog.text = [[NSString alloc]initWithFormat:@"%lf",mylocation.longitude];
//    
//    //显示火星坐标
//    [self SetMapPoint:mylocation];
    
    /////////获取位置信息
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray* placemarks,NSError *error)
     {
         if (placemarks.count >0   )
         {
             CLPlacemark * plmark = [placemarks objectAtIndex:0];
             
             
             NSString *province = plmark.administrativeArea.length>0?plmark.administrativeArea:@"";  //省
             NSString *city    = plmark.locality.length>0?plmark.locality:@""; //城市
             NSString *district = plmark.subLocality.length>0?plmark.subLocality:@"";//区
//             NSString * country = plmark.country;
//             NSString *road = plmark.thoroughfare.length>0?plmark.thoroughfare:@"";//道路
//             NSString *name = plmark.name.length>0?plmark.name:@""; //地标

             self.location = [NSString stringWithFormat:@"%@%@%@",province,city,district];
             [self.locationManager stopUpdatingLocation];
             self.isShowHUD = NO;
             [[NSNotificationCenter defaultCenter] postNotificationName:Notification_LocationChange object:nil];
         }
         
     }];
    
    
    
}
// 定位失败时调用
- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {
    self.isShowHUD = NO;
}

-(CLLocationCoordinate2D)zzTransGPS:(CLLocationCoordinate2D)yGps
{
    int TenLat=0;
    int TenLog=0;
    TenLat = (int)(yGps.latitude*10);
    TenLog = (int)(yGps.longitude*10);
    NSString *sql = [[NSString alloc]initWithFormat:@"select offLat,offLog from gpsT where lat=%d and log = %d",TenLat,TenLog];
    //    NSLog(sql);
    sqlite3_stmt* stmtL = [self.m_sqlite NSRunSql:sql];
    int offLat=0;
    int offLog=0;
    while (sqlite3_step(stmtL)==SQLITE_ROW)
    {
        offLat = sqlite3_column_int(stmtL, 0);
        offLog = sqlite3_column_int(stmtL, 1);
        
    }
    
    yGps.latitude = yGps.latitude+offLat*0.0001;
    yGps.longitude = yGps.longitude + offLog*0.0001;
    return yGps;
    
    
}
@end
