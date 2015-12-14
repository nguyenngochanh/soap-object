//
//  ViewController.h
//  Soapservice
//
//  Created by taoxanh on 12/4/15.
//  Copyright © 2015 taoxanh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SoapService.h"
@interface ViewController : UIViewController<SoapServiceDelegate>{
    SoapService *soap;
}

@end

