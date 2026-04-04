import 'package:flutter/material.dart';
import 'api_client.dart';

// 👇 GLOBAL INSTANCE
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final ApiClient apiClient = ApiClient(navigatorKey);