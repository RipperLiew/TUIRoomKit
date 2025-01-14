<!--
 * @Author: adamsfliu
 * @Date: 2024-01-08 19:43:43
 * @LastEditors: adamsfliu
 * @LastEditTime: 2024-01-08 19:43:43
 * @Description: 
-->
English | [简体中文](api_change_log.zh.md)
## Interface Changes
Change Version: v2.0

Change Date: 2024-01-08

### Added classes and attributes
| Type | Name | Description | Version |
|-------|-------|-------|-------|
| Class | TUIRoomDeviceManager | Device testing and management related class | v2.0 |
| Enum | TUISeatMode | TUISeatModeFreeToTake: Free-to-take seat mode, audience can freely take the seat without applying; TUISeatModeApplyToTake: Apply-to-take seat mode, audience needs the consent of the room owner or administrator to take the seat; Note: Only effective when the seat mode (isSeatEnabled = true) is enabled. | v2.0 |
| Enum | TUIExtensionType | getExtension interface parameter, currently only supports TUIExtensionTypeDeviceManager type | v2.0 |
| Error Code | TUIErrorRequestIdRepeat = -2312 | Repeat request error code | v2.0 |
| Error Code | TUIErrorRequestIdConflict = -2313 | Request conflict error code | v2.0 |
| Error Code | TUIErrorSeatNotSupportLinkMic = -2347 | Current mode does not support link mic error code | v2.0 |
| Property | TUIRoomInfo.isSeatEnabled | Whether to support seat mode | v2.0 |
| Property | TUIRoomInfo.seatMode | seat mode | v2.0 |

### Deprecated & new interfaces
| Deprecated Interface | New Interface | Description | Version |
|-------|-------|-------|-------|
| - (void)updateRoomSpeechModeByAdmin:(TUISpeechMode)mode onSuccess:(TUISuccessBlock)onSuccess onError:(TUIErrorBlock)onError | - (void)updateRoomSeatModeByAdmin:(TUISeatMode)seatMode onSuccess:(TUISuccessBlock)onSuccess onError:(TUIErrorBlock)onError | Optimized room seat mode to reduce customer access comprehension cost | v2.0 |
| - (void)onRoomSpeechModeChanged:(NSString *)roomId speechMode:(TUISpeechMode)mode | - (void)onRoomSeatModeChanged:(NSString *)roomId seatMode:(TUISeatMode)seatMode | Optimized room seat mode callback to reduce customer access comprehension cost | v2.0 |
| - (NSInteger)switchCamera:(BOOL)frontCamera | - | It is recommended to use the switchCamera interface in TUIRoomDeviceManager instead | v2.0 |
| - (NSArray<TXMediaDeviceInfo *> * _Nullable)getDevicesList:(TUIMediaDeviceType)type | - | It is recommended to use the getDevicesList interface in TUIRoomDeviceManager instead | v2.0 |
| - (NSInteger)setCurrentDevice:(TUIMediaDeviceType)type deviceId:(NSString *)deviceId | - | It is recommended to use the setCurrentDevice interface in TUIRoomDeviceManager instead | v2.0 |
|-|- (id) getExtension:(TUIExtensionType)extensionType|Newly added getExtension interface, v2.0 version currently only supports getting DeviceManager extension|v2.0|
|-|+ (instancetype)sharedInstance|Create a TUIRoomEngine instance (singleton pattern)|v2.0| 
|-|+ (void)destroySharedInstance|Destroy the TUIRoomEngine instance (singleton pattern)|v2.0|

### Removed interfaces
| Removed Interface | Suggested Usage | Description | Version |
|-------|-------|-------|-------|
| - (instancetype)init | + (instancetype)sharedInstance | It is recommended to use the sharedInstance interface to create a singleton object | v2.0 |
| + (instancetype)new | + (instancetype)sharedInstance | It is recommended to use the sharedInstance interface to create a singleton object | v2.0 |