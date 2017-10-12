//  Copyright © 2016 Open Whisper Systems. All rights reserved.

#import "OWSDeviceProvisioningService.h"
#import "OWSDeviceProvisioningRequest.h"
#import "TSNetworkManager.h"
#import "TextSecureKitEnv.h"

NS_ASSUME_NONNULL_BEGIN

@interface OWSDeviceProvisioningService ()

@property (nonatomic, readonly) TSNetworkManager *networkManager;

@end

@implementation OWSDeviceProvisioningService

- (instancetype)initWithNetworkManager:(TSNetworkManager *)networkManager
{
    self = [super init];
    if (!self) {
        return self;
    }

    _networkManager = networkManager;

    return self;
}

- (instancetype)init
{
    return [self initWithNetworkManager:[TextSecureKitEnv sharedEnv].networkManager];
}

- (void)provisionWithMessageBody:(NSData *)messageBody
               ephemeralDeviceId:(NSString *)deviceId
                         success:(void (^)())successCallback
                         failure:(void (^)(NSError *))failureCallback
{
    OWSDeviceProvisioningRequest *request =
    [[OWSDeviceProvisioningRequest alloc] initWithMessageBody:messageBody ephemeralDeviceId:deviceId];

    [self.networkManager makeRequest:request
                             success:^(NSURLSessionDataTask *task, id responseObject) {
                                 DDLogVerbose(@"Provisioning request succeeded");
                                 successCallback();
                             }
                             failure:^(NSURLSessionDataTask *task, NSError *error) {
                                 DDLogVerbose(@"Provisioning request failed with error: %@", error);
                                 failureCallback(error);
                             }];
}

@end

NS_ASSUME_NONNULL_END

