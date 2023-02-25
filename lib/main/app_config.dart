class AppConfig {
  final String appName;
  final AppFlavor flavor;

  const AppConfig(this.appName, this.flavor);
}

enum AppFlavor {
  dev,
  prod,
}
