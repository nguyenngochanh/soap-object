//
//  SoapService.m
//  Soapservice
//
//  Created by taoxanh on 12/4/15.
//  Copyright © 2015 taoxanh. All rights reserved.
//

#import "SoapService.h"

@implementation SoapService{
    NSMutableData *webResponseData;
    NSString *soapAction;
    NSString *keyOfSoapAction;
}
//- (NSString*)soapString{
//    NSString *sSOAPMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
//    "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//    "<soap:Body>"
//        "<LayQuyenNguoiDung xmlns=\"http://xuly.dkcapgiay.elis.dinte/\">\n"
//        "<Tendangnhap>%@</Tendangnhap>"
//        "<Matkhau>%@</Matkhau>"
//        "</LayQuyenNguoiDung>\n"
//        "</soap:Body>"
//    "</soap:Envelope>", @"admin", @"admin"];
//    
//    return sSOAPMessage;
//}
-(void)soapActionWithMethod:(NSString*)method key:(NSString*)key{
    soapAction = [NSString stringWithFormat:@"<%@ xmlns=\"%@\">",key,method];
    keyOfSoapAction = key;
}
-(NSString*)soapObject:(NSMutableDictionary*)dictionary{
    NSMutableString *soapMessage = [NSMutableString new];
    NSString *part1 = @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
    "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n""<soap:Body>\n";
    NSString *part2 = soapAction;
    NSString *part3 = [NSString stringWithFormat:@"</%@>\n",keyOfSoapAction];
    [soapMessage appendString:part1];
    [soapMessage appendString:part2];
    
    
    for(NSString *key in dictionary.allKeys){
        NSString *part4 = [NSString stringWithFormat:@"<%@>%@</%@>\n",key,[dictionary valueForKey:key], key];
        [soapMessage appendString:part4];
    }
    [soapMessage appendString:part3];
    NSString *part5 = @"</soap:Body>\n" "</soap:Envelope>";
    [soapMessage appendString:part5];
    return soapMessage;
   
}
-(void)requestWithSoapObject:(NSMutableDictionary*)soapObject URL:(NSString*)URL{
    NSString *sSOAPMessage = [self soapObject:soapObject];
    NSURL *sRequestURL = [NSURL URLWithString:URL];
    NSMutableURLRequest *myRequest = [NSMutableURLRequest requestWithURL:sRequestURL];
    NSString *sMessageLength = [NSString stringWithFormat:@"%d", [sSOAPMessage length]];
    
    [myRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    NSString *valueSoapAction = [NSString stringWithFormat:@"%@/%@", soapAction, keyOfSoapAction];
    [myRequest addValue: valueSoapAction forHTTPHeaderField:@"SOAPAction"];
    [myRequest addValue: sMessageLength forHTTPHeaderField:@"Content-Length"];
    [myRequest setHTTPMethod:@"POST"];
    [myRequest setHTTPBody: [sSOAPMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:myRequest delegate:self];
    
    if( theConnection ) {
         webResponseData = [NSMutableData data];
    }else {
        NSLog(@"Some error occurred in Connection");
        
    }
    
    [theConnection start];

}
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [webResponseData  setLength:0];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [webResponseData  appendData:data];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Some error in your Connection. Please try again.");
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"Received Bytes from server: %d", [webResponseData length]);
    NSString *myXMLResponse = [[NSString alloc] initWithBytes: [webResponseData bytes] length:[webResponseData length] encoding:NSUTF8StringEncoding];
    
    _requestResult = [NSDictionary dictionaryWithXMLString:myXMLResponse];
    [_delegate soapServiceResult:self];
    
}
@end
