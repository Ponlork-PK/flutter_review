class EmpModel {
  final String name;
  final String age;
  final String position;

  EmpModel({required this.name, required this.age, required this.position});
}

//dialog
// class AddEmployeeDialog extends StatelessWidget {
//   final HomeController controller;
//   const AddEmployeeDialog({super.key, required this.controller});

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: const Text('Add Employee'),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//       content: SingleChildScrollView(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             TextField(
//               controller: controller.textNameEditingController,
//               decoration: const InputDecoration(hintText: 'name'),
//             ),
//             const SizedBox(height: 8),
//             TextField(
//               controller: controller.textAgeEditingController,
//               keyboardType: TextInputType.number,
//               decoration: const InputDecoration(hintText: 'age'),
//             ),
//             const SizedBox(height: 8),
//             TextField(
//               controller: controller.textPositionEditingController,
//               decoration: const InputDecoration(hintText: 'position'),
//             ),
//           ],
//         ),
//       ),
//       actions: [
//         TextButton(
//           onPressed: () => Navigator.pop(context), // returns null
//           child: const Text('Cancel', style: TextStyle(color: Colors.red)),
//         ),
//         TextButton(
//           onPressed: () {
//             final name = controller.textNameEditingController.text.trim();
//             final age  = int.tryParse(controller.textAgeEditingController.text.trim());
//             final pos  = controller.textPositionEditingController.text.trim();

//             if (name.isEmpty || pos.isEmpty) {
//               // quick guard, adjust to your UX
//               ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(content: Text('Name and position are required')),
//               );
//               return;
//             }

//             Navigator.pop(
//               context,
//               Employee(name: name, age: age, position: pos), // <-- return value
//             );
//           },
//           child: const Text('Done', style: TextStyle(fontWeight: FontWeight.bold)),
//         ),
//       ],
//     );
//   }
// }



//Controller
// class HomeController extends GetxController {
//   final textNameEditingController = TextEditingController();
//   final textAgeEditingController = TextEditingController();
//   final textPositionEditingController = TextEditingController();

//   final _setTextNameValue = ''.obs;
//   final _setTextAgeValue = ''.obs;
//   final _setTextPositionValue = ''.obs;

//   void setTextName(String v) => _setTextNameValue.value = v;
//   void setTextAge(String v) => _setTextAgeValue.value = v;
//   void setTextPosition(String v) => _setTextPositionValue.value = v;

//   @override
//   void onClose() {
//     textNameEditingController.dispose();
//     textAgeEditingController.dispose();
//     textPositionEditingController.dispose();
//     super.onClose();
//   }
// }
