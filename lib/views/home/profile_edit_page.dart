import 'package:flutter/material.dart';

// Example Profile class
class Profile {
  final String name;
  final String email;

  Profile({required this.name, required this.email});
}

class EditProfilePage extends StatefulWidget {
  final Profile profile; // Non-nullable profile parameter

  const EditProfilePage({super.key, required this.profile});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    // Initialize the TextEditingController with the current profile's name
    _nameController = TextEditingController(text: widget.profile.name);
  }

  @override
  void dispose() {
    _nameController.dispose(); // Dispose the controller when the page is closed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Editing Profile: ${widget.profile.name}",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: "Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Handle save or update profile logic
                // For example, you might update the profile object here and send it back to the previous screen
                String updatedName = _nameController.text;

                // Logic to save the updated name, such as updating a database or a state management solution
                Navigator.pop(
                    context, updatedName); // Pass the updated name back
              },
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
