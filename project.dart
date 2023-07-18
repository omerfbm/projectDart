import 'dart:io';

// Global Variables
List restaurants = [];
List users = [];

void main() {
  while (true) {
    print("\nWelcome to the Restaurant Management System!");
    print("1. Restaurant Panel");
    print("2. User Panel");
    print("3. Exit");
    print("Please select an option: ");

    var option = int.tryParse(stdin.readLineSync()!);

    switch (option) {
      case 1:
        restaurantPanel();
        break;
      case 2:
        userPanel();
        break;
      case 3:
        print("Exiting the application. Goodbye!");
        return;
      default:
        print("Invalid option. Please try again.");
    }
  }
}

void restaurantPanel() {
  print("\nRestaurant Panel");
  print("1. Register");
  print("2. Login");
  print("3. Add Food Item");
  print("4. Manage Orders");
  print("5. Go back to the main menu");
  print("Please select an option: ");

  var option = int.tryParse(stdin.readLineSync()!);

  switch (option) {
    case 1:
      registerRestaurant();
      break;
    case 2:
      loginRestaurant();
      break;
    case 3:
      addFoodItem();
      break;
    case 4:
      manageOrders();
      break;
    case 5:
      return;
    default:
      print("Invalid option. Please try again.");
  }

  restaurantPanel();
}

void userPanel() {
  print("\nUser Panel");
  print("1. Register");
  print("2. Login");
  print("3. View Restaurants and Menus");
  print("4. Place Order");
  print("5. Track Order Status");
  print("6. Go back to the main menu");
  print("Please select an option: ");

  var option = int.tryParse(stdin.readLineSync()!);

  switch (option) {
    case 1:
      registerUser();
      break;
    case 2:
      loginUser();
      break;
    case 3:
      viewRestaurants();
      break;
    case 4:
      placeOrder();
      break;
    case 5:
      trackOrderStatus();
      break;
    case 6:
      return;
    default:
      print("Invalid option. Please try again.");
  }

  userPanel();
}

void registerRestaurant() {
  print("Enter restaurant name: ");
  var name = stdin.readLineSync();
  print("Enter email: ");
  var email = stdin.readLineSync();
  print("Enter contact number: ");
  var contact = stdin.readLineSync();
  print("Enter password: ");
  var password = stdin.readLineSync();

  var restaurant = {
    'name': name,
    'email': email,
    'contact': contact,
    'password': password,
    'menu': [],
    'orders': [],
  };

  restaurants.add(restaurant);

  print("Restaurant registered successfully!");
}

void loginRestaurant() {
  print("Enter email: ");
  var email = stdin.readLineSync();
  print("Enter password: ");
  var password = stdin.readLineSync();

  var restaurant = restaurants.firstWhere((r) => r['email'] == email && r['password'] == password, orElse: () => null);

  if (restaurant != null) {
    print("Login successful!");
  } else {
    print("Invalid email or password. Please try again.");
  }
}

void addFoodItem() {
  print("Enter your restaurant's email: ");
  var email = stdin.readLineSync();

  var restaurant = restaurants.firstWhere((r) => r['email'] == email, orElse: () => null);

  if (restaurant == null) {
    print("Restaurant not found.");
    return;
  }

  print("Enter food item name: ");
  var name = stdin.readLineSync();
  print("Enter food item price: ");
  var price = double.tryParse(stdin.readLineSync()!);

  var foodItem = {'name': name, 'price': price};
  restaurant['menu'].add(foodItem);

  print("Food item added to the menu.");
}

void manageOrders() {
  print("Enter your restaurant's email: ");
  var email = stdin.readLineSync();

  var restaurant = restaurants.firstWhere((r) => r['email'] == email, orElse: () => null);

  if (restaurant == null) {
    print("Restaurant not found.");
    return;
  }

  print("Orders: ");
  for (var order in restaurant['orders']) {
    print("${order['foodItem']['name']} - ${order['status']}");
  }
}

void registerUser() {
  print("Enter your name: ");
  var name = stdin.readLineSync();
  print("Enter email: ");
  var email = stdin.readLineSync();
  print("Enter contact number: ");
  var contact = stdin.readLineSync();
  print("Enter password: ");
  var password = stdin.readLineSync();

  var user = {
    'name': name,
    'email': email,
    'contact': contact,
    'password': password,
    'orders': [],
  };

  users.add(user);

  print("User registered successfully!");
}

void loginUser() {
  print("Enter email: ");
  var email = stdin.readLineSync();
  print("Enter password: ");
  var password = stdin.readLineSync();

  var user = users.firstWhere((u) => u['email'] == email && u['password'] == password, orElse: () => null);

  if (user != null) {
    print("Login successful!");
  } else {
    print("Invalid email or password. Please try again.");
  }
}

void viewRestaurants() {
  print("Restaurants: ");
  for (var i = 0; i < restaurants.length; i++) {
    print("${i + 1}. ${restaurants[i]['name']}");
  }
}

void placeOrder() {
  print("Select a restaurant: ");
  var restaurantIndex = int.tryParse(stdin.readLineSync()!)! - 1;

  if (restaurantIndex < 0 || restaurantIndex >= restaurants.length) {
    print("Invalid restaurant selection.");
    return;
  }

  var selectedRestaurant = restaurants[restaurantIndex];

  print("Select a food item: ");
  for (var i = 0; i < selectedRestaurant['menu'].length; i++) {
    print("${i + 1}. ${selectedRestaurant['menu'][i]['name']} - ${selectedRestaurant['menu'][i]['price']}");
  }

  var foodItemIndex = int.tryParse(stdin.readLineSync()!)! - 1;

  if (foodItemIndex < 0 || foodItemIndex >= selectedRestaurant['menu'].length) {
    print("Invalid food item selection.");
    return;
  }

  var selectedFoodItem = selectedRestaurant['menu'][foodItemIndex];

  var order = {'foodItem': selectedFoodItem, 'status': 'Pending'};
  selectedRestaurant['orders'].add(order);

  print("Order placed successfully!");
}

void trackOrderStatus() {
  print("Enter your email: ");
  var email = stdin.readLineSync();

  var user = users.firstWhere((u) => u['email'] == email, orElse: () => null);

  if (user == null) {
    print("User not found.");
    return;
  }

  print("Your Orders: ");
  for (var order in user['orders']) {
    print("${order['foodItem']['name']} - ${order['status']}");
  }
}
