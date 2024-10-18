
GoRouter is a routing package in Flutter that simplifies navigation by offering declarative routing for different platforms. Below is a comprehensive example demonstrating various features of the GoRouter package, including nested routes, redirection, parameters, query parameters, shell routes, and error handling.

### 1. **Add GoRouter to `pubspec.yaml`**
```yaml
dependencies:
  go_router: ^9.0.0
```

### 2. **Setting Up GoRouter**

Here’s a detailed example of a Flutter app utilizing most of the core features of the GoRouter package.

### 3. **Main Application**
This demonstrates configuring routes, route parameters, query parameters, nested navigation, redirection, and error handling.

```dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final GoRouter _router = GoRouter(
    initialLocation: '/home',
    // Error page for unknown routes
    errorBuilder: (context, state) => ErrorScreen(error: state.error.toString()),

    // Defining routes
    routes: [
      // Home route with a shell route
      ShellRoute(
        navigatorKey: GlobalKey<NavigatorState>(), // Separate navigator for shell
        builder: (context, state, child) {
          return MainShell(child: child);
        },
        routes: [
          GoRoute(
            path: '/home',
            name: 'home',
            builder: (context, state) => HomeScreen(),
          ),
          GoRoute(
            path: '/profile',
            name: 'profile',
            builder: (context, state) => ProfileScreen(),
          ),
        ],
      ),
      // Route with required parameter
      GoRoute(
        path: '/details/:id',
        name: 'details',
        builder: (context, state) {
          final id = state.params['id']!;
          return DetailScreen(id: id);
        },
      ),
      // Route with optional query parameter
      GoRoute(
        path: '/search',
        name: 'search',
        builder: (context, state) {
          final query = state.queryParams['q'];
          return SearchScreen(query: query);
        },
      ),
      // Nested route example
      GoRoute(
        path: '/products',
        name: 'products',
        builder: (context, state) => ProductsScreen(),
        routes: [
          GoRoute(
            path: 'item/:productId',
            name: 'productItem',
            builder: (context, state) {
              final productId = state.params['productId']!;
              return ProductDetailScreen(productId: productId);
            },
          ),
        ],
      ),
    ],

    // Redirect based on conditions
    redirect: (context, state) {
      final isLoggedIn = false; // Example condition
      if (state.location.startsWith('/profile') && !isLoggedIn) {
        return '/login'; // Redirect to login if not authenticated
      }
      return null; // No redirection
    },
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      title: 'GoRouter Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
```

### 4. **Shell Route**
The `MainShell` is used as a shell for displaying a consistent layout (e.g., a bottom navigation bar) across certain routes.

```dart
class MainShell extends StatelessWidget {
  final Widget child;
  
  const MainShell({required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("GoRouter App")),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _getSelectedIndex(context),
        onTap: (index) {
          switch (index) {
            case 0:
              context.go('/home');
              break;
            case 1:
              context.go('/profile');
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
      body: child,
    );
  }

  int _getSelectedIndex(BuildContext context) {
    final location = GoRouter.of(context).location;
    if (location.startsWith('/profile')) {
      return 1;
    }
    return 0;
  }
}
```

### 5. **Individual Screens**

Here are the individual screens that correspond to the different routes.

#### **HomeScreen**
```dart
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Home Page"),
          ElevatedButton(
            onPressed: () => context.go('/details/123'),
            child: Text("Go to Details with ID 123"),
          ),
          ElevatedButton(
            onPressed: () => context.go('/search?q=flutter'),
            child: Text("Search for Flutter"),
          ),
        ],
      ),
    );
  }
}
```

#### **ProfileScreen**
```dart
class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Profile Page"),
    );
  }
}
```

#### **DetailScreen with Route Parameters**
```dart
class DetailScreen extends StatelessWidget {
  final String id;

  const DetailScreen({required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detail Page")),
      body: Center(child: Text("Detail for Item ID: $id")),
    );
  }
}
```

#### **SearchScreen with Query Parameters**
```dart
class SearchScreen extends StatelessWidget {
  final String? query;

  const SearchScreen({this.query});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Search Page")),
      body: Center(child: Text("Search Query: ${query ?? 'No Query'}")),
    );
  }
}
```

#### **ProductsScreen and Nested Product Detail Screen**
```dart
class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Products")),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text("Product $index"),
            onTap: () => context.go('/products/item/$index'),
          );
        },
      ),
    );
  }
}

class ProductDetailScreen extends StatelessWidget {
  final String productId;

  const ProductDetailScreen({required this.productId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Product $productId")),
      body: Center(child: Text("Details for Product ID: $productId")),
    );
  }
}
```

### 6. **Error Handling Screen**
```dart
class ErrorScreen extends StatelessWidget {
  final String error;

  const ErrorScreen({required this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Error")),
      body: Center(child: Text("Error: $error")),
    );
  }
}
```

### Key Features Demonstrated:
1. **Basic Routing**: Simple navigation with `GoRoute`.
2. **Route Parameters**: Passing data via URL segments (e.g., `/details/:id`).
3. **Query Parameters**: Using query strings in URLs (e.g., `/search?q=flutter`).
4. **Nested Routes**: Routes within routes (e.g., `/products/item/:productId`).
5. **Redirection**: Conditional navigation, such as redirecting to `/login` if the user isn’t authenticated.
6. **Error Handling**: Catching unknown routes and displaying an error screen.
7. **Shell Routes**: Persistent layouts (like navigation bars) shared across different routes.

This example demonstrates most of the essential features of the GoRouter package. To share deep links from your Flutter app, you can use the `share_plus` package, which allows you to share text and links with other apps. This is particularly useful for sharing specific screens or content from your app via deep links.

Here's a step-by-step guide on how to implement deep link sharing:

### Step 1: Add Dependencies

Add the `share_plus` package to your `pubspec.yaml` file:

```yaml
dependencies:
  flutter:
    sdk: flutter
  share_plus: ^8.0.0  # Check for the latest version
```

### Step 2: Implement Deep Link Generation

Generate the deep link URL that you want to share. For example, if you want to share a link to a detail page with an ID, you can create a method to generate that URL.

### Example Implementation

Here’s an example where you can share a deep link when a button is pressed:

```dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        path: '/home',
        builder: (context, state) => HomeScreen(),
      ),
      GoRoute(
        path: '/details/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return DetailScreen(id: id);
       

 },
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: _router.routerDelegate,
      routeInformationParser: _router.routeInformationParser,
      title: 'Deep Link Sharing Example',
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Home Page"),
            ElevatedButton(
              onPressed: () {
                final link = 'https://example.com/details/123'; // Deep link
                Share.share('Check out this link: $link');
              },
              child: Text("Share Deep Link"),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final String id;

  const DetailScreen({required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detail Page")),
      body: Center(child: Text("Detail for Item ID: $id")),
    );
  }
}
```

### Key Features of Deep Link Sharing

- **Dynamic Link Creation**: Generate links dynamically based on the content or state of your application.
- **Sharing with Other Apps**: Use Share.share to send the link via messaging, email, social media, etc.

### Conclusion

The GoRouter package provides a robust and flexible way to handle routing in Flutter applications. By leveraging its features alongside deep link sharing, you can create a seamless user experience that promotes easy navigation and content sharing. 