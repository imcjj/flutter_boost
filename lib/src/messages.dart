// Copyright (c) 2019 Alibaba Group. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.
// Autogenerated from Pigeon (v3.2.9), do not edit directly.
// See also: https://pub.dev/packages/pigeon
// ignore_for_file: public_member_api_docs, non_constant_identifier_names, avoid_as, unused_import, unnecessary_parenthesis, prefer_null_aware_operators, omit_local_variable_types, unused_shown_name, unnecessary_import
import 'dart:async';
import 'dart:typed_data' show Uint8List, Int32List, Int64List, Float64List;

import 'package:flutter/foundation.dart' show WriteBuffer, ReadBuffer;
import 'package:flutter/services.dart';

class CommonParams {
  CommonParams({
    this.opaque,
    this.key,
    this.pageName,
    this.uniqueId,
    this.arguments,
  });

  bool? opaque;
  String? key;
  String? pageName;
  String? uniqueId;
  Map<String?, Object?>? arguments;

  Object encode() {
    final Map<Object?, Object?> pigeonMap = <Object?, Object?>{};
    pigeonMap['opaque'] = opaque;
    pigeonMap['key'] = key;
    pigeonMap['pageName'] = pageName;
    pigeonMap['uniqueId'] = uniqueId;
    pigeonMap['arguments'] = arguments;
    return pigeonMap;
  }

  static CommonParams decode(Object message) {
    final Map<Object?, Object?> pigeonMap = message as Map<Object?, Object?>;
    return CommonParams(
      opaque: pigeonMap['opaque'] as bool?,
      key: pigeonMap['key'] as String?,
      pageName: pigeonMap['pageName'] as String?,
      uniqueId: pigeonMap['uniqueId'] as String?,
      arguments: (pigeonMap['arguments'] as Map<Object?, Object?>?)
          ?.cast<String?, Object?>(),
    );
  }
}

class StackInfo {
  StackInfo({
    this.ids,
    this.containers,
  });

  List<String?>? ids;
  Map<String?, FlutterContainer?>? containers;

  Object encode() {
    final Map<Object?, Object?> pigeonMap = <Object?, Object?>{};
    pigeonMap['ids'] = ids;
    pigeonMap['containers'] = containers;
    return pigeonMap;
  }

  static StackInfo decode(Object message) {
    final Map<Object?, Object?> pigeonMap = message as Map<Object?, Object?>;
    return StackInfo(
      ids: (pigeonMap['ids'] as List<Object?>?)?.cast<String?>(),
      containers: (pigeonMap['containers'] as Map<Object?, Object?>?)
          ?.cast<String?, FlutterContainer?>(),
    );
  }
}

class FlutterContainer {
  FlutterContainer({
    this.pages,
  });

  List<FlutterPage?>? pages;

  Object encode() {
    final Map<Object?, Object?> pigeonMap = <Object?, Object?>{};
    pigeonMap['pages'] = pages;
    return pigeonMap;
  }

  static FlutterContainer decode(Object message) {
    final Map<Object?, Object?> pigeonMap = message as Map<Object?, Object?>;
    return FlutterContainer(
      pages: (pigeonMap['pages'] as List<Object?>?)?.cast<FlutterPage?>(),
    );
  }
}

class FlutterPage {
  FlutterPage({
    this.withContainer,
    this.pageName,
    this.uniqueId,
    this.arguments,
  });

  bool? withContainer;
  String? pageName;
  String? uniqueId;
  Map<String?, Object?>? arguments;

  Object encode() {
    final Map<Object?, Object?> pigeonMap = <Object?, Object?>{};
    pigeonMap['withContainer'] = withContainer;
    pigeonMap['pageName'] = pageName;
    pigeonMap['uniqueId'] = uniqueId;
    pigeonMap['arguments'] = arguments;
    return pigeonMap;
  }

  static FlutterPage decode(Object message) {
    final Map<Object?, Object?> pigeonMap = message as Map<Object?, Object?>;
    return FlutterPage(
      withContainer: pigeonMap['withContainer'] as bool?,
      pageName: pigeonMap['pageName'] as String?,
      uniqueId: pigeonMap['uniqueId'] as String?,
      arguments: (pigeonMap['arguments'] as Map<Object?, Object?>?)
          ?.cast<String?, Object?>(),
    );
  }
}

class _NativeRouterApiCodec extends StandardMessageCodec {
  const _NativeRouterApiCodec();
  @override
  void writeValue(WriteBuffer buffer, Object? value) {
    if (value is CommonParams) {
      buffer.putUint8(128);
      writeValue(buffer, value.encode());
    } else if (value is FlutterContainer) {
      buffer.putUint8(129);
      writeValue(buffer, value.encode());
    } else if (value is FlutterPage) {
      buffer.putUint8(130);
      writeValue(buffer, value.encode());
    } else if (value is StackInfo) {
      buffer.putUint8(131);
      writeValue(buffer, value.encode());
    } else {
      super.writeValue(buffer, value);
    }
  }

  @override
  Object? readValueOfType(int type, ReadBuffer buffer) {
    switch (type) {
      case 128:
        return CommonParams.decode(readValue(buffer)!);

      case 129:
        return FlutterContainer.decode(readValue(buffer)!);

      case 130:
        return FlutterPage.decode(readValue(buffer)!);

      case 131:
        return StackInfo.decode(readValue(buffer)!);

      default:
        return super.readValueOfType(type, buffer);
    }
  }
}

//joey:向native侧发送消息，和native侧的相应类名字相同但是功能恰好相反
class NativeRouterApi {
  /// Constructor for [NativeRouterApi].  The [binaryMessenger] named argument is
  /// available for dependency injection.  If it is left null, the default
  /// BinaryMessenger will be used which routes to the host platform.
  NativeRouterApi({BinaryMessenger? binaryMessenger})
      : _binaryMessenger = binaryMessenger;

  final BinaryMessenger? _binaryMessenger;

  static const MessageCodec<Object?> codec = _NativeRouterApiCodec();

  Future<void> pushNativeRoute(CommonParams arg_param) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.NativeRouterApi.pushNativeRoute', codec,
        binaryMessenger: _binaryMessenger);
    final Map<Object?, Object?>? replyMap =
        await channel.send(<Object?>[arg_param]) as Map<Object?, Object?>?;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyMap['error'] != null) {
      final Map<Object?, Object?> error =
          (replyMap['error'] as Map<Object?, Object?>?)!;
      throw PlatformException(
        code: (error['code'] as String?)!,
        message: error['message'] as String?,
        details: error['details'],
      );
    } else {
      return;
    }
  }

  Future<void> pushFlutterRoute(CommonParams arg_param) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.NativeRouterApi.pushFlutterRoute', codec,
        binaryMessenger: _binaryMessenger);
    final Map<Object?, Object?>? replyMap =
        await channel.send(<Object?>[arg_param]) as Map<Object?, Object?>?;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyMap['error'] != null) {
      final Map<Object?, Object?> error =
          (replyMap['error'] as Map<Object?, Object?>?)!;
      throw PlatformException(
        code: (error['code'] as String?)!,
        message: error['message'] as String?,
        details: error['details'],
      );
    } else {
      return;
    }
  }

  Future<void> popRoute(CommonParams arg_param) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.NativeRouterApi.popRoute', codec,
        binaryMessenger: _binaryMessenger);
    final Map<Object?, Object?>? replyMap =
        await channel.send(<Object?>[arg_param]) as Map<Object?, Object?>?;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyMap['error'] != null) {
      final Map<Object?, Object?> error =
          (replyMap['error'] as Map<Object?, Object?>?)!;
      throw PlatformException(
        code: (error['code'] as String?)!,
        message: error['message'] as String?,
        details: error['details'],
      );
    } else {
      return;
    }
  }

  Future<StackInfo> getStackFromHost() async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.NativeRouterApi.getStackFromHost', codec,
        binaryMessenger: _binaryMessenger);
    final Map<Object?, Object?>? replyMap =
        await channel.send(null) as Map<Object?, Object?>?;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyMap['error'] != null) {
      final Map<Object?, Object?> error =
          (replyMap['error'] as Map<Object?, Object?>?)!;
      throw PlatformException(
        code: (error['code'] as String?)!,
        message: error['message'] as String?,
        details: error['details'],
      );
    } else if (replyMap['result'] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (replyMap['result'] as StackInfo?)!;
    }
  }

  Future<void> saveStackToHost(StackInfo arg_stack) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.NativeRouterApi.saveStackToHost', codec,
        binaryMessenger: _binaryMessenger);
    final Map<Object?, Object?>? replyMap =
        await channel.send(<Object?>[arg_stack]) as Map<Object?, Object?>?;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyMap['error'] != null) {
      final Map<Object?, Object?> error =
          (replyMap['error'] as Map<Object?, Object?>?)!;
      throw PlatformException(
        code: (error['code'] as String?)!,
        message: error['message'] as String?,
        details: error['details'],
      );
    } else {
      return;
    }
  }

  Future<void> sendEventToNative(CommonParams arg_params) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.NativeRouterApi.sendEventToNative', codec,
        binaryMessenger: _binaryMessenger);
    final Map<Object?, Object?>? replyMap =
        await channel.send(<Object?>[arg_params]) as Map<Object?, Object?>?;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyMap['error'] != null) {
      final Map<Object?, Object?> error =
          (replyMap['error'] as Map<Object?, Object?>?)!;
      throw PlatformException(
        code: (error['code'] as String?)!,
        message: error['message'] as String?,
        details: error['details'],
      );
    } else {
      return;
    }
  }
}

class _FlutterRouterApiCodec extends StandardMessageCodec {
  const _FlutterRouterApiCodec();
  @override
  void writeValue(WriteBuffer buffer, Object? value) {
    if (value is CommonParams) {
      buffer.putUint8(128);
      writeValue(buffer, value.encode());
    } else {
      super.writeValue(buffer, value);
    }
  }

  @override
  Object? readValueOfType(int type, ReadBuffer buffer) {
    switch (type) {
      case 128:
        return CommonParams.decode(readValue(buffer)!);

      default:
        return super.readValueOfType(type, buffer);
    }
  }
}

//joey:接收从native发送过来的消息并且处理，和native侧的相应类名字相同但是功能恰好相反
abstract class FlutterRouterApi {
  static const MessageCodec<Object?> codec = _FlutterRouterApiCodec();

  void pushRoute(CommonParams param);
  void popRoute(CommonParams param);
  void removeRoute(CommonParams param);
  void onForeground(CommonParams param);
  void onBackground(CommonParams param);
  void onNativeResult(CommonParams param);
  void onContainerShow(CommonParams param);
  void onContainerHide(CommonParams param);
  void sendEventToFlutter(CommonParams param);
  void onBackPressed();
  static void setup(FlutterRouterApi? api, {BinaryMessenger? binaryMessenger}) {
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.FlutterRouterApi.pushRoute', codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMessageHandler(null);
      } else {
        channel.setMessageHandler((Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.FlutterRouterApi.pushRoute was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final CommonParams? arg_param = (args[0] as CommonParams?);
          assert(arg_param != null,
              'Argument for dev.flutter.pigeon.FlutterRouterApi.pushRoute was null, expected non-null CommonParams.');
          api.pushRoute(arg_param!);
          return;
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.FlutterRouterApi.popRoute', codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMessageHandler(null);
      } else {
        channel.setMessageHandler((Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.FlutterRouterApi.popRoute was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final CommonParams? arg_param = (args[0] as CommonParams?);
          assert(arg_param != null,
              'Argument for dev.flutter.pigeon.FlutterRouterApi.popRoute was null, expected non-null CommonParams.');
          api.popRoute(arg_param!);
          return;
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.FlutterRouterApi.removeRoute', codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMessageHandler(null);
      } else {
        channel.setMessageHandler((Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.FlutterRouterApi.removeRoute was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final CommonParams? arg_param = (args[0] as CommonParams?);
          assert(arg_param != null,
              'Argument for dev.flutter.pigeon.FlutterRouterApi.removeRoute was null, expected non-null CommonParams.');
          api.removeRoute(arg_param!);
          return;
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.FlutterRouterApi.onForeground', codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMessageHandler(null);
      } else {
        channel.setMessageHandler((Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.FlutterRouterApi.onForeground was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final CommonParams? arg_param = (args[0] as CommonParams?);
          assert(arg_param != null,
              'Argument for dev.flutter.pigeon.FlutterRouterApi.onForeground was null, expected non-null CommonParams.');
          api.onForeground(arg_param!);
          return;
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.FlutterRouterApi.onBackground', codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMessageHandler(null);
      } else {
        channel.setMessageHandler((Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.FlutterRouterApi.onBackground was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final CommonParams? arg_param = (args[0] as CommonParams?);
          assert(arg_param != null,
              'Argument for dev.flutter.pigeon.FlutterRouterApi.onBackground was null, expected non-null CommonParams.');
          api.onBackground(arg_param!);
          return;
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.FlutterRouterApi.onNativeResult', codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMessageHandler(null);
      } else {
        channel.setMessageHandler((Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.FlutterRouterApi.onNativeResult was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final CommonParams? arg_param = (args[0] as CommonParams?);
          assert(arg_param != null,
              'Argument for dev.flutter.pigeon.FlutterRouterApi.onNativeResult was null, expected non-null CommonParams.');
          api.onNativeResult(arg_param!);
          return;
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.FlutterRouterApi.onContainerShow', codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMessageHandler(null);
      } else {
        channel.setMessageHandler((Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.FlutterRouterApi.onContainerShow was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final CommonParams? arg_param = (args[0] as CommonParams?);
          assert(arg_param != null,
              'Argument for dev.flutter.pigeon.FlutterRouterApi.onContainerShow was null, expected non-null CommonParams.');
          api.onContainerShow(arg_param!);
          return;
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.FlutterRouterApi.onContainerHide', codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMessageHandler(null);
      } else {
        channel.setMessageHandler((Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.FlutterRouterApi.onContainerHide was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final CommonParams? arg_param = (args[0] as CommonParams?);
          assert(arg_param != null,
              'Argument for dev.flutter.pigeon.FlutterRouterApi.onContainerHide was null, expected non-null CommonParams.');
          api.onContainerHide(arg_param!);
          return;
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.FlutterRouterApi.sendEventToFlutter', codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMessageHandler(null);
      } else {
        channel.setMessageHandler((Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.FlutterRouterApi.sendEventToFlutter was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final CommonParams? arg_param = (args[0] as CommonParams?);
          assert(arg_param != null,
              'Argument for dev.flutter.pigeon.FlutterRouterApi.sendEventToFlutter was null, expected non-null CommonParams.');
          api.sendEventToFlutter(arg_param!);
          return;
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.FlutterRouterApi.onBackPressed', codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMessageHandler(null);
      } else {
        channel.setMessageHandler((Object? message) async {
          // ignore message
          api.onBackPressed();
          return;
        });
      }
    }
  }
}
