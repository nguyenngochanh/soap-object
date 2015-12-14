//
//  ViewController.m
//  Soapservice
//
//  Created by taoxanh on 12/4/15.
//  Copyright © 2015 taoxanh. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    soap = [[SoapService alloc] init]; //Khoi tao doi tuong SoapService
    soap.delegate = self;
    [self getThuaDat];
}

- (void)getThuaDat{
    NSMutableDictionary *soapObject = [NSMutableDictionary new]; //Khoi tao soapObject
    [soapObject setValue:@"2" forKey:@"SoTo"]; //Set Thuoc tinh cho soapObject
    [soapObject setValue:@"10" forKey:@"SoThua"]; //Set Thuoc tinh cho soapObject
    [soapObject setValue:@"05197" forKey:@"MaDVHC"]; //Set Thuoc tinh cho soapObject
    [soapObject setValue:@"" forKey:@"TenChu"]; //Set Thuoc tinh cho soapObject
    [soapObject setValue:@"admin" forKey:@"MatKhau"]; //Set Thuoc tinh cho soapObject
    [soapObject setValue:@"HOABINH" forKey:@"TenTinh"]; //Set Thuoc tinh cho soapObject
    
    [soap soapActionWithMethod:@"http://xuly.dkcapgiay.elis.dinte/" key:@"GetThongTinThua"]; //Set SoapAction de request: Day la API can request
    
    [soap requestWithSoapObject:soapObject URL:@"http://125.235.8.210:7001/ELIS-dinte.dkcapgiay-context-root/ServiceThuaDatMobilePort"]; //Request de lay du lieu
}
- (void)getQuyenNguoiDung{
    NSMutableDictionary *soapObject = [NSMutableDictionary new]; //Khoi tao soapObject
    [soapObject setValue:@"admin" forKey:@"Tendangnhap"]; //Set Thuoc tinh cho soapObject
    [soapObject setValue:@"admin" forKey:@"Matkhau"]; //Set Thuoc tinh cho soapObject
    
    [soap soapActionWithMethod:@"http://xuly.dkcapgiay.elis.dinte/" key:@"LayQuyenNguoiDung"]; //Set SoapAction de request: Day la API can request
    
    [soap requestWithSoapObject:soapObject URL:@"http://125.235.8.210:7001/ELIS-dinte.dkcapgiay-context-root/ServiceThuaDatMobilePort"]; //Request de lay du lieu
}


//Tra ve ket qua o day
-(void)soapServiceResult:(SoapService *)soapService{
    NSLog(@"ketqua: %@", soapService.requestResult);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
