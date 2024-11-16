import 'package:get/get.dart';
import 'package:task_manager/Data/Models/Network_Response.dart';
import 'package:task_manager/Data/Models/TaskListModel.dart';
import 'package:task_manager/Data/Services/Network_Caller.dart';
import 'package:task_manager/Data/Utils/Urls.dart';

class CanceledTaskdataController extends GetxController {
  bool isSuccess = false;
  bool _inProgress = false;
  bool get inprogress => _inProgress;
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List _cancelTaskList = [];

  List get cancelTaskList => _cancelTaskList;

  Future<bool> canceledTaskData() async {
    _inProgress = true;
    update();

    final NetworkResponse response =
        await NetworkCaller.getRequest(Urls.showCanceledTask);

    if (response.isSuccess) {
      final TaskListModel taskListModel =
          TaskListModel.fromJson(response.responseData);
      _cancelTaskList = taskListModel.tasklist ?? [];
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();

    return isSuccess;
  }
}