import 'package:flutter/material.dart';

void main() {
  runApp(TaskManagerApp());
}

// Main App Widget
class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignInScreen(), // Home screen is the SignInScreen
    );
  }
}

// Sign In Screen Widget
class SignInScreen extends StatefulWidget {
  final String? email; // Email passed from SignUpScreen
  final String? password; // Password passed from SignUpScreen

  const SignInScreen({super.key, this.email, this.password});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController emailController =
      TextEditingController(); // Controller for email field
  final TextEditingController passwordController =
      TextEditingController(); // Controller for password field
  bool rememberMe = false; // Checkbox for "Remember Me" functionality

  @override
  void initState() {
    super.initState();
    // If email and password were passed, set them to the text fields
    if (widget.email != null && widget.password != null) {
      emailController.text = widget.email!;
      passwordController.text = widget.password!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign In"), // Title of the app bar
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage("images/A.jpg"), // Avatar image
                ),
                const SizedBox(height: 20),
                const Text(
                  "Task Manager", // App name text
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: "Email", // Label for email input
                    prefixIcon: const Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: "Password", // Label for password input
                    prefixIcon: const Icon(Icons.lock),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  obscureText: true, // Obscure password input
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Checkbox(
                      value: rememberMe, // Checkbox to remember user login
                      onChanged: (value) {
                        setState(() {
                          rememberMe = value!; // Update rememberMe state
                        });
                      },
                    ),
                    const Text("Remember Me"),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Check if email and password match the ones passed from SignUpScreen
                      if (emailController.text == widget.email &&
                          passwordController.text == widget.password) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TaskManagerPage(),
                          ),
                        );
                      } else {
                        // Show error if credentials don't match
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('Invalid email or password'),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text("Sign In"),
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    // Navigate to SignUpScreen when clicked
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignUpScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    "Don't have an account? Sign Up",
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Sign Up Screen Widget
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String? email;
  String? password;
  String gender = 'Male'; // Default gender value
  double age = 18.0; // Default age
  String maritalStatus = 'Single'; // Default marital status

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final List<String> maritalStatuses = [
    'Single',
    'Married',
    'Divorced',
    'Widowed'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Email input field
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "Email", // Label for email input
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 15),

              // Password input field
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: "Password", // Label for password input
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                obscureText: true, // Obscure password input
              ),
              const SizedBox(height: 15),

              // Gender selection using radio buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text('Gender:'),
                  Radio<String>(
                    value: 'Male',
                    groupValue: gender,
                    onChanged: (value) {
                      setState(() {
                        gender = value!; // Update gender selection
                      });
                    },
                  ),
                  const Text('Male'),
                  Radio<String>(
                    value: 'Female',
                    groupValue: gender,
                    onChanged: (value) {
                      setState(() {
                        gender = value!; // Update gender selection
                      });
                    },
                  ),
                  const Text('Female'),
                ],
              ),
              const SizedBox(height: 15),

              // Age selection using a slider
              const Text('Age:'),
              Slider(
                value: age,
                min: 18.0,
                max: 100.0,
                divisions: 82,
                label: age.round().toString(),
                onChanged: (double newValue) {
                  setState(() {
                    age = newValue; // Update age value
                  });
                },
              ),
              Text('Age: ${age.round()}'),
              const SizedBox(height: 15),

              // Marital status dropdown
              const Text('Marital Status:'),
              DropdownButton<String>(
                value: maritalStatus,
                onChanged: (String? newValue) {
                  setState(() {
                    maritalStatus =
                        newValue!; // Update marital status selection
                  });
                },
                items: maritalStatuses
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const SizedBox(height: 15),

              // Submit button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Save email and password entered
                    email = emailController.text;
                    password = passwordController.text;

                    // Navigate to SignInScreen and pass email and password
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignInScreen(
                          email: email,
                          password: password,
                        ),
                      ),
                    );
                  },
                  child: const Text("Submit"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Task Manager Page Widget
class TaskManagerPage extends StatefulWidget {
  const TaskManagerPage({super.key});

  @override
  _TaskManagerPageState createState() => _TaskManagerPageState();
}

class _TaskManagerPageState extends State<TaskManagerPage>
    with SingleTickerProviderStateMixin {
  final List<String> _activeTasks = []; // List of active tasks
  final List<String> _completedTasks = []; // List of completed tasks
  late TabController _tabController; // Tab controller to manage tabs

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: 2, vsync: this); // Initialize tab controller
  }

  void _addTask(String task) {
    setState(() {
      _activeTasks.add(task); // Add a new task to active tasks
    });
  }

  void _completeTask(int index) {
    setState(() {
      String task =
          _activeTasks.removeAt(index); // Move task from active to completed
      _completedTasks.add(task);
    });
  }

  void _deleteTask(int index, bool isActive) {
    setState(() {
      if (isActive) {
        _activeTasks.removeAt(index); // Remove task from active tasks
      } else {
        _completedTasks.removeAt(index); // Remove task from completed tasks
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Manager'),
        backgroundColor: Colors.blue,
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
                icon: Icon(Icons.list),
                text: 'Active Tasks'), // Tab for active tasks
            Tab(
                icon: Icon(Icons.done),
                text: 'Completed Tasks'), // Tab for completed tasks
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildTaskList(_activeTasks, true), // Active tasks tab content
          _buildTaskList(_completedTasks, false), // Completed tasks tab content
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            _showAddTaskDialog(context), // Show add task dialog when pressed
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildTaskList(List<String> tasks, bool isActive) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return Dismissible(
          key: Key(tasks[index]),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            _deleteTask(index, isActive); // Delete task when dismissed
          },
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Icon(Icons.delete, color: Colors.white), // Delete background
          ),
          child: ListTile(
            title: Text(tasks[index]),
            onTap: isActive
                ? () {
                    _showCompleteTaskDialog(context,
                        index); // Show complete task dialog when active
                  }
                : null,
          ),
        );
      },
    );
  }

  void _showAddTaskDialog(BuildContext context) {
    String newTask = '';
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add New Task'),
          content: TextField(
            onChanged: (value) {
              newTask = value; // Capture new task input
            },
            decoration: InputDecoration(hintText: 'Enter task name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (newTask.isNotEmpty) {
                  _addTask(newTask); // Add new task to list
                }
                Navigator.pop(context); // Close dialog
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _showCompleteTaskDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Complete Task'),
          content: Text('Mark this task as completed?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                _completeTask(index); // Mark task as completed
                Navigator.pop(context); // Close dialog
              },
              child: Text('Complete'),
            ),
          ],
        );
      },
    );
  }
}
