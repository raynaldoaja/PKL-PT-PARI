import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/home_controller.dart';
import 'package:pkl_to_do_list/app/routes/app_routes.dart';
class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person, color: Colors.white),
            onPressed: () {
              Get.toNamed(Routes.PROFILE);
            },
          ),
          IconButton(
            icon: const Icon(Icons.lightbulb_outline, color: Colors.white),
            onPressed: () {},
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Center(
              child: Text(
                '00:00',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF8e7fd4),
                  Color(0xFFc0a5d4),
                ],
              ),
            ),
          ),
            Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: kToolbarHeight + 24),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Hari ini',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      DateFormat('EEEE, d MMMM').format(DateTime.now()),
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                  ),
                  child: Obx(
                    () => ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: controller.todos.length,
                      itemBuilder: (context, index) {
                        final todo = controller.todos[index];
                        return _buildTodoListItem(context, todo);
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddTaskDialog(context);
        },
        backgroundColor: const Color(0xFF673AB7),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
  Widget _buildTodoListItem(BuildContext context, TodoItem todo) {
    return Dismissible(
      key: Key(todo.id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20.0),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (direction) {
        controller.deleteTodo(todo.id);
        Get.snackbar(
          'Tugas Dihapus',
          '${todo.title} telah dihapus.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.black.withOpacity(0.7),
          colorText: Colors.white,
        );
      },
      child: Container(
        margin: EdgeInsets.zero,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              color: Color(0xFFE0E0E0),
              width: 0.8,
            ),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                controller.toggleTodoStatus(todo.id);
              },
              child: Icon(
                todo.isCompleted
                    ? Icons.check_circle
                    : Icons.radio_button_unchecked,
                color: todo.isCompleted
                    ? const Color(0xFF8e7fd4)
                    : Colors.grey[400],
                size: 24,
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    todo.title,
                    style: TextStyle(
                      fontSize: 16,
                      decoration: todo.isCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                      color: todo.isCompleted
                          ? Colors.grey[600]
                          : Colors.black87,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        todo.category,
                        style:
                            TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                      if (todo.dueDate != null) ...[
                        const SizedBox(width: 8.0),
                        Icon(Icons.calendar_today,
                            size: 12, color: Colors.grey[600]),
                        const SizedBox(width: 4.0),
                        Text(
                          DateFormat('E, d MMM').format(todo.dueDate!),
                          style:
                              TextStyle(fontSize: 12, color: Colors.grey[600]),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

void _showAddTaskDialog(BuildContext context) {
  String newTitle = '';
  // Reset data dialog setiap kali dialog dibuka
  controller.resetDialogData();

  Get.defaultDialog(
    title: 'Tambah Hal Baru',
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          onChanged: (value) {
            newTitle = value;
          },
          decoration: const InputDecoration(hintText: 'Masukkan Nama Tugas'),
        ),
        const SizedBox(height: 16),
        Obx(
          () => DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              labelText: 'Kategori',
              border: OutlineInputBorder(),
            ),
            value: controller.selectedCategory.value,
            hint: const Text('Pilih Kategori'),
            onChanged: (String? newValue) {
              controller.selectedCategory.value = newValue;
            },
            items: controller.categories.map((String category) {
              return DropdownMenuItem<String>(
                value: category,
                child: Text(category),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 16),
        // Tombol untuk memilih Tanggal (menggunakan Obx)
        Obx(
          () => TextButton(
            onPressed: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: controller.selectedDate.value ?? DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime(2101),
              );
              if (pickedDate != null) {
                controller.selectedDate.value = pickedDate;
              }
            },
            child: Text(
              controller.selectedDate.value != null
                  ? DateFormat('EEEE, d MMMM').format(controller.selectedDate.value!)
                  : 'Pilih Tanggal',
            ),
          ),
        ),
      ],
    ),
    actions: <Widget>[
      TextButton(
        child: const Text('Batal'),
        onPressed: () {
          Get.back();
        },
      ),
      TextButton(
        child: const Text('Simpan'),
        onPressed: () {
          if (newTitle.isNotEmpty && controller.selectedCategory.value != null) {
            //buat memanggil addTodo dengan data lengkap dari controller
            controller.addTodo(
              newTitle,
              category: controller.selectedCategory.value!,
              dueDate: controller.selectedDate.value,
            );
          }
          Get.back();
        },
      ),
    ],
  );
}
}
