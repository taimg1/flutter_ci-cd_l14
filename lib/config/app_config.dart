enum BuildEnvironment { dev, staging, prod }

class AppConfig {
  static const String _envKey = 'BUILD_ENV';
  static const String _apiUrlKey = 'API_URL';
  static const String _appNameKey = 'APP_NAME';

  static BuildEnvironment get environment {
    const envString = String.fromEnvironment(_envKey, defaultValue: 'dev');
    return BuildEnvironment.values.firstWhere(
      (e) => e.name == envString,
      orElse: () => BuildEnvironment.dev,
    );
  }

  static String get apiBaseUrl {
    return const String.fromEnvironment(
      _apiUrlKey,
      defaultValue: 'https://api-dev.example.com',
    );
  }

  static bool get isProduction => environment == BuildEnvironment.prod;
  static bool get isDevelopment => environment == BuildEnvironment.dev;
  static bool get isStaging => environment == BuildEnvironment.staging;

  static String get appName {
    const customName = String.fromEnvironment(_appNameKey);
    if (customName.isNotEmpty) {
      return customName;
    }

    switch (environment) {
      case BuildEnvironment.dev:
        return 'MyApp Dev';
      case BuildEnvironment.staging:
        return 'MyApp Staging';
      case BuildEnvironment.prod:
        return 'MyApp';
    }
  }

  static String get environmentName => environment.name.toUpperCase();

  static bool get enableDebugFeatures => !isProduction;

  static String get apiVersion {
    return const String.fromEnvironment('API_VERSION', defaultValue: 'v1');
  }

  static int get apiTimeout {
    return const int.fromEnvironment('API_TIMEOUT', defaultValue: 30);
  }

  static Map<String, dynamic> toJson() {
    return {
      'environment': environmentName,
      'apiBaseUrl': apiBaseUrl,
      'appName': appName,
      'isProduction': isProduction,
      'isDevelopment': isDevelopment,
      'isStaging': isStaging,
      'enableDebugFeatures': enableDebugFeatures,
      'apiVersion': apiVersion,
      'apiTimeout': apiTimeout,
    };
  }

  static void printConfig() {
    // ignore: avoid_print
    print('=== App Configuration ===');
    toJson().forEach((key, value) {
      // ignore: avoid_print
      print('$key: $value');
    });
    // ignore: avoid_print
    print('========================');
  }
}
