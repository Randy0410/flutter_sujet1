import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CommentByIdScreen extends StatefulWidget {
  const CommentByIdScreen({super.key});

  @override
  _CommentByIdScreenState createState() => _CommentByIdScreenState();
}

class _CommentByIdScreenState extends State<CommentByIdScreen> {
  List comments = [];
  TextEditingController idController = TextEditingController();
  bool isLoading = false;

  Future<void> fetchCommentsById(String id) async {
    setState(() {
      isLoading = true;
    });

    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/comments?id=$id'));

    if (response.statusCode == 200) {
      setState(() {
        comments = json.decode(response.body);
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      throw Exception('Erreur de chargement');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Commentaires par ID')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: idController,
              decoration: const InputDecoration(
                labelText: 'Saisir l\'ID du post',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (idController.text.isNotEmpty) {
                  fetchCommentsById(idController.text);
                }
              },
              child: const Text('Rechercher les commentaires'),
            ),
            const SizedBox(height: 20),
            isLoading
                ? const CircularProgressIndicator()
                : Expanded(
                    child: ListView.builder(
                      itemCount: comments.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            comments[index]['name'],
                            style: const TextStyle(color: Colors.blue),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Email: ${comments[index]['email']}',
                                style: const TextStyle(color: Colors.red),
                              ),
                              Text(comments[index]['body']),
                            ],
                          ),
                          isThreeLine: true,
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
