import 'package:flutter/material.dart';
import 'backend.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'reluv_copilot',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const SplashScreen(), // Set SplashScreen as the initial page
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F9FF), // Background color from palette
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'ReLuv',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: const Color(0xFFE195AB), // Text color from palette
              ),
            ),
            const SizedBox(height: 20),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                const Color(0xFFFFCCE1), // Progress indicator color
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: const Color(0xFFF2F9FF), // Background color from palette
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: const Color(0xFFE195AB), // AppBar color from palette
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to ReLuv',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: const Color(0xFFE195AB), // Text color from palette
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                prefixIcon: const Icon(Icons.email, color: Color(0xFFE195AB)),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
                prefixIcon: const Icon(Icons.lock, color: Color(0xFFE195AB)),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final email = emailController.text;
                final password = passwordController.text;
                final error = await Backend.login(email, password);

                if (error != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(error)),
                  );
                } else {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE195AB), // Button color
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
              child: const Text(
                'Login',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignUpPage()),
                ); // Navigate to Sign Up page
              },
              child: const Text(
                'Don’t have an account? Sign Up',
                style: TextStyle(color: Color(0xFFE195AB)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: const Color(0xFFF2F9FF), // Background color from palette
      appBar: AppBar(
        title: const Text('Sign Up'),
        backgroundColor: const Color(0xFFE195AB), // AppBar color from palette
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Create Your Account',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: const Color(0xFFE195AB), // Text color from palette
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Full Name',
                border: OutlineInputBorder(),
                prefixIcon: const Icon(Icons.person, color: Color(0xFFE195AB)),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                prefixIcon: const Icon(Icons.email, color: Color(0xFFE195AB)),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
                prefixIcon: const Icon(Icons.lock, color: Color(0xFFE195AB)),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final name = nameController.text;
                final email = emailController.text;
                final password = passwordController.text;
                final error = await Backend.signup(name, email, password);

                if (error != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(error)),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Sign up successful!')),
                  );
                  Navigator.pop(context); // Navigate back to login page
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE195AB), // Button color
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
              child: const Text(
                'Sign Up',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Navigate back to login page
              },
              child: const Text(
                'Already have an account? Login',
                style: TextStyle(color: Color(0xFFE195AB)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        backgroundColor: const Color(0xFFE195AB), // AppBar color from palette
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  '💙 Welcome to [App Name] – A Fresh Chapter in Love',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFFE195AB), // Text color from palette
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Love isn't just for the beginning. Sometimes, it's even more meaningful the second time around.",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Whether you’re divorced or widowed, [App Name] is built for you — a community of real people who understand life’s turns and are ready to start a new, beautiful journey.",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 30),
              Text(
                '💬 Why [App Name]?',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFFE195AB),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Respectful Community – Every profile is verified. We value empathy, honesty, and kindness.',
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
              const SizedBox(height: 10),
              Text(
                'Tailored for You – Match with people who understand your journey and want the same things as you.',
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
              const SizedBox(height: 10),
              Text(
                'Safe Space to Heal and Grow – Take your time. There’s no rush. We’re here when you’re ready.',
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
              const SizedBox(height: 30),
              Text(
                '💡 Features You\'ll Love',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFFE195AB),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                '💞 Match by values, not just interests',
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
              const SizedBox(height: 10),
              Text(
                '🗓️ Join curated events and support circles',
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
              const SizedBox(height: 10),
              Text(
                '💬 Guided conversation starters to ease the first step',
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
              const SizedBox(height: 10),
              Text(
                '🔐 Privacy-first approach for your peace of mind',
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE195AB),
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  ),
                  child: const Text(
                    '👉 Start your next chapter today.',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AccountPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE195AB),
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  ),
                  child: const Text(
                    'Go to My Account',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  'You’re not alone — and it’s never too late for love.',
                  style: TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                    color: Colors.black54,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock user data
    final user = {
      'profilePicture': 'https://via.placeholder.com/150',
      'name': 'Jane Doe',
      'age': 29,
      'location': 'New York, USA',
      'bio': 'Lover of sunsets, coffee, and good books. Always up for an adventure.',
      'interests': ['Travel', 'Music', 'Books', 'Photography'],
      'subscription': 'Premium',
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Account'),
        backgroundColor: const Color(0xFFE195AB),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile Picture
              CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(user['profilePicture']! as String),
              ),
              const SizedBox(height: 20),

              // Name, Age, Location
              Text(
                '${user['name']! as String}, ${user['age']! as int}',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFFE195AB),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                user['location']! as String,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 20),

              // Short Bio
              Text(
                user['bio']! as String,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),

              // Interests/Tags
              Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: (user['interests']! as List<String>).map<Widget>((interest) {
                  return Chip(
                    label: Text(interest),
                    backgroundColor: const Color(0xFFFFCCE1),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),

              // Subscription Status
              Text(
                'Subscription: ${user['subscription']}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFFE195AB),
                ),
              ),
              const SizedBox(height: 20),

              // Edit Profile Button
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE195AB),
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                child: const Text(
                  'Edit Profile',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              const SizedBox(height: 30),

              // Settings Section
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Settings',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFFE195AB),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ListTile(
                        leading: const Icon(Icons.privacy_tip, color: Color(0xFFE195AB)),
                        title: const Text('Privacy'),
                        onTap: () {},
                      ),
                      ListTile(
                        leading: const Icon(Icons.notifications, color: Color(0xFFE195AB)),
                        title: const Text('Notifications'),
                        onTap: () {},
                      ),
                      ListTile(
                        leading: const Icon(Icons.logout, color: Color(0xFFE195AB)),
                        title: const Text('Log Out'),
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}