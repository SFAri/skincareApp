import 'package:flutter/material.dart';
import 'package:skincare_app/core/enums/routine_time_enum.dart';
import 'package:skincare_app/features/routine/data/routine_repo.dart';
import 'package:skincare_app/features/routine/models/routine.dart';
import 'package:skincare_app/features/routine/models/routine_step.dart';

class RoutinePage extends StatefulWidget {
  const RoutinePage({
    super.key,
    this.haveLeading = false,
    required this.routineId,
  });
  final bool haveLeading;
  final String routineId;

  @override
  State<RoutinePage> createState() => _RoutinePageState();
}

class _RoutinePageState extends State<RoutinePage> {
  late Routine routine;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchRoutine();
  }

  List<RoutineStep> filterSteps(RoutineTime time) =>
      routine.routineSteps.where((e) => e.time == time).toList()
        ..sort((a, b) => a.order.compareTo(b.order));

  Future<void> fetchRoutine() async {
    setState(() => isLoading = true);
    print(widget.routineId);

    final res = await RoutineRepo().getById(widget.routineId);

    setState(() {
      routine = res;
      isLoading = false;
    });
  }

  Widget buildStepItem(RoutineStep step) {
    // sort theo priority (nhỏ nhất = tốt nhất)
    final products = [...step.products]
      ..sort((a, b) => (a.priority ?? 99).compareTo(b.priority ?? 99));

    final mainProduct = products.isNotEmpty ? products.first.product : null;

    print(step.step.toString());

    return ListTile(
      leading: Image.asset(
        'assets/icons/${step.step?.type.toLowerCase()}.png',
        width: 32,
        height: 32,
      ),
      title: Text(
        step.step!.name,
        style: TextStyle(fontWeight: FontWeight.w600),
      ),

      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (step.description != null) Text(step.description!),

          if (mainProduct != null)
            Text(
              'Product: ${mainProduct.name}',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),

          if (products.isNotEmpty && products.first.note != null)
            Text(
              products.first.note!,
              style: TextStyle(fontSize: 12, color: Colors.blueGrey),
            ),
          // if (products.isNotEmpty)
          //   SizedBox(
          //     height: 120,
          //     child: ListView.builder(
          //       scrollDirection: Axis.horizontal,
          //       itemCount: products.length,
          //       itemBuilder: (context, index) {
          //         final p = products[index].product;

          //         if (p == null) return SizedBox();

          //         return Padding(
          //           padding: const EdgeInsets.only(right: 10),
          //           child: CProductCard(
          //             id: p.id,
          //             imageProduct: p.imageUrl ?? '',
          //             productName: p.name,
          //             productBrand: p.brand ?? '',
          //             price: '190000', // nếu có field thì thay
          //           ),
          //         );
          //       },
          //     ),
          //   ),
        ],
      ),
      onTap: () {
        // sau này mở detail product
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Routine'),
        automaticallyImplyLeading: widget.haveLeading,
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children: [
              Text(
                routine.title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                textAlign: TextAlign.center,
              ),
              // --------- Morning Routine ---------
              Text(
                'Morning',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Column(
                children: filterSteps(
                  RoutineTime.MORNING,
                ).map((step) => buildStepItem(step)).toList(),
              ),
              // Column(
              //   children: [
              //     ListTile(
              //       leading: Image.asset(
              //         'assets/icons/cleanser.png',
              //         width: 32,
              //         height: 32,
              //       ),
              //       title: Text('Cleanser'),
              //       subtitle: Text(
              //         'You should use cleanser which sgkssngnnn djjvjdjvdl dvjdkkds dvdvjnjvsfbn fsjvsd',
              //       ),
              //       onTap: () {},
              //     ),
              //     ListTile(
              //       leading: Image.asset(
              //         'assets/icons/serum.png',
              //         width: 32,
              //         height: 32,
              //       ),
              //       title: Text('Vitamin C Serum'),
              //       onTap: () {},
              //     ),
              //     ListTile(
              //       leading: Image.asset(
              //         'assets/icons/sunscreen.png',
              //         width: 32,
              //         height: 32,
              //       ),
              //       title: Text('Suncream'),
              //       onTap: () {},
              //     ),
              //   ],
              // ),

              // --------- Night Routine ---------
              Text(
                textAlign: TextAlign.start,
                'Night',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              // Column(
              //   children: [
              //     ListTile(
              //       leading: Image.asset(
              //         'assets/icons/makeup-remover.png',
              //         width: 32,
              //         height: 32,
              //       ),
              //       title: Text('Makeup remove'),
              //       onTap: () {},
              //     ),
              //     ListTile(
              //       leading: Image.asset(
              //         'assets/icons/cleanser.png',
              //         width: 32,
              //         height: 32,
              //       ),
              //       title: Text('Cleanser'),
              //       onTap: () {},
              //     ),
              //     ListTile(
              //       leading: Image.asset(
              //         'assets/icons/retinol.png',
              //         width: 32,
              //         height: 32,
              //       ),
              //       title: Text('Retinol'),
              //       onTap: () {},
              //     ),
              //     ListTile(
              //       leading: Image.asset(
              //         'assets/icons/moisturizing.png',
              //         width: 32,
              //         height: 32,
              //       ),
              //       title: Text('Moisture cream'),
              //       onTap: () {},
              //     ),
              //   ],
              // ),
              Column(
                children: filterSteps(
                  RoutineTime.NIGHT,
                ).map((step) => buildStepItem(step)).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
