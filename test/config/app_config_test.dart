import 'package:flutter_test/flutter_test.dart';
import 'package:l13/config/app_config.dart';

void main() {
  group('AppConfig', () {
    test('default environment should be dev', () {
      expect(AppConfig.environment, BuildEnvironment.dev);
    });

    test('default API URL should be dev URL', () {
      expect(AppConfig.apiBaseUrl, 'https://api-dev.example.com');
    });

    test('isDevelopment should be true for dev environment', () {
      expect(AppConfig.isDevelopment, isTrue);
    });

    test('isProduction should be false for dev environment', () {
      expect(AppConfig.isProduction, isFalse);
    });

    test('isStaging should be false for dev environment', () {
      expect(AppConfig.isStaging, isFalse);
    });

    test('enableDebugFeatures should be true for non-production', () {
      expect(AppConfig.enableDebugFeatures, isTrue);
    });

    test('appName should return correct name for dev', () {
      expect(AppConfig.appName, 'MyApp Dev');
    });

    test('environmentName should return uppercase environment', () {
      expect(AppConfig.environmentName, 'DEV');
    });

    test('apiVersion should have default value', () {
      expect(AppConfig.apiVersion, 'v1');
    });

    test('apiTimeout should have default value of 30', () {
      expect(AppConfig.apiTimeout, 30);
    });

    test('toJson should return map with all config values', () {
      final json = AppConfig.toJson();

      expect(json, isA<Map<String, dynamic>>());
      expect(json['environment'], isNotNull);
      expect(json['apiBaseUrl'], isNotNull);
      expect(json['appName'], isNotNull);
      expect(json['isProduction'], isNotNull);
      expect(json['isDevelopment'], isNotNull);
      expect(json['isStaging'], isNotNull);
      expect(json['enableDebugFeatures'], isNotNull);
      expect(json['apiVersion'], isNotNull);
      expect(json['apiTimeout'], isNotNull);
    });

    test('toJson should return correct values', () {
      final json = AppConfig.toJson();

      expect(json['environment'], 'DEV');
      expect(json['apiBaseUrl'], 'https://api-dev.example.com');
      expect(json['appName'], 'MyApp Dev');
      expect(json['isProduction'], false);
      expect(json['isDevelopment'], true);
      expect(json['isStaging'], false);
      expect(json['enableDebugFeatures'], true);
      expect(json['apiVersion'], 'v1');
      expect(json['apiTimeout'], 30);
    });

    test('BuildEnvironment enum should have three values', () {
      expect(BuildEnvironment.values.length, 3);
      expect(BuildEnvironment.values, contains(BuildEnvironment.dev));
      expect(BuildEnvironment.values, contains(BuildEnvironment.staging));
      expect(BuildEnvironment.values, contains(BuildEnvironment.prod));
    });

    test('printConfig should not throw', () {
      expect(() => AppConfig.printConfig(), returnsNormally);
    });
  });
}
