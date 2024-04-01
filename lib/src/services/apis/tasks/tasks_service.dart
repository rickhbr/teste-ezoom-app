import 'package:teste_app/src/entities/task.dart';
import 'package:teste_app/src/services/network/network_service.dart';

class TasksService {
  final _networkService = NetworkService();

  Future<List<dynamic>> getTasks() async {
    try {
      final response = await _networkService.dio.get(
        'https://lychee-cookie-15918-17f2b39d104a.herokuapp.com/api/tasks',
      );
      return response.data;
    } catch (e) {
      return [];
    }
  }

  Future<bool> createTask(Map<String, dynamic> taskData) async {
    try {
      final response = await _networkService.dio.post(
        'https://lychee-cookie-15918-17f2b39d104a.herokuapp.com/api/tasks',
        data: taskData,
      );
      print(response.statusCode);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateTask(Task taskData, {bool? isDone = false}) async {
    try {
      final response = await _networkService.dio.put(
        'https://lychee-cookie-15918-17f2b39d104a.herokuapp.com/api/tasks/${taskData.id}',
        data: {
          "title": taskData.title,
          "description": taskData.description,
          "due_date": taskData.dueDate,
          "status": isDone == true ? "Concluido" : "Pendente"
        },
      );
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> deleteTask(String taskId) async {
    try {
      final response = await _networkService.dio.delete(
        'https://lychee-cookie-15918-17f2b39d104a.herokuapp.com/api/tasks/$taskId',
      );
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
