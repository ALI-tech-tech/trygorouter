import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trygorouter/details_screen.dart';
import 'package:trygorouter/error_screen.dart';
import 'package:trygorouter/home_screen.dart';
import 'package:trygorouter/main_shell.dart';
import 'package:trygorouter/product_screen.dart';
import 'package:trygorouter/profile_screen.dart';
import 'package:trygorouter/search_screen.dart';

void main() {
  runApp(MyApp());
}

/// MyApp is the root widget of the application, which sets up the GoRouter.
class MyApp extends StatelessWidget {
  final GoRouter _router = GoRouter(
    initialLocation: '/home', // The initial route when the app starts.

    // Error page for unknown routes
    errorBuilder: (context, state) => ErrorScreen(error: state.error.toString()),

    // Defining the application's routes
    routes: [
      // ShellRoute is used for creating persistent layouts like bottom navigation bars.
      ShellRoute(
        navigatorKey: GlobalKey<NavigatorState>(), // Separate navigator for shell.
        builder: (context, state, child) {
          return MainShell(child: child); // Main layout with navigation.
        },
        routes: [
          // Home route
          GoRoute(
            path: '/home', // URL path for the home route.
            name: 'home', // Name for referencing this route.
            builder: (context, state) => HomeScreen(), // Widget displayed for this route.
          ),
          // Profile route
          GoRoute(
            path: '/profile', // URL path for the profile route.
            name: 'profile', // Name for referencing this route.
            builder: (context, state) => ProfileScreen(), // Widget displayed for this route.
          ),
        ],
      ),

      // Route with required parameter
      GoRoute(
        path: '/details/:id', // URL path with a required parameter.
        name: 'details', // Name for referencing this route.
        builder: (context, state) {
          final id = state.pathParameters['id']!; // Retrieve the parameter from the path.
          return DetailScreen(id: id); // Widget displayed for this route.
        },
      ),

      // Route with optional query parameter
      GoRoute(
        path: '/search', // URL path for the search route.
        name: 'search', // Name for referencing this route.
        builder: (context, state) {
          final query = state.pathParameters['q']; // Retrieve the query parameter.
          return SearchScreen(query: query); // Widget displayed for this route.
        },
      ),

      // Products route with nested item route
      GoRoute(
        path: '/products', // URL path for the products route.
        name: 'products', // Name for referencing this route.
        builder: (context, state) => ProductsScreen(), // Widget displayed for this route.
        routes: [
          // Nested route for product items
          GoRoute(
            path: 'item/:productId', // URL path with a required parameter for product ID.
            name: 'productItem', // Name for referencing this route.
            builder: (context, state) {
              final productId = state.pathParameters['productId']!; // Retrieve the parameter.
              return ProductDetailScreen(productId: productId); // Widget displayed for this route.
            },
          ),
        ],
      ),
    ],

    // Redirect based on conditions
    redirect: (context, state) {
      final isLoggedIn = false; // Example condition for redirection.
      if (state.uri.toString().startsWith('/profile') && !isLoggedIn) {
        return '/login'; // Redirect to login if not authenticated.
      }
      return null; // No redirection.
    },
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router, // Set the router configuration for the app.
      title: 'GoRouter Example', // Title of the application.
      theme: ThemeData(
        primarySwatch: Colors.blue, // Primary color theme for the app.
      ),
    );
  }
}
