//
//  Copyright (c) 2017 Open Whisper Systems. All rights reserved.
//

#import "TextSecureKitEnv.h"

NS_ASSUME_NONNULL_BEGIN

static TextSecureKitEnv *TextSecureKitEnvSharedInstance;

@implementation TextSecureKitEnv

@synthesize callMessageHandler = _callMessageHandler,
    contactsManager = _contactsManager,
    messageSender = _messageSender,
    notificationsManager = _notificationsManager,
    preferences = _preferences;

- (instancetype)initWithCallMessageHandler:(id<OWSCallMessageHandler>)callMessageHandler
                           contactsManager:(id<ContactsManagerProtocol>)contactsManager
                             messageSender:(OWSMessageSender *)messageSender
                      notificationsManager:(id<NotificationsProtocol>)notificationsManager
                               preferences:(nonnull id<TSPreferences>)preferences
{
    self = [super init];
    if (!self) {
        return self;
    }

    _callMessageHandler = callMessageHandler;
    _contactsManager = contactsManager;
    _messageSender = messageSender;
    _notificationsManager = notificationsManager;
    _preferences = preferences;

    return self;
}

- (void)setupWithCallMessageHandler:(id<OWSCallMessageHandler>)callMessageHandler
                    contactsManager:(id<ContactsManagerProtocol>)contactsManager
                      messageSender:(OWSMessageSender *)messageSender
               notificationsManager:(id<NotificationsProtocol>)notificationsManager
                        preferences:(id<TSPreferences>)preferences
{
    _callMessageHandler = callMessageHandler;
    _contactsManager = contactsManager;
    _messageSender = messageSender;
    _notificationsManager = notificationsManager;
    _preferences = preferences;
}

+ (instancetype)sharedEnv
{
    NSAssert(TextSecureKitEnvSharedInstance, @"Trying to access shared TextSecureKitEnv before it's been set");
    return TextSecureKitEnvSharedInstance;
}

+ (void)setSharedEnv:(nullable TextSecureKitEnv *)env
{
    @synchronized (self) {
        if (env) {
            NSAssert(TextSecureKitEnvSharedInstance == nil, @"Trying to set shared TextSecureKitEnv which has already been set");
        }

        TextSecureKitEnvSharedInstance = env;
    }
}

#pragma mark - getters

- (id<OWSCallMessageHandler>)callMessageHandler
{
    NSAssert(_callMessageHandler, @"Trying to access the callMessageHandler before it's set.");
    return _callMessageHandler;
}

- (id<ContactsManagerProtocol>)contactsManager
{
    NSAssert(_contactsManager, @"Trying to access the contactsManager before it's set.");
    return _contactsManager;
}

- (OWSMessageSender *)messageSender
{
    NSAssert(_messageSender, @"Trying to access the messageSender before it's set.");
    return _messageSender;
}

- (id<NotificationsProtocol>)notificationsManager
{
    NSAssert(_notificationsManager, @"Trying to access the notificationsManager before it's set.");
    return _notificationsManager;
}

- (id<TSPreferences>)preferences
{
    NSAssert(_preferences, @"Trying to access preferences before it's set.");
    return _preferences;
}

@end

NS_ASSUME_NONNULL_END
